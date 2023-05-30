#Requires AutoHotkey v2.0
#SingleInstance
InstallKeybdHook

;Ctrl remaps================================================================
global state:=0
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

;Arrow keys alternatives=====

;Previous/Next Word
^h::^Left
^l::^Right
^j::Down ;Down arrow key
^k::Up ;Up arrow key

;vim esc mapping
~j & k:: Send "{Backspace}{Esc}"

;USING SPACE AS MODIFIER =================================================================
;The ~ symbol before the Space preserves the full original behaviour of the spacebar
;The only problem is that a normal Space: " " will be entered whenever these hotkeys are pressed 

~Space & h::#d ;Go back to desktop (H for Home)
~Space & 6::!F4 ;close current window
~Space & Tab::AltTab

~Space & 2::#1
~Space & 3::#2
; Spotify
; ~Space & 4::#3
~Space & 5::#4

;Start Menu
~Space & 1::{ 
    ;if it's opened, close it
    if WinActive('ahk_class Windows.UI.Core.CoreWindow'){
        ;Using Esc to close it
        Send "{Esc}"
    }
    ;if it's not opened, launch the search function
    else
        Send "{LWin Down}{LWin Up}"
}

;Spotify
~Space & 4::{ 
    ;if it's is already running
    if WinExist("ahk_exe Spotify.exe"){
        ;if it's in front, minimise it, or else, bring it to front
        if WinActive(){
            Send "{Space}" 
            WinMinimize() 
        }
        else{
            WinActivate()
        }
    }
    ;if it's not running, launch it
    else
        Run "Spotify.exe"
}