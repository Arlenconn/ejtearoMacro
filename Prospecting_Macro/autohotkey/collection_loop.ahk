#Requires AutoHotkey v2.0

; === Read User Variables from config.ini ===
configFile := "C:\Users\Ethan\Documents\MacroDev\Prospecting_Macro\user_stats.ini"

Capacity := IniRead(configFile, "UserStats", "Capacity", "0")
DigStrength := IniRead(configFile, "UserStats", "DigStrength", "0")
DigSpeed := IniRead(configFile, "UserStats", "DigSpeed", "0")
ShakeStrength := IniRead(configFile, "UserStats", "ShakeStrength", "0")
ShakeSpeed := IniRead(configFile, "UserStats", "ShakeSpeed", "0")

; === Hotkey to start/stop macro ===
global toggle := false
F1:: {
    global toggle
    toggle := !toggle
    if toggle
        SetTimer(CollectionLoop, 10)
    else
        SetTimer(CollectionLoop, 0)
}

CollectionLoop() {
    ToolTip("Collection Loop started. Press F1 to stop.", 50, 50)
    global Capacity, DigStrength, DigSpeed, ShakeStrength, ShakeSpeed, toggle

    ; Calculate timings
    TimePerPerfectDig := 68 / DigSpeed * 1000 ; ms
    DigsPerPan := Ceil(Capacity / (DigStrength * 1.5))
    ShakeTime := (Capacity / (ShakeStrength * ShakeSpeed)) * 60 * 1000 ; ms

    ; Dig loop
    loop DigsPerPan {
        if !toggle
            return
        Click("left", "down") ; Hold LMB
        Sleep(TimePerPerfectDig)
        Click("left", "up") ; Release LMB
        Sleep(1200)
    }
    Sleep(800) ; After final dig

    ; Walk forward
    Send("{w down}")
    Sleep(500)
    Send("{w up}")

    ; Single left click to bring pan into view
    Click("left")
    Sleep(700)

    ; Shake pan
    Click("left", "down")
    Sleep(ShakeTime)
    Click("left", "up")
    Sleep(3000)

    ; Walk backward
    Send("{s down}")
    Sleep(500)
    Send("{s up}")

    ToolTip("") ; Clear tooltip at end

    return
}