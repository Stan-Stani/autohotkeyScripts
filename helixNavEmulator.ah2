#Requires AutoHotkey v2.0
#SingleInstance Force

DebugMsg(msg) {
    debugMode := false
    if (debugMode) {
        ToolTip(msg)
        SetTimer () => ToolTip(), -3000  ; Clear tooltip after 3 seconds
    }
}

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
$^;:: {
    if (IsArcBrowserActive()) {
        SendInput(">^l")

    } else {
        SendInput("^;")  ; Send the original hotkey if not in Arc browser
    }
}


; Define the hotkey: Alt + W
$!w::  ManageArcTab()

ManageArcTab() {
    if (IsArcBrowserActive()) {
        DebugMsg("Closing tab")

        ; Close the current tab
        SendInput "^w"
       

        Sleep 500

        DebugMsg("Attempting to reopen tab")

        ; Reopen the closed tab with the specific key sequence
        ReopenTabWithSequence()

    } else {
        DebugMsg("Not in Arc - Sending original Alt+W")
        SendInput "!w"
    }
}

ReopenTabWithSequence() {
    SendInput "{Ctrl down}"
    Sleep 50
    SendInput "{Shift down}"
    Sleep 50
    SendInput "t"
    Sleep 50
    SendInput "{Shift up}"
    Sleep 50
    SendInput "{Ctrl up}"
}

; Vim like navigation hjkl

; `Alt + h` is equivalent to `Left arrow`
<!h:: SendInput("{Left}")
; etc...
<!l:: SendInput("{Right}")
<!k:: SendInput("{Up}")
<!j:: SendInput("{Down}")

; `Alt + Shift + k` is equivalent to `Up arrow` * 4
<!+k:: SendInput("{Up}{Up}{Up}{Up}")
; etc...
<!+j:: SendInput("{Down}{Down}{Down}{Down}")

; `Ctrl + h` is equivalent to `Ctrl + Left arrow`
<^h:: SendInput("^{Left}")
; etc...
<^l:: SendInput("^{Right}")
<^k:: SendInput("{PgUp}")
<^j:: SendInput("{PgDn}")

;  `Shift + backspace` is equivalent to `Delete` key
+BackSpace:: SendInput("{Del}")
;  `Ctrl + shift + backspace` is equivalent to `Ctrl + Delete` key
^+BackSpace:: SendInput ("^{Del}") 

; `Ctrl + Shift + h` is equivalent to `Home`
<^+h:: SendInput("{Home}")
; etc...
<^+l:: SendInput("{End}")
<^+k:: SendInput("^{Home}")
<^+j:: SendInput("^{End}")
