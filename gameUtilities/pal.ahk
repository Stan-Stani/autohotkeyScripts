
; Hold f down
isFActive := false
XButton2:: {
    global isFActive
    if (not isFActive) {
        Send "{f down}"
        isFActive := true
    } else {
        send "{f up}"
        isFActive := false
    }
}


; ; Hold mouse 1 down
isM1Active := false
XButton1:: {
    global isM1Active
    if (not isM1Active) {
        MouseClick "Left", , , , , "Down"
        isM1Active := true
    } else {
        MouseClick "Left", , , , , "Up"
        isM1Active := false
    }
}



