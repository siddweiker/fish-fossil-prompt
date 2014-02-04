#
# Written by Sidd Weiker
#
# A fish shell fossil prompt
#

function fish_prompt --description 'Write out the prompt'

    set -l last_status $status

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    # PWD
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal

    printf '%s ' (__fish_fossil_prompt)

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n '$ '
end

function  __fish_fossil_prompt --description "Prompt function for Fossil"
    set -l yellow (set_color -o yellow)
    set -l blue (set_color -o blue)
    set -l green (set_color -o green)
    set -l gray (set_color -o black)
    set -l normal (set_color -o normal)

    set -l info ""
    set -l branch (command fossil branch ls 2^/dev/null | awk '/\* /{print $2}')
    set -l changes (command fossil changes 2^/dev/null)
    set -l extra (count (command fossil extra 2^/dev/null))
    set -l col "$normal"

    if test -n "$changes"
        set col "$yellow"
    else
        set col "$blue"
    end

    if test $extra -ne 0
        set info "$gray|$yellow+$extra"
    end
    
    if test -n "$branch"
        printf "(%s%s%s%s)" $col $branch $info $normal
    end
end