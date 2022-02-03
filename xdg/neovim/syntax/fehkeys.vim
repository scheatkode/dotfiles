" for version 5.x: clear all syntax items
" for later versions: quit when a syntax file was already loaded
if version < 600
   syntax clear
elseif exists('b:current_syntax')
   finish
endif

let s:keepcpo = &cpo
set cpo&vim

syntax case ignore

setlocal iskeyword+=-

syntax keyword fehaction              close flip menu_child menu_down
syntax keyword fehaction              menu_parent menu_up mirror next_dir
syntax keyword fehaction              next_img orient_1 orient_3 prev_dir
syntax keyword fehaction              prev_img reload_image remove scroll_down
syntax keyword fehaction              scroll_down_page scroll_left scroll_left_page scroll_right
syntax keyword fehaction              scroll_right_page scroll_up scroll_up_page size_to_image
syntax keyword fehaction              toggle_aliasing toggle_filenames toggle_fullscreen toggle_pointer
syntax keyword fehaction              zoom_default zoom_fit zoom_in zoom_out

syntax match fehkeysimple             /\<[[:alnum:]]\+\>/
syntax match fehkeycomposite          /\<\(C\|M\|A\)\-\w/

syntax match fehcomment               /^#.*$/

" define the default highlighting.
" for version 5.7 and earlier: only when not done already
" for version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_fehkeys_syntax_inits")
   if version < 508
      let did_fehkeys_syntax_inits = 1
      command -nargs=+ HiLink hi link <args>
   else
      command -nargs=+ HiLink hi def link <args>
   endif

   HiLink fehaction       Error
   HiLink fehkeysimple    keyword
   HiLink fehkeycomposite keyword
   HiLink fehcomment      Comment

   delcommand HiLink
endif

let &cpo = s:keepcpo
unlet s:keepcpo

let b:current_syntax = 'fehkeys'
