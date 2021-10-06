if exists('b:current_syntax')
  finish
endif

syn case match

syn keyword     apiDirective         syntax import
syn keyword     apiDeclaration       type service info
syn keyword     apiDeclType          struct interface

hi def link     apiDirective         Statement
hi def link     apiDeclaration       Keyword
hi def link     apiDeclType          Keyword

syn keyword     apiStatement         returns get post delete put
hi def link     apiStatement         Statement

syn match       goType              /\<func\>/
syn match       goDeclaration       /^func\>/

syn keyword     apiType              chan map bool string error
syn keyword     apiSignedInts        int int8 int16 int32 int64 rune
syn keyword     apiUnsignedInts      byte uint uint8 uint16 uint32 uint64 uintptr
syn keyword     apiFloats            float32 float64
syn keyword     apiComplexes         complex64 complex128

hi def link     apiType             Type
hi def link     apiSignedInts       Type 
hi def link     apiUnsignedInts     Type 
hi def link     apiFloats           Type 
hi def link     apiComplexes        Type

" Strings and their contents
syn region      apiString            start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region      apiRawString         start=+`+ end=+`+

hi def link     apiString            String
hi def link     apiRawString         String

syn region      goCharacter         start=+'+ skip=+\\\\\|\\'+ end=+'+

hi def link     goCharacter         Character

let b:current_syntax = 'api'
