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
~Space & d::#d ;Go back to desktop
~Space & w::LWin ;Windows key
~Space & x::!F4 ;close current window
~Space & Tab::AltTab

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
        Run "Code - Insiders.exe"
}

;Spotify
~Space & s::{ 
    ;if it's is already running
    if WinExist("ahk_exe Spotify.exe"){
        ;if it's in front, minimise it, or else, bring it to front
        WinActive()? WinMinimize() : WinActivate()
    }
    ;if it's not running, launch it
    else
        Run "Spotify.exe"
}