#SingleInstance

; Set "Alt" mask key to something that's not "ctrl"
A_MenuMaskKey := "vkE8"

; Define a toggle variable
global toggle := false

; Define the toggle function
ToggleHotkeys() {
    global toggle
    toggle := !toggle
    if (toggle) {
        ToolTip("Hotkeys Enabled")
    } else {
        ToolTip("Hotkeys Disabled")
    }
    SetTimer(RemoveToolTip, -1000)
}

; Define the tooltip removal function
RemoveToolTip() {
    ToolTip()
}

; Toggle hotkeys when F12 is pressed, but don't block F12
F12:: {
    ToggleHotkeys()
    Send("{F12}")
}

; LAlt + h sends left arrow
<!h:: {
    if (toggle) {
        Send("{Left}")
    }
}

; LAlt + l sends right arrow
<!l:: {
    if (toggle) {
        Send("{Right}")
    }
}

; LAlt + k sends up arrow
<!k:: {
    if (toggle) {
        Send("{Up}")
    }
}

; LAlt + j sends down arrow
<!j:: {
    if (toggle) {
        Send("{Down}")
    }
}

; Ctrl + h to move word by word left
^h:: {
    if (toggle) {
        Send("^({Left})")
    }
}

; Ctrl + l to move word by word right
^l:: {
    if (toggle) {
        Send("^({Right})")
    }
}
