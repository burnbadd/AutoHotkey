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

;==============================================================
LAlt::return
LAlt & Tab::AltTab 

#HotIf GetKeyState("LAlt", "P")
    ; LAlt & Tab:: AltTab
    o::^PgDn ;switch to next tab
    u::^PgUp ;switch to previous tab

    ;Typing 
    i::^BackSpace ;Backspace whole word
    p::BackSpace ;Backspace
    `;::Enter ;Enter

    h::^Left ;Go to Prvious work
    l::^Right ;Go to Next word
    j::Down ;Down arrow key
    k::Up ;Up arrow key
#HotIf