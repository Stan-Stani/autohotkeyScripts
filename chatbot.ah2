#SingleInstance Force
SetTitleMatchMode 2

; "$" hotkey prefix prevents script from triggering itself when it does `Send "{Enter}"`
$Enter::
{
    if (WinActive("Claude"))
    {
        Send "^a"  ; Select all (Ctrl+A)
        Sleep 100  ; Small delay for stability
        Send "^c"  ; Copy (Ctrl+C)
        Sleep 100  ; Small delay for stability
        Send "{Enter}"  ; Send Enter key
        Sleep 100
        WinActivate "ChatGPT"
        if (WinActive("ChatGPT"))
        {
            Send "{Shift down}{Escape}{Shift up}"
            Sleep 100  ; Small delay for stability
            Send "^v"
            Sleep 100
            Send "{Enter}"
            Sleep 100
        }
        WinActivate "Claude"
        return  ; Exit the hotkey without sending "Enter" to other pages
    }
    else
    {
        Send "{Enter}"  ; Send "Enter" key on other pages
    }
}