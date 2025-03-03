; For some reason this file needs to be directly in 

;you should first Run this, then Read this
;Ctrl + F: jump to #useful stuff

;#SETUP START
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
ListLines Off
SetBatchLines -1
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#KeyHistory 0
#WinActivateForce

Process, Priority,, H

SetWinDelay -1
SetControlDelay -1


;include the library
#Include C:\Users\StanStanislaus\Documents\Stan\Utils\autohotkey\VD.ahk\VD.ahk
; useful stuff
^#j:: VD.goToDesktopNum(1)
^#k:: VD.goToDesktopNum(2)
^#l:: VD.goToDesktopNum(3)
^#;:: VD.goToDesktopNum(4)

;follow your window
; ~MButton & 1:: VD.MoveWindowToDesktopNum("A", 1), VD.goToDesktopNum(1)
; ~MButton & 2:: VD.MoveWindowToDesktopNum("A", 2), VD.goToDesktopNum(2)
; ~MButton & 3:: VD.MoveWindowToDesktopNum("A", 3), VD.goToDesktopNum(3)


;just move window
^#!j:: VD.MoveWindowToDesktopNum("A", 1)
^#!k:: VD.MoveWindowToDesktopNum("A", 2)
^#!l:: VD.MoveWindowToDesktopNum("A", 3)
^#!;:: VD.MoveWindowToDesktopNum("A", 4)

; wrapping / cycle back to first desktop when at the last
^#Numpad1:: VD.goToRelativeDesktopNum(-1)
^#Numpad2:: VD.goToRelativeDesktopNum(+1)

; pin / unpin window
^#p::  VD.TogglePinWindow("A")
