" autocmd FileType make setlocal list 
".module filetype
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

if exists("did_load_filetypes")
	finish
endif
augroup filetypedetect
	au! BufRead,BufNewFile *.module		setfiletype php
	au! BufRead,BufNewFile *.mpl        setfiletype perl
	au! BufRead,BufNewFile *.jsx        setfiletype javascript
augroup END

