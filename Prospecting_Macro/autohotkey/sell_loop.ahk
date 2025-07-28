reset_character() {
    ; Press ESC key
    Send("{Esc down}")
    Sleep(50)
    Send("{Esc up}")
    Sleep(1000)

    ; Press 'r' key
    Send("r")
    Sleep(200)

    ; Press Enter key
    Send("{Enter}")
    Sleep(200)
}

move_to_merchant() {

    Sleep(4000)   
    Send("{WheelUp 20}")
    Sleep(1000)
    Send("{WheelUp 20}")
    Sleep(500)


    Send("{s down}")
    Sleep(2400)
    Send("{s up}")
    
    Loop 26 {
        Send("{d down}")
        Sleep(180)
        Send("{d up}")

        Send("{s down}")
        Sleep(330)
        Send("{s up}")
    }

    Send("{s down}")
    Sleep(1000)
    Send("{s up}")

    Send("{WheelDown 20}")
    Sleep(1500)
    Send("{WheelDown 20}")
    Sleep(700)

    Send("{w down}")
    Sleep(700)
    Send("{w up}")
    Sleep(100)

    Send("{a down}")
    Sleep(1000)
    Send("{a up}")
    Sleep(100)

    Send("e")
    Sleep(100)
}



CoordMode("Pixel", "Screen")  

InventoryFullColor := 0xE20000 
InputX := 845
InputY := 737

SetTimer(CheckInventoryFull, 1000)  

startTime := A_TickCount
global failTime := 600  

CheckInventoryFull() {
    global startTime, failTime, InventoryFullColor, InputX, InputY
    
    color := PixelGetColor(845, 737, "RGB")

    ToolTip("Pixel color at " . InputX . "," . InputY . " is " . color,  50,  50)
    
    if (color = InventoryFullColor) {

        
        startTime := A_TickCount
    } else if ((A_TickCount - startTime) > (failTime * 1000)) {
        MsgBox("Fail time reached, stopping script.")
        ExitApp
    }
}




