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

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let g:niji#matching_filetypes = get(g:, 'niji#matching_filetypes', ['lisp', 'scheme', 'clojure'])
let g:niji#use_legacy_colours = get(g:, 'niji#use_legacy_colours', 0)

let g:niji#matching_characters = get(g:, 'niji#matching_characters', [
			\		['(', ')'],
			\		['\[', '\]'],
			\		['{', '}']
			\	])

let g:niji#dark_colours = get(g:, 'niji#dark_colours', [
			\		['red', 'red1'],
			\		['yellow', 'orange1'],
			\		['green', 'yellow1'],
			\		['cyan', 'greenyellow'],
			\		['magenta', 'green1'],
			\		['red', 'springgreen1'],
			\		['yellow', 'cyan1'],
			\		['green', 'slateblue1'],
			\		['cyan', 'magenta1'],
			\		['magenta', 'purple1']
			\	])

let g:niji#light_colours = get(g:, 'niji#light_colours', [
			\		['red', 'red3'],
			\		['darkyellow', 'orangered3'],
			\		['darkgreen', 'orange2'],
			\		['blue', 'yellow3'],
			\		['darkmagenta', 'olivedrab4'],
			\		['red', 'green4'],
			\		['darkyellow', 'paleturquoise3'],
			\		['darkgreen', 'deepskyblue4'],
			\		['blue', 'darkslateblue'],
			\		['darkmagenta', 'darkviolet']
			\	])


let s:legacy_colours = [
			\		['brown', 'RoyalBlue3'],
			\		['Darkblue', 'SeaGreen3'],
			\		['darkgray', 'DarkOrchid3'],
			\		['darkgreen', 'firebrick3'],
			\		['darkcyan', 'RoyalBlue3'],
			\		['darkred', 'SeaGreen3'],
			\		['darkmagenta', 'DarkOrchid3'],
			\		['brown', 'firebrick3'],
			\		['gray', 'RoyalBlue3'],
			\		['black', 'SeaGreen3'],
			\		['darkmagenta', 'DarkOrchid3'],
			\		['Darkblue', 'firebrick3'],
			\		['darkgreen', 'RoyalBlue3'],
			\		['darkcyan', 'SeaGreen3'],
			\		['darkred', 'DarkOrchid3'],
			\		['red', 'firebrick3']
			\	]

for colour_set in [g:niji#dark_colours, g:niji#light_colours, s:legacy_colours]
	call reverse(colour_set)
endfor

if g:niji#use_legacy_colours
	let s:current_colour_set = s:legacy_colours
else
	let s:current_colour_set = &bg == 'dark' ? g:niji#dark_colours : g:niji#light_colours
endif

function! niji#highlight()
	for character_pair in g:niji#matching_characters
		for each in range(1, len(s:current_colour_set))
			execute printf('syntax region paren%s matchgroup=level%s start=/%s/ end=/%s/ contains=ALLBUT,%s',
			          \ string(each),
			          \ string(each),
			          \ character_pair[0],
			          \ character_pair[1],
			          \ join(map(filter(range(1, len(s:current_colour_set)),
			                          \ each == 1 ? 'v:val != len(s:current_colour_set)' : 'v:val != each - 1'),
			                   \ '"paren" . v:val'),
			               \ ','))
		endfor
	endfor

	for each in range(1, len(s:current_colour_set))
		execute printf('highlight default level%s ctermfg=%s guifg=%s',
		             \ string(each),
		             \ s:current_colour_set[each - 1][0],
		             \ s:current_colour_set[each - 1][1])
	endfor
endfunction

function! niji#load()
	if count(g:niji#matching_filetypes, &ft) > 0
		call niji#highlight()
	endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
