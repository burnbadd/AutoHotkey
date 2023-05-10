;Requires AutoHotkey v2.0

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
^j::^PgUp ;switch tabs
^k::^PgDn ;
!d::#d ;alt d to win d
!x::!F4 ;close current window
!c::Run "chrome.exe"
!t::Run "wt.exe" ;Windows terminal
!e::Run "explorer.exe" ;File explorer