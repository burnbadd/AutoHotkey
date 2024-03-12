#Requires AutoHotkey v2.0
#SingleInstance
InstallKeybdHook
; $ prevents the Send function from triggering hotkeys
; ~ When hotkey fires, the original/native function of the key won't be blocked
; * Hotkey will fire even if other extra keys are pressed down

/* -------------------------------------------------------------------------- */
/*                             Ctrl related remaps                            */
/* -------------------------------------------------------------------------- */

$~*Ctrl::{
    KeyWait "Ctrl"
}

$~Ctrl up::{
    if (A_PriorHotKey=="$~*Ctrl" && (A_TimeSincePriorHotkey<200)){
        Send "{esc}"
    }
}

^Space::#Space ;change input language

/* -------------------------------------------------------------------------- */
/*                             Alt related remaps                             */
/* -------------------------------------------------------------------------- */

Alt::{
    KeyWait "Alt" ;Hotkey can't be triggered again unless Alt up, This stops Alt from repeatedly firing so AltDownMoment won't be refreshed by virtual repeated fires
}

^Alt::return 
;So Alt woudn't be pressed when Ctrl is pressed first
;to use control + arrowkeys through Alt layer key

^!r::{
    Send "{Ctrl down}s{Ctrl up}"
    Reload
} ;Save and Reload the ahk script, useful when testing and debugging

#HotIf GetKeyState("Alt", "P")
    global AltTabMode := false
    ; LAlt & Tab:: AltTab
    o::^PgDn ;switch to next tab
    u::^PgUp ;switch to previous tab

    ;Typing 
    i::^BackSpace ;Backspace whole word
    p::BackSpace ;Backspace
    `;::Enter ;Enter

    h::Left ;Go to Prvious work
    l::Right ;Go to Next word
    j::Down ;Down arrow key
    k::Up ;Up arrow key

    r::#r ;windows run
    `::{ ;runs windows terminal
        if !WinActive("ahk_exe Code.exe"){ 
            run "wt.exe"
        }
        else{
            send "{Ctrl down}``{Ctrl up}" ;vscode keyboard shortcut for terminal
        }
    }
    esc::WinClose "A" ;closes the active window

    1::#1
    2::#2
    3::#3
    4::#4
    5::#5
    6::#6

    Tab::{ ;Dealing with AltTab windows task viewer
        global AltTabMode 
        if not AltTabMode{
            AltTabMode := true
            Send "{Alt down}{Tab}" ;enters alttab mode by pressing down alt
        }
        else{
            Send "{Tab}"
        }
    }
    Alt up:: {
        Send "{Alt up}"
        global AltTabMode
        AltTabMode := false

        if (A_PriorHotKey=='Alt') && (A_TimeSincePriorHotkey<200){
            Send "{LWin}"
        }
    }

#HotIf