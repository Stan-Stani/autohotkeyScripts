#SingleInstance Force
#HotIf WinActive("Minecraft")
global showColorCode := true

global isAutoFishing := false
global hasReeled := false

Control::
{
    global hasReeled := false
    global isAutoFishing := !isAutoFishing
   
    ToolTip("Mouse button 4 pressed! " . isAutoFishing)
}

Numpad0:: 
{
    Reload()
}

Numpad9:: {
    Pause()
    
}

Numpad3::
{
    Click('Right')
}

CheckColor() {
    if (WinActive("Minecraft")) {

        ; Auto reload every 5 seconds
        SetTimer(() => Reload(), 5000)
        WinGetClientPos &X, &Y, &W, &H, "Minecraft"
        centerX := W // 2
        centerY := H // 2

        try {
            color := PixelGetColor(centerX, centerY)
            colorHex := Format("{:06X}", color)    ; Convert to hex string
            red := SubStr(colorHex, 1, 2)          ; First two characters are red
            redInt := Integer("0x" . red)          ; Convert hex to integer
            ToolTip("Red: " . redInt, centerX, centerY - 30)

            if (isAutoFishing AND !hasReeled AND redInt < 50) {
                ToolTip("REELING " . redInt, centerX + 30, centerY + 30)
                Click('Right')
                global hasReeled := true
                SetTimer((*) => (
                    OutputDebug('ahk: casting')
                    Click('Right')
                    SetTimer((*) => (
                        hasReeled := false
                    ), -4000)
                ), -400)
            }
        } catch Error as e {
            ; ToolTip("Could not read color", centerX, centerY - 30)
        }
    }
}

SetTimer(CheckColor, 100)

F6:: ExitApp  ; Press F6 to exit the script
