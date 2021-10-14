; (
;   (function_call
;     (field_expression) @_vimcmd_identifier
;     (arguments (string) @vim)
;   )

;   (#eq? @_vimcmd_identifier "vim.cmd")
;   (
;     ; (#match? @vim "^\[\[") <- This is screwing stuff up
;     (#offset! @vim 0 2 0 -2)
;   )
; )
