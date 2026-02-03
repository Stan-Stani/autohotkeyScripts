#Requires AutoHotkey v2.0

/**
 * Maintained/updated with assistance from GitHub Copilot (GPT-5.2).
 */

; Toggle a URL in the clipboard between:
;   https://<LAN_IP>:<port>/<path>  <->  http://localhost:<port>/<path>
; Ctrl Alt I
^!i:: {
    if !ClipWait(0) {
        MsgBox(
            "Clipboard does not contain plain text.",
            "ipToFromLocalhost",
            "OK IconX"
        )
        return
    }

    original := A_Clipboard
    updated := ToggleLocalhostIpInText(original)

    if (updated = original) {
        MsgBox(
            "No matching URL found to toggle (expected http(s)://localhost... or http(s)://<ipv4>...).",
            "ipToFromLocalhost",
            "OK Iconi"
        )
        return
    }

    A_Clipboard := updated
}

ToggleLocalhostIpInText(text) {
    ; Change this to your machine's LAN IP (the one you want to map localhost to).
    static LAN_IP := "192.168.11.49"

    ; First try: clipboard is just a URL.
    trimmed := Trim(text)
    toggledUrl := ToggleUrlHost(trimmed, LAN_IP)
    if (toggledUrl != "")
        return (trimmed = text) ? toggledUrl : ReplaceFirst(text, trimmed, toggledUrl)

    ; Second try: replace the first URL found inside the text.
    ; Keep it conservative: stop at whitespace/quotes/brackets.
    if RegExMatch(text, "i)(https?://[^\s`"'<>]+)", &m) {
        url := m[1]
        toggledUrl := ToggleUrlHost(url, LAN_IP)
        if (toggledUrl != "")
            return ReplaceFirst(text, url, toggledUrl)
    }

    return text
}

ReplaceFirst(haystack, needle, replacement) {
    pos := InStr(haystack, needle)
    if !pos
        return haystack
    return SubStr(haystack, 1, pos - 1) replacement SubStr(haystack, pos + StrLen(needle))
}

ToggleUrlHost(url, lanIp) {
    if !RegExMatch(url, "i)^(https?)://([^/:?#]+)(:\d+)?([^?#]*)?(\?[^#]*)?(#.*)?$", &m)
        return ""

    scheme := m[1]
    host := m[2]
    port := m[3]
    path := m[4]
    query := m[5]
    frag := m[6]

    if (port = "")
        port := ""
    if (path = "")
        path := ""
    if (query = "")
        query := ""
    if (frag = "")
        frag := ""

    hostLower := StrLower(host)
    if (hostLower = "localhost" || hostLower = "127.0.0.1") {
        ; localhost -> LAN IP, and prefer https per request.
        return "https://" lanIp port path query frag
    }

    ; Any IPv4 -> localhost, and prefer http per request.
    if RegExMatch(host, "^\d{1,3}(?:\.\d{1,3}){3}$") {
        return "http://localhost" port path query frag
    }

    return ""
}