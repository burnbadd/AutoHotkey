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
    if (A_PriorHotKey=="$~*Ctrl" && (A_TimeSincePriorHotkey<200)){ ;Tapped and release function
        Send "{esc}"
    }
}

^Space::#Space ;change input language

/* -------------------------------------------------------------------------- */
/*                             Alt related remaps                             */
/* -------------------------------------------------------------------------- */

Alt::{
    KeyWait "Alt" 
    ;Hotkey can't be triggered again unless Alt up, This stops Alt from repeatedly firing so AltDownMoment won't be refreshed by virtual repeated fires
}

Alt up:: {
    Send "{Alt up}"
    if (A_PriorHotKey=='Alt') && (A_TimeSincePriorHotkey<200){ ;Tapped and release function
        Send "{LWin}"
    }
}

^Alt::return ;So Alt woudn't be pressed when Ctrl is pressed first, therefore we can use control + arrowkeys through Alt layer key

^!r::{
    Send "{Ctrl down}s{Ctrl up}"
    Reload
} ;Save and Reload the ahk script, useful when testing and debugging

#HotIf GetKeyState("Alt", "P")
    global AltTabMode := false

    ;Navigating Tabs
    o::^PgDn ;switch to next tab
    u::^PgUp ;switch to previous tab

    ;Typing 
    i::^BackSpace ;Backspace whole word
    p::BackSpace ;Backspace
    `;::Enter ;Enter

    ;Arrow keys
    h::Left ;Go to Prvious work
    l::Right ;Go to Next word
    j::Down ;Down arrow key
    k::Up ;Up arrow key

    ;General funcitons
    r::#r ;windows run
    esc::WinClose "A" ;closes the active window
    `::{ ;runs windows terminal
        if WinActive("ahk_exe Code.exe"){ 
            send "{Ctrl down}``{Ctrl up}" ;vscode keyboard shortcut for terminal
        }else{
            run "wt.exe"
        }
    }

    ;Taskbar navigation
    1::#1
    2::#2
    3::#3
    4::#4
    5::#5
    6::#6

    Tab::{ ;Dealing with AltTab windows task viewer
        if !(A_PriorHotKey=="Tab"){ ;if it is the first tab pressed while alt is physically held down
            Send "{Alt down}{Tab}" ;enters alttab mode by pressing down alt and press tab once
        }else{
            Send "{Tab}" ;alternating between windows in alttab mode
        }
    }

#HotIf ;Escaping #HotIf GetKeyState("Alt", "P")