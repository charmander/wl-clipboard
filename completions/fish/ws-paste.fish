function __wayland_seats --description 'Print all wayland seats'
    if type -q weston-info
        weston-info 2>/dev/null | sed -n '/wl_seat/{n;s/\s*name: //;p}'
    else if type -q loginctl
        loginctl --no-legend --no-pager list-seats 2>/dev/null
    else
        # Fallback seat
        echo "seat0"
    end
end

function __wl_paste_types --description 'Print types with context'
    set -l type (commandline -o)

    for i in (seq (count $type))
        if [ "$type[$i]" = '--primary' ]; or [ "$type[$i]" = '-p' ]
            set clip "primary"
        else if [ "$type[$i]" = '--seat' ]; or [ "$type[$i]" = '-s' ]
            set seat $type[(math $i + 1)]
        end
    end

    # Note fish does not handle passing unset variables
    # to commands well, thus setting clip to "--primary" and passing
    # that to ws-paste wont work, so if statements are used instead
    if test -n "$seat"; and test -n "$clip"
        ws-paste 2>/dev/null --seat "$seat" -p -l
    else if test -n "$seat"
        ws-paste 2>/dev/null --seat "$seat" -l
    else if test -n "$clip"
        ws-paste 2>/dev/null -p -l
    else
        ws-paste 2>/dev/null -l
    end
end

complete -c ws-paste -f
complete -c ws-paste -f -n '__fish_contains_opt -s w watch' -a "(__fish_complete_subcommand -- -s --seat -t --type)"
complete -c ws-paste -n '__fish_not_contain_opt -s w watch' -s h -l help -d 'Display a help message'
complete -c ws-paste -n '__fish_not_contain_opt -s w watch' -s v -l version -d 'Display version info'
complete -c ws-paste -n '__fish_not_contain_opt -s w watch' -s l -l list-types -d 'Instead of pasting, list the offered types'
complete -c ws-paste -n '__fish_not_contain_opt -s w watch' -s p -l primary -d 'Use the "primary" clipboard'
complete -c ws-paste -n '__fish_not_contain_opt -s w watch' -s w -l watch -d 'Run a command each time the selection changes'
complete -c ws-paste -n '__fish_not_contain_opt -s w watch' -s t -l type -x -d 'Set the MIME type for the content' -a "(__wl_paste_types)"
complete -c ws-paste -n '__fish_not_contain_opt -s w watch' -s s -l seat -x -d 'Pick the seat to work with' -a "(__wayland_seats)"
