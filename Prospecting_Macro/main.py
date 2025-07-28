import subprocess
import configparser
import customtkinter as ctk

# === Global App Setup ===
ctk.set_appearance_mode("dark")

root = ctk.CTk()
root.title("Ejtearo Macro")
root.geometry("600x600")
root.resizable(False, False)

# === Left Frame for Player Stats ===
stat_frame = ctk.CTkFrame(
    master=root,
    fg_color=("#DBDBDB", "#2E2E2E"),
    width=200,
    height=600,
    corner_radius=0
)
stat_frame.pack(side="left", fill="y")
stat_frame.pack_propagate(False)

# === Entry Fields for Player Stats ===
player_stat_entries = [
    ctk.CTkEntry(stat_frame, placeholder_text="Enter Capacity", width=180),
    ctk.CTkEntry(stat_frame, placeholder_text="Enter Dig Strength", width=180),
    ctk.CTkEntry(stat_frame, placeholder_text="Enter Dig Speed", width=180),
    ctk.CTkEntry(stat_frame, placeholder_text="Enter Shake Strength", width=180),
    ctk.CTkEntry(stat_frame, placeholder_text="Enter Shake Speed", width=180)
]

def focus_next_entry(event, current_entry):
    # Allows pressing Enter to move to the next entry.
    try:
        index = player_stat_entries.index(current_entry)
        next_entry = player_stat_entries[index + 1]
        next_entry.focus()
    except (ValueError, IndexError):
        pass  # Reached last entry or not found

for entry in player_stat_entries:
    entry.pack(pady=10, padx=10)
    entry.bind("<Return>", lambda e, ent=entry: focus_next_entry(e, ent))

# === Save Config Function ===
def save_config():
    """Saves current entry values to user_stats.ini"""
    config = configparser.ConfigParser()
    config["UserStats"] = {
        "Capacity": player_stat_entries[0].get(),
        "DigStrength": player_stat_entries[1].get(),
        "DigSpeed": player_stat_entries[2].get(),
        "ShakeStrength": player_stat_entries[3].get(),
        "ShakeSpeed": player_stat_entries[4].get()
    }
    with open("user_stats.ini", "w") as configfile:
        config.write(configfile)

# === Save Button ===
save_button = ctk.CTkButton(
    stat_frame,
    text="Save Stats",
    command=save_config,
    corner_radius=32,
    fg_color="transparent",
    hover_color="#0aa839",
    border_color="#00942c",
    border_width=2,
    text_color=("black", "white")  # Text color for light and dark modes
)
save_button.pack(pady=10)

# === Location Selection ===
location_label = ctk.CTkLabel(
    stat_frame,
    text="Select Location",
    font=("Arial", 14)
)
location_label.pack(pady=(140, 10))

# Create a combobox for location selection
location_menu = ctk.CTkComboBox(
    stat_frame,
    values=["Rubble Creek Sands", "Niggaville", "Other Location 1", "Other Location 2"],
    state="readonly",
    command=lambda value: print(f"Selected location: {value}")
)
location_menu.pack()

# === Theme Selection ===
theme_label = ctk.CTkLabel(
    stat_frame,
    text="Select Theme",
    font=("Arial", 14)
)
theme_label.pack(pady=(10))

# Create a combobox for theme selection
theme_menu = ctk.CTkComboBox(
    stat_frame,
    values=["Dark", "Light", "System"],
    state="readonly",
    command=lambda value: ctk.set_appearance_mode(value.lower())
    )
theme_menu.pack()

# === Main Macro Controls Frame ===
main_frame = ctk.CTkFrame(
    master=root,
    fg_color=("#DBDBDB", "#2E2E2E"),
    width=200,
    height=200,
    corner_radius=0
)
main_frame.place(relx=1.0, rely=0.0, anchor="ne")
main_frame.pack_propagate(False)

# # === Macro Control Buttons ===
# run_button = ctk.CTkButton(
#     master=main_frame,
#     width=180,
#     height=60,
#     corner_radius=30,
#     text="Start/Stop",
#     command=lambda: subprocess.Popen([r"C:\Program Files\AutoHotkey\v2\AutoHotkey.exe", r"C:\Users\Ethan\Documents\MacroDev\Prospecting_Macro\autohotkey\collection_loop.ahk"]),
#     fg_color="#00942c",
#     hover_color="#0aa839",
#     font=("Arial", 24),
# )
# run_button.pack(pady=(26, 0))
# run_button.pack_propagate(False)

# pause_button = ctk.CTkButton(
#     master=main_frame,
#     width=180,
#     height=60,
#     corner_radius=30,
#     text="Pause/Play",
#     # command=lambda: subprocess.Popen(["AutoHotkey.exe", "collection_loop.ahk"]),
#     fg_color="#686868",
#     hover_color="#858585",
#     font=("Arial", 24),
# )
# pause_button.pack(pady=(10, 0))
# pause_button.pack_propagate(False)

# === Tutorial Frame ===
tutorial_frame = ctk.CTkFrame(
    master=root,
    fg_color=("#DBDBDB", "#3C3C3C"),
    width=200,
    height=400,
    corner_radius=0
)
tutorial_frame.place(relx=1.0, rely=1.0, anchor="se")
main_frame.pack_propagate(False)

# === Tutorial Textbox ==
tuto_text = ctk.CTkTextbox(
    master=tutorial_frame,
    scrollbar_button_color="#00942c",
    scrollbar_button_hover_color="#0aa839",
    width=180,
    height=400,
    corner_radius=10,
    font=("Arial", 20),
    text_color=("black", "white"),
    fg_color=("#CFCFCF", "#555555"),
)
tuto_text.pack(pady=10, padx=10)

# Fill the textbox with tutorial content
placeholder_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." * 5
tuto_text.insert("0.0", placeholder_text)
tuto_text.configure(state="disabled")  # Make it read-only

# === Start Main Loop ===
root.mainloop()