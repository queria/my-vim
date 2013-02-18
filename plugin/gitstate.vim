" gitstate.vim - A script to display git status at side of lines.
"
" Thanks to pyflakes.vim and syntastic for ideas/code base.
"
" Maintainer: Pavel Sedlák <psedlak@redhat.com>
" Version: 0.1

if exists("b:did_gitstate_plugin")
    finish " only load once
else
    let b:did_gitstate_plugin = 1
endif

au BufLeave <buffer> call s:ClearGitState()

au BufEnter <buffer> call s:RunGitState()
"au InsertLeave <buffer> call s:RunGitState()
"au InsertEnter <buffer> call s:RunGitState()
au BufWritePost <buffer> call s:RunGitState()

" au CursorHold <buffer> call s:RunGitState()
" au CursorHoldI <buffer> call s:RunGitState()

" au CursorHold <buffer> call s:GetPyflakesMessage()
" au CursorMoved <buffer> call s:GetPyflakesMessage()

if !exists("*s:GitStateUpdate")
    function s:GitStateUpdate()
        silent call s:RunGitState()
        "call s:GetPyflakesMessage()
    endfunction
endif

" Call this function in your .vimrc to update PyFlakes
if !exists(":GitStateUpdate")
  command GitStateUpdate :call s:GitStateUpdate()
endif

exe 'sign define GitStateAdded text=+ texthl=DiffAdd'
exe 'sign define GitStateModified text=* texthl=DiffChange'
exe 'sign define GitStateRemoved text=- texthl=DiffDelete'
" TODO: add highlighting for removed lines too
"exe 'sign define SyntasticStyleError text='.g:syntastic_style_error_symbol.' texthl=error'

" Hook common text manipulation commands to update PyFlakes
"   TODO: is there a more general "text op" autocommand we could register
"   for here?
" noremap <buffer><silent> dd dd:GitStateUpdate<CR>
" noremap <buffer><silent> dw dw:GitStateUpdate<CR>
" noremap <buffer><silent> u u:GitStateUpdate<CR>
" noremap <buffer><silent> <C-R> <C-R>:GitStateUpdate<CR>


function! s:RemoveSigns(ids)
    for i in a:ids
        exec "sign unplace " . i
        call remove(b:gitstate_marked, index(b:gitstate_marked, i))
    endfor
endfunction

function! s:AddSign(lineno, type)
    "exec "sign place GitStateAdded"
    let sign_type = "GitStateModified"
    if a:type == 'added'
        let sign_type = "GitStateAdded"
    elseif a:type == 'removed'
        let sign_type = "GitStateRemoved"
    endif

    exec "sign place ". b:gitstate_nextid." line=". a:lineno ." name=". sign_type ." file=". expand("%:p")
    call add(b:gitstate_marked, b:gitstate_nextid)

    let b:gitstate_nextid += 1
endfunction

if !exists("*s:FetchGitStates")
    function s:FetchGitStates()
        let l:states = []
        let l:gitdiff = system("git diff -U0 ".expand("%:p"))
        if len(l:gitdiff) == 0
            return l:states " no diff output so not versioned or not in git repo at all
        endif
        let l:start_line = -1
        let l:last_removed = -1

        for l:line in split(l:gitdiff, "\n")
            if l:start_line > -1
                if match(l:line, "-") == 0
                    let l:last_removed = l:start_line + 1
                    continue
                elseif match(l:line, "+") == 0
                    let l:type = 'added'
                    if l:last_removed > -1
                        let l:type = 'modified'
                        let l:last_removed = -1
                    endif
                    call add(l:states, [l:start_line, l:type])
                    let l:start_line += 1
                    continue
                endif

            endif
            if match(l:line, "@@ ") == 0
                if l:last_removed > -1
                    call add(l:states, [l:last_removed, 'removed'])
                    let l:last_removed = -1
                endif
                let l:start_line = split(l:line, " ")[2]
                let l:start_line = split(l:start_line, ',')[0][1:]
                let l:last_removed = -1
                continue
            endif
        endfor

        if l:last_removed > -1
            call add(l:states, [l:last_removed, 'removed'])
        endif

        return l:states
    endfunction
endif

if !exists("*s:RunGitState")
    function s:RunGitState()
        highlight link PyFlakes SpellBad

        silent call s:ClearGitState()
        
        let states = s:FetchGitStates()
        for state in states
            call s:AddSign(state[0], state[1])
        endfor

        let b:gitstate_cleared = 0
    endfunction
