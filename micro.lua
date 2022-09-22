vim.opt.mouse = 'a'
vim.opt.number = true
vim.g.hidden_all = 0
vim.opt.laststatus = 2
vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.shortmess = "I"

-- Statusbar        path [+] y / x   FileType        Right Side
vim.o.statusline  = "[%f]%m (%l,%v) | Ft:%y | %{&ff} %=        "

--show locale
--vim.opt.statusline +=\ %{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"\ \"}%k  "

vim.cmd([[
highlight Normal  ctermbg=235
highlight EndOfBuffer ctermfg=235 ctermbg=235

highlight LineNr ctermfg=246 ctermbg=236
hi CursorLineNr term=bold ctermbg=235 ctermfg=White gui=bold guifg=white

hi CursorLine cterm=NONE ctermbg=236
]])

--[[
function! ForceExit()
    q!
endfunction


function! PromptSave()
    if @% != ""
        write
        return 1
    endif
    let l:name = input('File Name to Write: ')
    if (l:name == "")
        return 0
    else
        execute "write! ".l:name
        return 1
    endif
endfunction
--Save file
--nnoremap <C-S> :call PromptSave()<cr>
--inoremap <silent> <C-S> <C-O>:call PromptSave()<cr>


function! InsertFile()
    let l:name = input('File to insert [from ./]: ')
    if (l:name == "")
    else
        execute "read ".l:name
    endif
endfunction
--Read file
--nnoremap <C-P> :call InsertFile()<cr>
--inoremap <silent> <C-P> <C-O>:call InsertFile()<cr>
 
function! Exit()
    if &mod
        call inputsave()
        let name = confirm('Save changes to file before closing? ', "Y\nN\nCancel")
        if (name==3)
        elseif (name == 2)
            call ForceExit()
        else
            if PromptSave() == 1
                call ForceExit()
            else
            endif
        endif

    else
        call ForceExit()
    endif
endfunction
--Exit app
--nnoremap <C-Q> :call Exit()<cr>
--inoremap <silent> <C-Q> <C-O>:call Exit()<cr>


--Search file
--nnoremap <C-F> :/
--inoremap <silent> <C-F> <C-O>:/
--nnoremap <C-H> :s/find/replace/c 
--inoremap <silent> <C-H> <C-O>:s/find/replace/c 


function! ShowInfo()
    let curline = line('.')
    let totalline = line('$')
    let curcol = col('.')
    let totalcol = col('$')
    let lineperc = 100 * curline / totalline
    let colperc = 100 * curcol / totalcol
    echo "[ line ". curline . "/". totalline .--(".lineperc."%), col ".curcol. "/".totalcol.--(".colperc."%) ]"
endfunction
--Show cursor info
--nnoremap <C-C> :call ShowInfo()<cr>
--inoremap <silent> <C-C> <C-O>:call ShowInfo()<cr>


function! GotoLine()
    let name = input('Enter line number, column number: ')
    if (name == "")
    else
        let newlist = split(name, "[ ,]")
        let cnt = 0
        let r = line(".")
        let c = col(".")
        for i in newlist
            if i != ""
                if cnt == 0
                    let r = i
                elseif cnt == 1
                    let c = i
                endif
            endif
            let cnt += 1
        endfor
        call cursor(r, c)
    endif
endfunction
--Goto line, col
--nnoremap <C-_> :call GotoLine()<cr>
--inoremap <silent> <C-_> <C-O>:call GotoLine()<cr>


function! FirstLine()
    call feedkeys("\<C-\>\<C-o>gg")
endfunction

function! LastLine()
    call feedkeys("\<C-\>\<C-o>G")
endfunction
--First Line
--nnoremap <A-\> :call FirstLine()<cr>
--inoremap <silent> <A-\> <C-O>:call FirstLine()<cr>
--Last Line
--nnoremap <A-/> :call LastLine()<cr>
--inoremap <silent> <A-/> <C-O>:call LastLine()<cr>


--Search forward
--inoremap <silent> <A-f> <C-O>n


--Match parenthesis
--inoremap <silent> <A-]> <C-O>%

--Command key
--nnoremap <silent> <C-e> <C-O>:
--inoremap <silent> <C-e> <C-O>:
vnoremap <BS> x

--Copy Text 
vnoremap <C-c> y


--Cut Text
vnoremap <C-x> d

--Paste Text
--inoremap <silent> <C-v> <C-O>p

function! Redo()
   :redo
endfunction

function! Deline()
   :.d
endfunction

function! Duline()
   :t.
endfunction

--   Example            <mode>  <keys>    <actions>       <options>
--vim.api.nvim_set_keymap( 'n',   '<C-s>', ':write<CR>', {noremap = true})

--Undo
----inoremap <silent> <C-z> <C-O>u
vim.api.nvim_set_keymap( 'u',   '<C-z>', ':write<CR>', {inoremap = true})
--Redo
--nnoremap <C-Y> :call Redo()<cr>
--inoremap <silent> <C-Y> <C-O>:call Redo()<cr>

--Delete Line
--nnoremap <C-K> :call Deline()<cr>
--inoremap <silent> <C-K> <C-O>:call Deline()<cr>

--Duplicate Line
--nnoremap <C-D> :call Duline()<cr>
--inoremap <silent> <C-D> <C-O>:call Duline()<cr>

--Select All
--inoremap <silent> <C-a> <C-[>ggVG
--nnoremap <C-A> <C-[> ggVG


--Indent
--inoremap <silent> <A-}> <C-O>>>
--inoremap <silent> <A-{> <C-O><<


--Justify
--inoremap <silent> <C-J> <C-O>gqk


--Col nav
--inoremap <silent> <C-u> <C-o>l
--inoremap <silent> <C-y> <C-o>h


--Word nav
--inoremap <silent> <A-Left> <C-o>b
--inoremap <silent> <A-Right> <C-o>w

--Open File
--nnoremap <C-O> :e 
--inoremap <silent> <C-O> <C-O>:e 

--command mode Mode
--nnoremap <C-1> :e 
--inoremap <silent> <C-n1> <C-O>:e 


function! Help()
    :help 
endfunction

--Open Help
--nnoremap <C-G> :call Help()<cr>
--inoremap <silent> <C-G> <C-O>:call Help()<cr>

--Start insert mode
startinsert


--brackets
--inoremap {<cr> {<cr>}<C-O><S-O>
--inoremap (<cr> (<cr>)<c-o><s-o>
--inoremap [<cr> [<cr>]<c-o><s-o>
--inoremap ( ()<left>
--inoremap { {}<left>
--inoremap [ []<left>
--inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")--? "\<Right>--: ")"
--inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}--? "\<Right>--: "}"
--inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]--? "\<Right>--: "]"
--inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'--? "\<Right>--: "''<left>"
--inoremap <expr> --strpart(getline('.'), col('.')-1, 1) == "\"--? "\<Right>--: "\"\"<left>"
--nnoremap ' mmbi'<esc>ea'<esc>`m<right>
--nnoremap --mmbi"<esc>ea"<esc>`m<right>
--nnoremap ( mmbi(<esc>ea)<esc>`m<right>
--nnoremap { mmbi{<esc>ea}<esc>`m<right>
--nnoremap [ mmbi[<esc>ea]<esc>`m<right>
--vnoremap ' <Esc>`<i'<Esc>`>a<right>'<Esc>
--vnoremap --<Esc>`<i"<Esc>`>a<right>"<Esc>
--vnoremap ( <Esc>`<i(<Esc>`>a<right>)<Esc>
--vnoremap { <Esc>`<i{<Esc>`>a<right>}<Esc>
--vnoremap [ <Esc>`<i[<Esc>`>a<right>]<Esc>
--]]
