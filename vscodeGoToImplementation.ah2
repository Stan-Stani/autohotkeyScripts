#Requires AutoHotkey v2.0

#SingleInstance Force

; Remap Middle Mouse (Mouse 3) to Ctrl+F12 only when VS Code is active.
; (Ctrl+F12 is VS Code's default: Go to Implementation)
#HotIf IsVSCodeActive()
MButton::Send "^{F12}"
#HotIf

IsVSCodeActive() {
	; Add/remove executables here if you use a different VS Code build.
	return WinActive("ahk_exe Code.exe")
		|| WinActive("ahk_exe Code - Insiders.exe")
		|| WinActive("ahk_exe VSCodium.exe")
}

