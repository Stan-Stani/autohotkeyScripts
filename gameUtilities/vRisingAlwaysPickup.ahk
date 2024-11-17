#SingleInstance Force
#HotIf WinActive("VRising")
global isAutoPickingUp := false
global isAutoAttacking := false

temporaryToolTip(Text := '') {
    ToolTip(Text)
    SetTimer(ToolTip, -5000)
}
~MButton::
{
    global isAutoPickingUp := !isAutoPickingUp
    PickUp()
}

PickUp() {
    if (WinActive('VRising') AND isAutoPickingUp) {
        temporaryToolTip('Holding down pick up')
        SendInput('{r down}')
    } else {
        temporaryToolTip('Released pick up')
        SendInput('{r up}')

    }
}

; SetTimer(PickUp, 300)

~LButton::
{

    if (A_PriorHotkey == "~LButton" && A_TimeSincePriorHotkey < 250) {
        global isAutoAttacking := !isAutoAttacking
        if (isAutoAttacking) {
            SetTimer((*) => (
                SendInput('{LButton down}')
            ), -100)

        }

    } else if (isAutoAttacking) {
        global isAutoAttacking := !isAutoAttacking
        SendInput('{LButton up}')
    }
}

~RButton::
{

    if (A_PriorHotkey == "~RButton" && A_TimeSincePriorHotkey < 250) {

        SendInput('{XButton1}')
        SetTimer((*) => (
            SendInput('{XButton2}')
        ), -80)
        

    }
}

Numpad0::
{
    Reload()
}
