#Requires AutoHotkey v2.0

#SingleInstance
global state:=0
InstallKeybdHook
$~*Ctrl:: {
    global state
    if (!state){ 
        state := (GetKeyState("Shift", "P") || GetKeyState("Alt", "P") || GetKeyState("LWin", "P") || GetKeyState("RWin", "P"))
    }
}

$~Ctrl up::{
    global state
    if (instr(A_PriorKey, "control") && !state){
        Send "{esc}"
    }
    state := 0 
}

^Space::#Space ;change input language

;Switching Tabs
^o::^PgDn ;switch to next tab
^u::^PgUp ;switch to previous tab

;Far right pinky keys
^i::^BackSpace ;Backspace
^;::Enter ;Enter

;Arrow keys alternatives
^h::^Left ;Previous word
^l::^Right ;Next word
^j::Down ;Down arrow key
^k::Up ;Up arrow key

!d::#d ;Alt-D to Win-D, Go back to desktop
!Space::Send "#s" ;Alt-Space to Windows key

!x::!F4 ;close current window

;Launching applications
!c::{ ;chrome
    if WinExist("ahk_exe chrome.exe"){
        WinActivate 
    }
    else{
        Run "chrome.exe"
    }
}

!e::WinExist('ahk_class CabinetWClass') ? WinActivate() : Run('explorer')