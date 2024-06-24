#SingleInstance

; Set "Alt" mask key to something that's not "ctrl"
A_MenuMaskKey := "vkE8"

; LAlt + h sends left arrow
<!h::Send "{Left}"

; LAlt + l sends right arrow
<!l::Send "{Right}"

; LAlt + k sends up arrow
<!k::Send "{Up}"

; LAlt + j sends down arrow
<!j::Send "{Down}"

; Ctrl + h to move word by word left
^h::Send "^{Left}"

; Ctrl + l to move word by word right
^l::Send "^{Right}"