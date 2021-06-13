" Vim syntax file
" Language:     Nelua 0.2.0
" Maintainer:   Stefanos Sofroniou <sofr.stef 'at' cytanet.com.cy>
" First Author: Stefanos Sofroniou <sofr.stef 'at' cytanet.com.cy>
" Last Change:  2021 Jun 05
" Remark:       Based on /usr/share/vim/vim82/syntax/lua.vim

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

if !exists("nelua_version")
  let nelua_version = 0
  let nelua_subversion = 2
elseif !exists("nelua_subversion")
  " nelua_version exists, but nelua_subversion doesn't. So, set it to 0
  let nelua_subversion = 0
endif

syn case match

" syncing method
syn sync minlines=100

" Comments
syn keyword neluaTodo contained TODO FIXME XXX
syn match neluaComment "--.*$" contains=neluaTodo,@Spell
" Comments in Lua 5.1: --[[ ... ]], [=[ ... ]=], [===[ ... ]===], etc.
syn region neluaComment 
      \ matchgroup=neluaComment 
      \ start="--\[\z(=*\)\[" end="\]\z1\]" 
      \ contains=neluaTodo,@Spell

syn match neluaKeyword "\(@\)"

syn match neluaOperator "\V^"   contained
syn match neluaOperator "+"     contained
syn match neluaOperator "="     contained
syn match neluaOperator "<="    contained
syn match neluaOperator "=>"    contained
syn match neluaOperator "\V~="  contained
syn match neluaOperator "<"     contained
syn match neluaOperator ">"     contained
syn match neluaOperator "\V."   contained
syn match neluaOperator "*"     contained
syn match neluaOperator "&"     contained
syn match neluaOperator "\/"    contained

