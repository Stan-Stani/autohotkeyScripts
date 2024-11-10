SetTitleMatchMode(3)
SetKeyDelay(900)
#HotIf WinActive("Minecraft")
global isAutoMining := false
global isBackPedaling := false


CheckLight() {
    global isAutoMining
    if (WinActive("Minecraft") && isAutoMining) {
        WinGetClientPos &X, &Y, &W, &H, "Minecraft"


        PixelSearch(&WarmGrayMatchX, &WarmGrayMatchY, 0, H * 0.1, W, H * 0.9, 0x302A1F)
        PixelSearch(&GrayMatchX, &GrayMatchY, 0, H * 0.1, W, H * 0.9, 0x505050)

        ; OutputDebug('fx' . MatchX . "`n")
        ; OutputDebug('fy' . MatchY . "`n")


        if (GrayMatchX && GrayMatchY) {
            ; OutputDebug("///" . (FirstMatchX / W) . " " . (FirstMatchY / H) . "`n")
            ToolTip("CoolGray", GrayMatchX, GrayMatchY, 1)
            handleDanger()
        } else if (WarmGrayMatchX && WarmGrayMatchY) {
            ToolTip("WarmGray", WarmGrayMatchX, WarmGrayMatchY, 2)
            handleDanger()
        } else {
            OutputDebug("no match found `n`n")
        }
    }
}

handleDanger() {
    global isAutoMining
    global isBackPedaling

    isAutoMining := false
    Send "{LButton up}"
    Send "{d up}"
    Send "{a down}"
    isBackPedaling := true
}

SetTimer(CheckLight, 700)

XButton1::
{
    if (!isBackPedaling) {
        global isAutoMining
        if isAutoMining {
            Send "{LButton up}"
            Send "{d up}"
            isAutoMining := false
            ; TrayTip "keydown sent"
        } else {
            Send "{LButton down}"
            Send "{d down}"
            isAutoMining := true
            ; TrayTip "keyUP sent"
        }
    }

}


~Space::
{
    ToolTip("", 0, 0, 1)
    ToolTip("", 0, 0, 2)
    OutputDebug("user used space `n")
    global isAutoMining
    global isBackPedaling
    if isAutoMining {
        handleDanger()
    } else if isBackPedaling {
        Send "{a up}"
        isBackPedaling := false
    }
}