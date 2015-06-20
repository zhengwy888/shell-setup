".module filetype
if exists("did_load_filetypes")
	finish
endif
augroup filetypedetect
	au! BufRead,BufNewFile *.module		setfiletype php
	au! BufRead,BufNewFile *.mpl        setfiletype perl
	au! BufRead,BufNewFile *.jsx        setfiletype javascript
augroup END

