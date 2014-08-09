"
" vim-niji - Yet another rainbow parentheses plugin.
"
"  Maintainer: Alastair Touw <alastair@touw.me.uk>
"     Website: http://github.com/amdt/vim-niji
"     License: Distributed under the same terms as Vim. See ':h license'.
"     Version: 1.0.4
" Last Change: 2014 Aug 06
"       Usage: See 'doc/niji.txt' or ':help niji' if installed.
"
" Niji follows the Semantic Versioning specification (http://semver.org).
"
" GetLatestVimScripts: 4580 21966 :AutoInstall: vim-niji
"

scriptencoding utf-8

if exists("g:loaded_niji")
	finish
endif
let g:loaded_niji = 1


autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost * nested call niji#load()
