
#Persistent  ; Keep the script running
SetTimer, MoveMouse, 5000  ; Run MoveMouse every 5000 milliseconds (5 seconds)

MoveMouse:
MouseMove, 1, 0, 1, R  ; Move mouse 1 pixel right relative to current position
Sleep, 100  ; Wait 100ms
MouseMove, -1, 0, 1, R  ; Move mouse 1 pixel left relative to current position
return

Esc::ExitApp  ; Press Escape to exit the script