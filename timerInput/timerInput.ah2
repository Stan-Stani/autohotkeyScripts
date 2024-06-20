#SingleInstance Force

^+a:: {
    Send "ABCDEFGHIJKL"
}

^+b:: {
    FragInput()
}

FragInput()
{
    Send "{Backspace}"
    Sleep 510
    Send "{Backspace}"
}