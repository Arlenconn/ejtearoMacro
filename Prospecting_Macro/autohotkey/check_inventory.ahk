CoordMode("Pixel", "Screen")  
;ini for checkinventoryfull()
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