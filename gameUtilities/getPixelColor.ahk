#HotIf WinActive("Minecraft")
global showColorCode := true

CheckColor() {
    if (WinActive("Minecraft")) {
        WinGetClientPos &X, &Y, &W, &H, "Minecraft"
        centerX := W // 2
        centerY := H // 2

        try {
            color := PixelGetColor(centerX, centerY)
            ToolTip("Color: " . color, centerX, centerY - 30)
        } catch Error as e {
            ToolTip("Could not read color", centerX, centerY - 30)
        }
        
    }
}

SetTimer(CheckColor, 100)

F6::ExitApp  ; Press F6 to exit the script