syn match neluaPreProc /[|#\[\]]/

" First line may start with #!
syn match neluaComment "\%^#!.*"

" catch errors caused by wrong parenthesis and wrong curly brackets or
" keywords placed outside their respective blocks
syn region neluaParen transparent 
      \ start="(" end=")" 
      \ contains=ALLBUT,neluaParenError,neluaTodo,neluaSpecial,neluaIfThen,neluaElseifThen,neluaElse,neluaThenEnd,neluaBlock,neluaLoopBlock,neluaIn,neluaStatement

syn region neluaTableBlock transparent 
      \ matchgroup=neluaTable 
      \ start="{" end="}" 
      \ contains=ALLBUT,neluaBraceError,neluaTodo,neluaSpecial,neluaIfThen,neluaElseifThen,neluaElse,neluaThenEnd,neluaBlock,neluaLoopBlock,neluaIn,neluaStatement

syn match  neluaParenError ")"
syn match  neluaBraceError "}"
syn match  neluaError "\<\%(end\|else\|elseif\|then\|until\|in\)\>"

" function ... end
syn region neluaFunctionBlock transparent 
      \ matchgroup=neluaFunction 
      \ start="\<function\>" end="\<end\>" 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaElseifThen,neluaElse,neluaThenEnd,neluaIn

" if ... then
syn region neluaIfThen transparent 
      \ matchgroup=neluaCond 
      \ start="\<if\>" end="\<then\>"me=e-4 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaElseifThen,neluaElse,neluaIn 
      \ nextgroup=neluaThenEnd 
      \ skipwhite 
      \ skipempty

" switch ... end
syn region neluaLoopBlock transparent 
      \ matchgroup=neluaRepeat 
      \ start="\<switch\>" end="\<end\>"me=e-2 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaIfThen,neluaElseifThen,neluaElse,neluaThenEnd,neluaIn 
      \ nextgroup=neluaBlock 
      \ skipwhite 
      \ skipempty

" case ... then
syn region neluaCaseThen transparent 
      \ matchgroup=neluaCond 
      \ start="\<case\>" end="\<then\>"me=e-4 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaElseifThen,neluaElse,neluaIn 
      \ nextgroup=neluaThenEnd 
      \ skipwhite 
      \ skipempty

" then ... end
syn region neluaThenEnd contained transparent 
      \ matchgroup=neluaCond 
      \ start="\<then\>" end="\<end\>" 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaThenEnd,neluaIn

" elseif ... then
syn region neluaElseifThen contained transparent 
      \ matchgroup=neluaCond 
      \ start="\<elseif\>" end="\<then\>" 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaElseifThen,neluaElse,neluaThenEnd,neluaIn

" else
syn keyword neluaElse contained else

" do ... end
syn region neluaBlock transparent 
      \ matchgroup=neluaStatement 
      \ start="\<do\>" end="\<end\>" 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaElseifThen,neluaElse,neluaThenEnd,neluaIn

" defer ... end
syn region neluaDeferBlock transparent 
      \ matchgroup=neluaStatement 
      \ start="\<defer\>" end="\<end\>" 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaElseifThen,neluaElse,neluaThenEnd,neluaIn

" repeat ... until
syn region neluaLoopBlock transparent 
      \ matchgroup=neluaRepeat 
      \ start="\<repeat\>" end="\<until\>" 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaElseifThen,neluaElse,neluaThenEnd,neluaIn

" while ... do
syn region neluaLoopBlock transparent 
      \ matchgroup=neluaRepeat 
      \ start="\<while\>" end="\<do\>"me=e-2 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaIfThen,neluaElseifThen,neluaElse,neluaThenEnd,neluaIn 
      \ nextgroup=neluaBlock 
      \ skipwhite 
      \ skipempty

" for ... do and for ... in ... do
syn region neluaLoopBlock transparent 
      \ matchgroup=neluaRepeat 
      \ start="\<for\>" end="\<do\>"me=e-2 
      \ contains=ALLBUT,neluaTodo,neluaSpecial,neluaIfThen,neluaElseifThen,neluaElse,neluaThenEnd 
      \ nextgroup=neluaBlock 
      \ skipwhite 
      \ skipempty

syn keyword neluaIn contained in

" other keywords
syn keyword neluaStatement      return local global break continue
syn keyword neluaCond           switch
syn keyword neluaBuiltin        void boolean string integer uinteger number
syn keyword neluaBuiltin        byte isize int8 int16 int32 int64 int128
syn keyword neluaBuiltin        usize uint8 uint16 uint32 uint64 uint128
syn keyword neluaBuiltin        float32 float64 float128
syn keyword neluaBuiltin        auto array pointer varargs type niltype
syn keyword neluaTable          record union enum
syn keyword neluaAnnotation     cint cimport nodecl const comptime volatile inline
syn keyword neluaSelf           self

syn keyword neluaStatement      goto
syn match neluaLabel            "::\I\i*::"
syn keyword neluaOperator       and or not
syn keyword neluaConstant       nil nilptr
syn keyword neluaConstant       true false

" Strings
syn match  neluaspecial contained #\\[\\abfnrtvz'"]\|\\x[[:xdigit:]]\{2}\|\\[[:digit:]]\{,3}#

syn region neluastring2 
      \ matchgroup=neluastring 
      \ start="\[\z(=*\)\[" end="\]\z1\]" 
      \ contains=@spell

syn region neluaString  start=+'+ end=+'+ skip=+\\\\\|\\'+ contains=neluaSpecial,@Spell
syn region neluaString  start=+"+ end=+"+ skip=+\\\\\|\\"+ contains=neluaSpecial,@Spell

" integer number
"syn match neluaNumber \"\<\d\+\>"
" floating point number, with dot, optional exponent
"syn match neluaNumber  \"\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
" floating point number, starting with a dot, optional exponent
"syn match neluaNumber  \"\.\d\+\%([eE][-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
"syn match neluaNumber  \"\<\d\+[eE][-+]\=\d\+\>"

" The code below is directly taken from nim.vim plugin.
" Special thanks go to its original creators / implementors.
"
" numbers (including longs and complex)
let s:dec_num = '\d%(_?\d)*'
let s:int_suf = '%(_%(%(u)?%(%(i)%(nteger)?)?%(8|16|32|64|128)?))'
let s:float_suf = '%(_%(%(f%(loat)?)%(32|64|128)))'
let s:exp = '%([eE][+-]?'.s:dec_num.')'
exe 'syn match neluaNumber /\v<0[bB][01]%(_?[01])*%('.s:int_suf.'|'.s:float_suf.')?>/'
exe 'syn match neluaNumber /\v<0[ocC]\o%(_?\o)*%('.s:int_suf.'|'.s:float_suf.')?>/'
exe 'syn match neluaNumber /\v<0[xX]\x%(_?\x)*%('.s:int_suf.'|'.s:float_suf.')?>/'
exe 'syn match neluaNumber /\v<'.s:dec_num.'%('.s:int_suf.'|'.s:exp.'?'.s:float_suf.'?)>/'
exe 'syn match neluaNumber /\v<'.s:dec_num.'\.'.s:dec_num.s:exp.'?'.s:float_suf.'?>/'
unlet s:dec_num s:int_suf s:float_suf s:exp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" hex numbers
syn match neluaNumber "\<0[xX][[:xdigit:].]\+\%([pP][-+]\=\d\+\)\=\>"

syn keyword neluaFunc assert collectgarbage dofile error next
syn keyword neluaFunc print rawget rawset tonumber tostring _VERSION

syn keyword neluaFunc getmetatable setmetatable
syn keyword neluaFunc ipairs pairs
syn keyword neluaFunc pcall xpcall
syn keyword neluaFunc _G loadfile rawequal require
syn keyword neluaFunc load select
syn match   neluaFunc /\<package\.cpath\>/
syn match   neluaFunc /\<package\.loaded\>/
syn match   neluaFunc /\<package\.loadlib\>/
syn match   neluaFunc /\<package\.path\>/
syn match   neluaFunc /\<coroutine\.running\>/
syn match   neluaFunc /\<coroutine\.create\>/
syn match   neluaFunc /\<coroutine\.resume\>/
syn match   neluaFunc /\<coroutine\.status\>/
syn match   neluaFunc /\<coroutine\.wrap\>/
syn match   neluaFunc /\<coroutine\.yield\>/
syn match   neluaFunc /\<string\.byte\>/
syn match   neluaFunc /\<string\.char\>/
syn match   neluaFunc /\<string\.dump\>/
syn match   neluaFunc /\<string\.find\>/
syn match   neluaFunc /\<string\.format\>/
syn match   neluaFunc /\<string\.gsub\>/
syn match   neluaFunc /\<string\.len\>/
syn match   neluaFunc /\<string\.lower\>/
syn match   neluaFunc /\<string\.rep\>/
syn match   neluaFunc /\<string\.sub\>/
syn match   neluaFunc /\<string\.upper\>/
syn match   neluaFunc /\<string\.gmatch\>/
syn match   neluaFunc /\<string\.match\>/
syn match   neluaFunc /\<string\.reverse\>/
syn match   neluaFunc /\<table\.pack\>/
syn match   neluaFunc /\<table\.unpack\>/
syn match   neluaFunc /\<table\.concat\>/
syn match   neluaFunc /\<table\.sort\>/
syn match   neluaFunc /\<table\.insert\>/
syn match   neluaFunc /\<table\.remove\>/
syn match   neluaFunc /\<math\.abs\>/
syn match   neluaFunc /\<math\.acos\>/
syn match   neluaFunc /\<math\.asin\>/
syn match   neluaFunc /\<math\.atan\>/
syn match   neluaFunc /\<math\.atan2\>/
syn match   neluaFunc /\<math\.ceil\>/
syn match   neluaFunc /\<math\.sin\>/
syn match   neluaFunc /\<math\.cos\>/
syn match   neluaFunc /\<math\.tan\>/
syn match   neluaFunc /\<math\.deg\>/
syn match   neluaFunc /\<math\.exp\>/
syn match   neluaFunc /\<math\.floor\>/
syn match   neluaFunc /\<math\.log\>/
syn match   neluaFunc /\<math\.max\>/
syn match   neluaFunc /\<math\.min\>/
syn match   neluaFunc /\<math\.huge\>/
syn match   neluaFunc /\<math\.fmod\>/
syn match   neluaFunc /\<math\.modf\>/
syn match   neluaFunc /\<math\.cosh\>/
syn match   neluaFunc /\<math\.sinh\>/
syn match   neluaFunc /\<math\.tanh\>/
syn match   neluaFunc /\<math\.pow\>/
syn match   neluaFunc /\<math\.rad\>/
syn match   neluaFunc /\<math\.sqrt\>/
syn match   neluaFunc /\<math\.frexp\>/
syn match   neluaFunc /\<math\.ldexp\>/
syn match   neluaFunc /\<math\.random\>/
syn match   neluaFunc /\<math\.randomseed\>/
syn match   neluaFunc /\<math\.pi\>/
syn match   neluaFunc /\<io\.close\>/
syn match   neluaFunc /\<io\.flush\>/
syn match   neluaFunc /\<io\.input\>/
syn match   neluaFunc /\<io\.lines\>/
syn match   neluaFunc /\<io\.open\>/
syn match   neluaFunc /\<io\.output\>/
syn match   neluaFunc /\<io\.popen\>/
syn match   neluaFunc /\<io\.read\>/
syn match   neluaFunc /\<io\.stderr\>/
syn match   neluaFunc /\<io\.stdin\>/
syn match   neluaFunc /\<io\.stdout\>/
syn match   neluaFunc /\<io\.tmpfile\>/
syn match   neluaFunc /\<io\.type\>/
syn match   neluaFunc /\<io\.write\>/
syn match   neluaFunc /\<os\.clock\>/
syn match   neluaFunc /\<os\.date\>/
syn match   neluaFunc /\<os\.difftime\>/
syn match   neluaFunc /\<os\.execute\>/
syn match   neluaFunc /\<os\.exit\>/
syn match   neluaFunc /\<os\.getenv\>/
syn match   neluaFunc /\<os\.remove\>/
syn match   neluaFunc /\<os\.rename\>/
syn match   neluaFunc /\<os\.setlocale\>/
syn match   neluaFunc /\<os\.time\>/
syn match   neluaFunc /\<os\.tmpname\>/
syn match   neluaFunc /\<debug\.debug\>/
syn match   neluaFunc /\<debug\.gethook\>/
syn match   neluaFunc /\<debug\.getinfo\>/
syn match   neluaFunc /\<debug\.getlocal\>/
syn match   neluaFunc /\<debug\.getupvalue\>/
syn match   neluaFunc /\<debug\.setlocal\>/
syn match   neluaFunc /\<debug\.setupvalue\>/
syn match   neluaFunc /\<debug\.sethook\>/
syn match   neluaFunc /\<debug\.traceback\>/

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

hi def link neluaAnnotation     Identifier
hi def link neluaBraceError     Error
hi def link neluaBuiltin        neluaType
hi def link neluaComment        Comment
hi def link neluaCond           Conditional
hi def link neluaConstant       Constant
hi def link neluaElse           Conditional
hi def link neluaError          Error
hi def link neluaFloat          Float
hi def link neluaFor            Repeat
hi def link neluaFunc           Identifier
hi def link neluaFunction       Function
hi def link neluaIn             Operator
hi def link neluaKeyword        Keyword
hi def link neluaLabel          Label
hi def link neluaNumber         Number
hi def link neluaOperator       Operator
hi def link neluaParenError     Error
hi def link neluaPreProc        PreProc
hi def link neluaRepeat         Repeat
hi def link neluaSelf           Constant
hi def link neluaSpecial        SpecialChar
hi def link neluaStatement      Statement
hi def link neluaString         String
hi def link neluaString2        String
hi def link neluaTable          Structure
hi def link neluaTodo           Todo
hi def link neluaType           Type


let b:current_syntax = "nelua"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: et ts=8 sw=2