endif

if !exists('*s:ClearGitState')
    function s:ClearGitState()
        if exists("b:gitstate_cleared")
            if b:gitstate_cleared == 1
                return
            endif
        endif
        if !exists("b:gitstate_marked")
            let b:gitstate_marked = []
        endif
        call s:RemoveSigns(b:gitstate_marked)
        " We should have cleared all our signs right now
        " so we reset the nextid.
        " We are using 8000 to possibly not collide with syntastic etc.
        let b:gitstate_nextid = 8000
        let b:gitstate_cleared = 1
    endfunction
endif



" ====== from syntastic ===============

""" if g:syntastic_enable_signs
"""     "define the signs used to display syntax and style errors/warns
"""     exe 'sign define SyntasticError text='.g:syntastic_error_symbol.' texthl=error'
"""     exe 'sign define SyntasticWarning text='.g:syntastic_warning_symbol.' texthl=todo'
"""     exe 'sign define SyntasticStyleError text='.g:syntastic_style_error_symbol.' texthl=error'
"""     exe 'sign define SyntasticStyleWarning text='.g:syntastic_style_warning_symbol.' texthl=todo'
""" endif

""" function! s:SignErrors()
"""     if s:BufHasErrorsOrWarningsToDisplay()
""" 
"""         let errors = s:FilterLocList({'bufnr': bufnr('')})
"""         for i in errors
"""             let sign_severity = 'Error'
"""             let sign_subtype = ''
"""             if has_key(i,'subtype')
"""                 let sign_subtype = i['subtype']
"""             endif
"""             if i['type'] ==? 'w'
"""                 let sign_severity = 'Warning'
"""             endif
"""             let sign_type = 'Syntastic' . sign_subtype . sign_severity
""" 
"""             if !s:WarningMasksError(i, errors)
"""                 exec "sign place ". s:next_sign_id ." line=". i['lnum'] ." name=". sign_type ." file=". expand("%:p")
"""                 call add(s:BufSignIds(), s:next_sign_id)
"""                 let s:next_sign_id += 1
"""             endif
"""         endfor
"""     endif
""" endfunction
""" 
""" "return true if the given error item is a warning that, if signed, would
""" "potentially mask an error if displayed at the same time
""" function! s:WarningMasksError(error, llist)
"""     if a:error['type'] !=? 'w'
"""         return 0
"""     endif
""" 
"""     return len(s:FilterLocList({ 'type': "E", 'lnum': a:error['lnum'] }, a:llist)) > 0
""" endfunction
""" 
""" "remove the signs with the given ids from this buffer
""" 
""" "get all the ids of the SyntaxError signs in the buffer
""" function! s:BufSignIds()
"""     if !exists("b:syntastic_sign_ids")
"""         let b:syntastic_sign_ids = []
"""     endif
"""     return b:syntastic_sign_ids
""" endfunction
""" 
""" "update the error signs
""" function! s:RefreshSigns()
"""     let old_signs = copy(s:BufSignIds())
"""     call s:SignErrors()
"""     call s:RemoveSigns(old_signs)
"""     let s:first_sign_id = s:next_sign_id
""" endfunction



" ==== example `git diff -U0 output` ====
"" diff --git a/git-review b/git-review
"" index d43f23b..1c703ae 100755
"" --- a/git-review
"" +++ b/git-review
"" @@ -93,0 +94,10 @@ class ChangeSetException(GitReviewException):
"" +def parse_review_number(review):
"" +    parts = review.split(',')
"" +    if len(parts) < 2:
"" +        parts.append(None)
"" +    else:
"" +        parts[1:] = parts[1].split('-')
"" +    if len(parts) < 3:
"" +        parts.append(None)
"" +    return parts
"" +
"" @@ -696,2 +706,5 @@ def fetch_review(review, masterbranch, remote):
"" -    if ',' in review:
"" -        review, patchset_number = review.split(',')
"" +    
"" +    review_parts = parse_review_number(review)
"" +    review = review_parts[0]
"" +    patchset_number = review_parts[1]
"" +    if patchset_number is not None:
"" @@ -699,0 +713,4 @@ def fetch_review(review, masterbranch, remote):
"" +    #if ',' in review:
"" +    #    review, patchset_number = review.split(',')
"" +    #    patchset_opt = '--patch-sets'
"" +
"" @@ -799,0 +817,27 @@ class DeleteBranchFailed(CommandFailed):
"" +def compare_review(review_spec, branch, remote, rebase=False):

