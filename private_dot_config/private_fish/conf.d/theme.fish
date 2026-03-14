# Main theme colors
set -l normal normal
set -l bleak '#666666'
# set -l primary blue
# set -l secondary '#8F87F7'
# set -l primary_accent yellow
# set -l secondary_accent red
set -l primary green
set -l secondary '#77A227'
set -l primary_accent magenta
set -l secondary_accent red

# Prompt symbols
set -g fish_prompt_suffix "$(set_color '#333333')❯$(set_color '#777777')❯$(set_color '#aaaaaa')❯ "
set -g fish_prompt_suffix_root $fish_prompt_suffix
set -g fish_prompt_separator ' | '
set -g fish_prompt_errcode_symbol '!'

# Default text color
set -g fish_color_normal                                $normal

# Prompt
set -g fish_color_normal_prompt                         $bleak
set -g fish_color_cwd                                   $primary
set -g fish_color_cwd_root                              $primary
set -g fish_color_cwd_sep                               $secondary
set -g fish_color_cwd_last                              $primary --bold
set -g fish_color_user                                  $primary_accent
set -g fish_color_user_root                             $secondary_accent
set -g fish_color_host                                  $primary_accent
set -g fish_color_host_remote                           $primary_accent
set -g fish_color_err_code                              $secondary_accent
set -g fish_color_venv                                  $primary
set -g fish_color_git_branch                            $primary_accent --bold
set -g fish_color_git_action                            $secondary_accent
set -g fish_color_git_detached                          $primary
set -g fish_color_git_status                            $secondary
set -g fish_color_git_status_info                       $primary

# Code highlight
set -g fish_color_command                               $primary
set -g fish_color_quote                                 $primary_accent
set -g fish_color_redirection
set -g fish_color_end                                   $secondary
set -g fish_color_error                                 '#FF0000'
set -g fish_color_param                                 normal
set -g fish_color_comment                               $bleak
set -g fish_color_match                                 $secondary
set -g fish_color_operator                              $secondary
set -g fish_color_escape                                $secondary
set -g fish_color_valid_path                            --underline
set -g fish_color_autosuggestion                        $bleak
set -g fish_color_keyword                               $secondary
set -g fish_color_option                                $primary

# Code history and reverse search
set -g fish_color_selection                             --background=brblack
set -g fish_color_search_match                          --background=brblack
set -g fish_color_history_current                       --bold

set -g fish_color_cancel                                --reverse

set -g fish_pager_color_background
set -g fish_pager_color_prefix                          --underline
set -g fish_pager_color_progress                        --reverse
set -g fish_pager_color_completion
set -g fish_pager_color_description                     $secondary
set -g fish_pager_color_selected_background             --background=brblack
set -g fish_pager_color_selected_prefix                 --underline --bold
set -g fish_pager_color_selected_completion
set -g fish_pager_color_selected_description
set -g fish_pager_color_secondary_background
set -g fish_pager_color_secondary_description
set -g fish_pager_color_secondary_prefix
set -g fish_pager_color_secondary_completion
