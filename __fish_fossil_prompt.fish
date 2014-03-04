#
# Written by Sidd Weiker
#
# A fish shell fossil prompt
#

function  __fish_fossil_prompt --description "Prompt function for Fossil"
    set -l yellow (set_color -o yellow)
    set -l blue (set_color -o blue)
    set -l green (set_color -o green)
    set -l gray (set_color -o black)
    set -l normal (set_color -o normal)

    set -l separator "|"
    set -l info ""
    set -l branch (command fossil branch ls 2^/dev/null | awk '/\* /{print $2}')

    if test -n "$branch"
        set -l stash (command fossil stash list 2^/dev/null)
        set -l changes (command fossil changes 2^/dev/null | awk '{print $1}')
        set -l extra (count (command fossil extra 2^/dev/null))
        set -l col $normal
        
        if test "$stash" != 'empty stash'
            set separator "\$"
        end

        if test -n "$changes"
            if contains 'MERGED_WITH' $changes
                set info $gray$separator$yellow"MERGING!"
                set extra 0
            end
            set col "$yellow"
        else
            set col "$blue"
        end

        if test $extra -ne 0
            set info "$gray$separator$yellow+$extra"
        end
        
        printf "(%s%s%s%s)" $col $branch $info $normal
    end
end
