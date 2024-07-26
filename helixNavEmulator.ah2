#Requires AutoHotkey v2.0
#SingleInstance Force

; Set "Alt" mask key to something that's not "ctrl"
A_MenuMaskKey := "vkE8"

; Global variable to track if hotkeys are active
global hotkeyEnabled := true

; Variables to track Caps Lock presses
global lastCapsLockPress := 0
global capsLockPressCount := 0

CheckCapsLockPress() {
    global lastCapsLockPress, capsLockPressCount
    currentTime := A_TickCount
    if (currentTime - lastCapsLockPress < 500) {
        capsLockPressCount++
    } else {
        capsLockPressCount := 1
    }
    lastCapsLockPress := currentTime

    if (capsLockPressCount >= 2) {
        ToggleHotkeys()
    }
}

CapsLock:: {
    CheckCapsLockPress()
    if (GetKeyState("CapsLock", "T"))
        SetCapsLockState("Off")
    else
        SetCapsLockState("On")
    return
}

ToggleHotkeys(*) {
    Suspend -1
    if (A_IsSuspended) {
        ToolTip("Hotkeys are suspended")
        SetTimer () => ToggleHotkeys(), -10000
    }
    else
        ToolTip("Hotkeys are active")

    SetTimer () => ToolTip(), -1000

}


; Function to check if the Arc browser is the active window
IsArcBrowserActive() {
    winTitle := WinGetTitle("A")
    return InStr(winTitle, "Arc")
}

; Ctrl + ; to Ctrl + L if Arc browser is active
^;:: {
    if (IsArcBrowserActive()) {
        SendInput(">^l")

    } else {
        SendInput("^;")  ; Send the original hotkey if not in Arc browser
    }
}

<!h:: SendInput("{Left}")
<!l:: SendInput("{Right}")
<!k:: SendInput("{Up}")
<!j:: SendInput("{Down}")
<^h:: SendInput("^{Left}")
<^l:: SendInput("^{Right}")