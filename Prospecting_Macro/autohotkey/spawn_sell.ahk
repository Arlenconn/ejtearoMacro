SpawnSell() {
    ToolTip("Selling items...") ; Display tooltip to indicate the script is running
    Sleep(1000) ; Allow time for tooltip to be visible

    ; === Reset Character ===
    Send("{Esc}")
    Sleep(200)
    Send("r")
    Sleep(200)
    Send("{Enter}")
    Sleep(10000)  ; Allow time to respawn

    ; === Enter First Person ===
    Loop 30 {
        Send("{WheelUp}")
    }
    Sleep(300)

    ; === Walk Backward to Approach Lineup Slot ===
    Send("{s down}")
    Sleep(2500)
    Send("{s up}")
    Sleep(300)

    ; === Shimmy to Align  ===
    Loop 26 {
        Send("{d down}")
        Sleep(150)
        Send("{d up}")
        Sleep(80)
        Send("{s down}")
        Sleep(300)
        Send("{s up}")
        Sleep(80)
    }
    Sleep(1000)

    ; === Final Backward Adjustment ===
    Send("{s down}")
    Sleep(1000)
    Send("{s up}")
    Sleep(300)

    ; === Exit First Person Mode ===
    Loop 30 {
        Send("{WheelDown}")
    }
    Sleep(300)

    ; === Move into Merchant Area ===
    Send("{w down}")
    Sleep(700)
    Send("{w up}")

    Send("{a down}")
    Sleep(1000)
    Send("{a up}")

    ; === Interact with Merchant ===
    Send("e")
    Sleep(1000)

    ToolTip("") ; Clear tooltip
    SetTimer(SpawnSell, 0)  ; Stop loop after one full pass
}

    move_mouse_to_sell()  {
        CenterX := 1920 // 2
        CenterY := 1080 // 2

        MouseMove(CenterX + 70, CenterY + 10, 0)
        Sleep(3000)
        Click("left")
        
        MouseMove(CenterX + 70, CenterY - 11, 0)
        Sleep(3000)
        Click("left")
}

F1::SpawnSell() ; Press F1 to run the function
