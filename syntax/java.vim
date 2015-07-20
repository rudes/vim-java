" Language: Java
" Maintainer: Jacob Riddle <jacobriddle94@gmail.com>
" Last Change: 2015 Jul 19
"finish
if exists("b:current_syntax")
	finish
endif

syn region javaFold start="{" end="}" transparent fold

if !exists("main_syntax")
	let main_syntax='java'
endif

let s:cpo_save = &cpo
set cpo&vim

" Errors
" Characters that don't belong outside of a string in Java
syn match javaError "[\\@`]"
syn match javaError "<<<\|\.\.\|=>\|||=\|&&=\|[^-]->\|\*\/"
syn match javaSpecialError contained "\\."
syn match javaSpecialCharError contained "[^']"

syn match javaOK "\.\.\."

" Seperate name so that it can be deleted in javacc.vim
syn match javaError2 "#\|=<"
syn keyword javaError goto const
hi def link javaSpecialError javaError
hi def link javaSpecialCharError javaError
hi def link javaError2 javaError

hi def link javaError Error

" Keywords
syn keyword javaTypedef this super
syn keyword javaOperator new instanceof try catch
syn keyword javaStorageClass static synchronized transient volatile final strictfp seralizable
syn keyword javaExceptions throw finally
syn keyword javaAssert assert
syn keyword javaMethodDecl synchronized throws
syn keyword javaClassDecl extends implements interface
syn keyword javaDeclType enum
syn match javaTypedef "\.\s*\<class\>"ms=s+1
syn match javaClassDecl "^class\>"
syn match javaClassDecl "[^.]\s*\<class\>"ms=s+1
syn match javaAnnotation "@\([_$a-zA-Z][_$a-zA-Z0-9]*\.\)*[_$a-zA-Z][_$a-zA-Z0-9]*\>"
syn match javaClassDecl "@interface\>"
syn keyword javaScopeDecl public protected private abstract

hi def link javaMethodDecl javaStorageClass
hi def link javaClassDecl javaStorageClass
hi def link javaScopeDecl javaStorageClass
hi def link javaAssert javaStatement

hi def link javaStorageClass StorageClass
hi def link javaTypedef Typedef
hi def link javaAnnotation PreProc
hi def link javaExceptions Exceptions
hi def link javaOperator Operator
hi def link javaDeclType Keyword

" Data Types
syn keyword javaType boolean char byte short int long float double void
syn keyword javaNonPrimitiveType String Integer
syn match javaMapType "Map\+<\@=\|ArrayList\+<\@="
syn match javaPublicType "^\s\+\w\+\(\s\+\w\+\s*=\)\@="
syn match javaPublicType "\((\)\@<=\w\+\(\s\w\+)\)\@="
hi def link javaPublicType javaType
hi def link javaNonPrimitiveType javaType

hi def link javaMapType Keyword
hi def link javaType Type

" Constants
syn keyword javaConstant null
syn keyword javaBoolean true false
hi def link javaBoolean javaConstant

hi def link javaConstant Constant

" Includes
syn keyword javaExternal native package
syn match javaExternal "\<import\>\(\s\+static\>\)\?"

hi def link javaExternal Include

" Keywords in functions
syn keyword javaBranch break continue nextgroup=javaUserLabelRef skipwhite
syn match javaUserLabelRef "\.\.\."
syn keyword javaConditional if else switch
syn keyword javaRepeat while for do
syn keyword javaStatement return
hi def link javaBranch javaStatement

hi def link javaStatement Statement
hi def link javaConditional Conditional
hi def link javaRepeat Repeat

" Comments
syn keyword javaTodo contained TODO FIXME XXX
syn cluster javaCommentGroup contains=javaTodo
syn region javaComment start="/\*" end="\*/" contains=@javaCommentGroup,@Spell
syn region javaComment start="//" end="$" contains=@javaCommentGroup,@Spell

hi def link javaComment Comment
hi def link javaTodo Todo

" Strings and Numbers
syn match javaSpecialChar contained "\\\([4-9]\d\|[0-3]\d\d\|[\"\\'ntbrf]\|u\x\{4\}\)"
syn region javaString start=+"+ end=+"+ end=+$+ contains=javaSpecialChar,javaSpecialError,@Spell
syn match javaCharacter "'[^']*'" contains=javaSpecialChar,javaSpecialCharError
syn match javaCharacter "'\\''" contains=javaSpecialChar
syn match javaCharacter "'[^\\]'"
syn match javaNumber "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[1L]\=\>"
syn match javaNumber "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match javaNumber "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match javaNumber "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"
" Unicode
syn match javaSpecial "\\u\d\{4\}"

hi def link javaString String
hi def link javaCharacter Character
hi def link javaSpecialChar Character
hi def link javaNumber Number


" Functions
syn match javaFunction /\(\.\)\@<=\w\+\((\)\@=/
syn match javaFunction /\(\ \)\@<=\w\+\((\)\@=/

hi def link javaFunction Function


" Operators

syn match javaOperator "[-+%<>!&]^*=]=\?"

hi def link javaOperator Operator


let b:current_syntax = "java"

if main_syntax == 'java'
	unlet main_syntax
endif

let b:spell_options="contained"
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
