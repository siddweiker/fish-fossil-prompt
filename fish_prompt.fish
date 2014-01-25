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
    set -l branch (command fossil branch ls 2^/dev/null | awk '/\* /{print $2}')
    
    if test $branch
        printf '(%s)' $branch
    end
end