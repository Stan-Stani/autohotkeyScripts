﻿#Requires AutoHotkey v2.0

; Append to clipboard.
; Ctrl Alt g
^!g:: {
    ; Check that the clipboard contains plain text.
    if !ClipWait(0) {
        MsgBox(
            "Unable to append to the clipboard. `r`n"
            "The clipboard currently contains data in an unknown format. "
            "Only plain text data can be appended to.",
            "Append to Clipboard",
            "OK IconX"
        )
        return
    }

    ; Pop the clipboard's contents.
    data := A_Clipboard
    A_Clipboard := ""

    ; Send Ctrl+C, and wait for the copied data to fill the clipboard.
    Send("^c")

    ; Wait for the clipboard to contain data.
    ; Handle scenarios where plain text data isn't copied.
    has_data := ClipWait(1, 1)
    has_text_data := ClipWait(0)
    if has_data && !has_text_data {
        MsgBox(
            "Unable to append to the clipboard. `r`n"
            "The target application attempted to copy data in an unknown "
            "format to the clipboard. Only plain text data is supported.",
            "Append to Clipboard",
            "OK IconX"
        )
        A_Clipboard := data
        return
    }
    if !has_data {
        MsgBox(
            "Unable to append to the clipboard. `r`n"
            "The target application did not copy any new data to the clipboard.",
            "Append to Clipboard",
            "OK IconX"
        )
        A_Clipboard := data
        return
    }

    ; If data was copied to the clipboard, append it to the previous
    ; clipboard data, and restore the clipboard.
    data .= "`r`n"
    data .= A_Clipboard
    A_Clipboard := data
}