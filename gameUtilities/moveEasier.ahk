#SingleInstance Force
#HotIf WinActive("Minecraft")
global showColorCode := true

global isHoldingForward := false
global hasDoubleTappedAndHeldForward := false

ToolTip("Reload")
Sleep 500
ToolTip()

XButton2::
{
    if (!isHoldingForward) {
        SendInput("{d down}")  
        Sleep(100)
        SendInput("{d up}")  
        Sleep(100)
        SendInput("{d down}")    
    } else {
        SendInput("{d up}")    
    }
    global isHoldingForward := !isHoldingForward
    
}

XButton1::
{
    if (!isHoldingForward) {
        SendInput("{d down}")  ; Press and hold S key
    } else {
        SendInput("{d up}")    ; Release S key
    }
    global isHoldingForward := !isHoldingForward
}

Numpad9::
{
    Reload()
  
}