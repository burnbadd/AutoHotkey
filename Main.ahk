#Requires AutoHotkey v2.0
#SingleInstance
InstallKeybdHook

;Ctrl remaps================================================================
global state:=0
global cDown_time := A_TickCount
global cRelased_bool := true

$~*Ctrl:: {
    global state
    global cDown_time
    global cRelased_bool
    if (!state){ 
        state := (GetKeyState("Shift", "P") || GetKeyState("Alt", "P") || GetKeyState("LWin", "P") || GetKeyState("RWin", "P"))
    }
    if (cRelased_bool){
        cDown_time := A_TickCount
        cRelased_bool := false
    }
}

$~Ctrl up::{
    global state
    global cDown_time
    global cRelased_bool
    if (instr(A_PriorKey, "control") && !state){
        if ((A_TickCount-cDown_time)<200){
            Send "{esc}"
        }
    }
    state := 0 
    cRelased_bool := True
}

^Space::#Space ;change input language

;Switching Tabs
^o::^PgDn ;switch to next tab
^u::^PgUp ;switch to previous tab

;Typing 
^i::^BackSpace ;Backspace whole word
^p::BackSpace ;Backspace
^;::Enter ;Enter

^h::^Left ;Go to Prvious work
^l::^Right ;Go to Next word
^j::^Down ;Down arrow key
^k::^Up ;Up arrow key

;vim esc mapping
~j & k:: Send "{Backspace}{Esc}"

;USING SPACE AS A MODIFIER

;Make sure space doesn't start/stop the music when the the modifier is used in Spotify
#HotIf WinActive("ahk_exe Spotify.exe")
Space::return
$~Space up::{
    if (instr(A_PriorKey, "Space")){
        Send "{Space}"
    }
}
#HotIf ;exit the HotIf statement

;The ~ symbol before the Space preserves the full original behaviour of the spacebar
;The only problem is that a normal Space: " " will be entered whenever these hotkeys are pressed 

; ~Space & h::#d ;Go back to desktop (H for Home)
~Space & Esc::!F4 ;close current window
~Space & Tab::AltTab

; ;Launching Start Menu
; ~Space & 1::{ 
;     ;if it's opened, close it
;     if WinActive('ahk_class Windows.UI.Core.CoreWindow'){
;         ;Using Esc to close it
;         Send "{Esc}"
;     }
;     ;if it's not opened, launch the search function
;     else
;         Send "{LWin Down}{LWin Up}"
; }

; ;Launching applications on taskbar
; ~Space & 2::#1
; ~Space & 3::#2
; ; ~Space & 4::#3
; ~Space & 4::{ 
;     ;if it's is already running
;     if WinExist("ahk_exe Spotify.exe"){
;         ;if it's in front, press another space to resume the music before minimising it
;         if WinActive(){
;             Send "{Space}" 
;             WinMinimize() 
;         }
;         else{
;             WinActivate()
;         }
;     }
;     ;if it's not running, launch it
;     else
;         Run "Spotify.exe"
; }
; ~Space & 5::#4