" textobj-lastpat - Text objects for the last searched pattern
" Version: 0.0.2
" Copyright (C) 2008-2013 Kana Natsuno <http://whileimautomaton.net/>
" License: So-called MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists('g:loaded_textobj_lastpat')
  finish
endif

"搜索结果lastpat: / ?
"日期date 时间time : d T
"两数字之间dig.dig : m
"php代码 : P
"行Line : l
"双引号quote : u
"单引号quotex : x
"方括号BracketsF : f
"尖括号BracketsY : j
"大括号Braces : k


call textobj#user#plugin('lastpat', {
\      'n': {
\        'select': ['a/', 'i/'],
\        '*select-function*': 's:select_n',
\        '*sfile*': expand('<sfile>')
\      },
\      'N': {
\        'select': ['a?', 'i?'],
\        '*select-function*': 's:select_N',
\        '*sfile*': expand('<sfile>')
\      },
\    })

call textobj#user#plugin('datetime', {
\   'date': {
\     'pattern': '\<\d\d\d\d\(\/\|\.\|-\)\d\d\(\/\|\.\|-\)\d\d\>',
\     'select': ['ad', 'id'],
\   },
\   'time': {
\     'pattern': '\<\d\d:\d\d:\d\d\>',
\     'select': ['aT', 'iT'],
\   },
\ })

call textobj#user#plugin('dandd', {
\   'ddd': {
\      'select': ['am', 'im'],
\      'pattern': '\d\+\.\?\d*',
\   },
\ })

call textobj#user#plugin('php', {
\   'code': {
\     'pattern': ['<?php\>', '?>'],
\     'select-a': 'aP',
\     'select-i': 'iP',
\   },
\ })

call textobj#user#plugin('line', {
\   '-': {
\     'select-a-function': 'CurrentLineA',
\     'select-a': 'al',
\     'select-i-function': 'CurrentLineI',
\     'select-i': 'il',
\   },
\ })

call textobj#user#plugin('quote', {
\   'quote': {
\     'select-a-function': 'QuoteA',
\     'select-a': 'au',
\     'select-i-function': 'QuoteI',
\     'select-i': 'iu',
\   },
\ })

call textobj#user#plugin('quotex', {
\   'quotex': {
\     'select-a-function': 'QuoteXA',
\     'select-a': 'ax',
\     'select-i-function': 'QuoteXI',
\     'select-i': 'ix',
\   },
\ })

call textobj#user#plugin('bracketsf', {
\   'bracketsf': {
\     'select-a-function': 'BracketsFA',
\     'select-a': 'af',
\     'select-i-function': 'BracketsFI',
\     'select-i': 'if',
\   },
\ })

call textobj#user#plugin('bracketsy', {
\   'bracketsy': {
\     'select-a-function': 'BracketsYA',
\     'select-a': 'aj',
\     'select-i-function': 'BracketsYI',
\     'select-i': 'ij',
\   },
\ })

call textobj#user#plugin('braces', {
\   'braces': {
\     'select-a-function': 'BracesA',
\     'select-a': 'ak',
\     'select-i-function': 'BracesI',
\     'select-i': 'ik',
\   },
\ })


function! CurrentLineA()
  normal! 0
  let head_pos = getpos('.')
  normal! $
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction


function! CurrentLineI()
  normal! ^
  let head_pos = getpos('.')
  normal! g_
  let tail_pos = getpos('.')
  let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
  return
  \ non_blank_char_exists_p
  \ ? ['v', head_pos, tail_pos]
  \ : 0
endfunction

"双引号
function! QuoteA()
  normal! F"
  let head_pos = getpos('.')
  normal! f"
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! QuoteI()
  normal! T"
  let head_pos = getpos('.')
  normal! t"
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

"单引号
function! QuoteXA()
  normal! F'
  let head_pos = getpos('.')
  normal! f'
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! QuoteXI()
  normal! T'
  let head_pos = getpos('.')
  normal! t'
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

"方括号
function! BracketsFA()
  normal! F[
  let head_pos = getpos('.')
  normal! f]
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! BracketsFI()
  normal! T[
  let head_pos = getpos('.')
  normal! t]
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

"尖括号
function! BracketsYA()
  normal! F<
  let head_pos = getpos('.')
  normal! f>
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! BracketsYI()
  normal! T<
  let head_pos = getpos('.')
  normal! t>
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

"大括号
function! BracesA()
  normal! F{
  let head_pos = getpos('.')
  normal! f}
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! BracesI()
  normal! T{
  let head_pos = getpos('.')
  normal! t}
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction


function! s:select_n()
  return s:select(0)
endfunction

function! s:select_N()
  return s:select(1)
endfunction

function! s:select(opposite_p)
  let forward_p = (v:searchforward && !a:opposite_p)
  \               || (!v:searchforward && a:opposite_p)

  if search(@/, 'ce' . (forward_p ? '' : 'b')) == 0
    return 0
  endif
  let end_position = getpos('.')

  if search(@/, 'bc') == 0
    return 0
  endif
  let start_position = getpos('.')

  return ['v', start_position, end_position]
endfunction




let g:loaded_textobj_lastpat = 1

" __END__
" vim: foldmethod=marker
