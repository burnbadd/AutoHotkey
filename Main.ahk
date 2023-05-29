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

;Arrow keys alternatives
^h::^Left ;Previous word
^l::^Right ;Next word
^j::Down ;Down arrow key
^k::Up ;Up arrow key

;USING SPACE AS MODIFIER =================================================================
;The ~ symbol before the Space preserves the full original behaviour of the spacebar
;The only problem is that a normal Space: " " will be entered whenever these hotkeys are pressed 

~Space & d::#d ;Go back to desktop
~Space & x::!F4 ;close current window
~Space & Tab::AltTab

;Start Menu
~Space & w::{ 
    ;if it's opened, close it
    if WinActive('ahk_class Windows.UI.Core.CoreWindow'){
        ;Using Esc to close it
        Send "{Esc}"
    }
    ;if it's not opened, launch the search function
    else
        Send "{LWin Down}{LWin Up}"
}

;File Explorer
~Space & e::{ 
    ;if it's is already running
    if WinExist('ahk_class CabinetWClass'){
        ;if it's in front, minimise it, or else, bring it to front
        WinActive()? WinMinimize() : WinActivate()
    }
    ;if it's not running, launch it
    else
        Run "explorer.exe"
}

;Chrome
~Space & f::{ 
    ;if it's is already running
    if WinExist("ahk_exe chrome.exe"){
        ;if it's in front, minimise it, or else, bring it to front
        WinActive()? WinMinimize() : WinActivate()
    }
    ;if it's not running, launch it
    else
        Run "chrome.exe"
}

;VsCode-Insider
~Space & v::{ 
    ;if it's is already running
    if WinExist("ahk_exe Code - Insiders.exe"){
        ;if it's in front, minimise it, or else, bring it to front
        WinActive()? WinMinimize() : WinActivate()
    }
    ;if it's not running, launch it
    else
        Run "C:\Users\lawre\AppData\Local\Programs\Microsoft VS Code Insiders\Code - Insiders.exe"
}

;Spotify
~Space & s::{ 
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