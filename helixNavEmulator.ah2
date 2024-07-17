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
    global hotkeyEnabled
    hotkeyEnabled := !hotkeyEnabled
    if (hotkeyEnabled) {
        ToolTip("Hotkeys Enabled")
    } else {
        ToolTip("Hotkeys Disabled")
    }
    SetTimer () => ToolTip(), -1000
}

; Custom hotkeys
toggleHotkey(hotkeyStr, action) {
    Hotkey(hotkeyStr, action, "On")

    toggleHotkeyFunc(*) {
        if (hotkeyEnabled) {
            Hotkey(hotkeyStr, "On")
        } else {
            Hotkey(hotkeyStr, "Off")
        }
    }

    toggleHotkeyFunc()
    SetTimer(toggleHotkeyFunc, 100)
}

toggleHotkey("<!h", (*) => SendInput("{Left}"))
toggleHotkey("<!l", (*) => SendInput("{Right}"))
toggleHotkey("<!k", (*) => SendInput("{Up}"))
toggleHotkey("<!j", (*) => SendInput("{Down}"))
toggleHotkey("^h", (*) => SendInput("^{Left}"))
toggleHotkey("^l", (*) => SendInput("^{Right}"))