(
 (function_call
   (identifier) @require_call
   (#match? @require_call "require")
   )
 (set! "priority" 105)
 )

(
 (function_call
   (identifier) @pairs
   (#match? @pairs "pairs")
   )
 (set! "priority" 105)
 )

(function_declaration
  (identifier)@function_definition
  )
(
 (function_declaration
   (dot_index_expression
     (identifier)
     (identifier)@function_definition
     )
   )
 (set! "priority" 105)
 )

(
 (assignment_statement
   (variable_list
     (identifier)@function_definition
     )
   (
    expression_list
    (function_definition)
    )
   )
 (set! "priority" 105)
 )
(
 (assignment_statement
   (variable_list
     (dot_index_expression
       (identifier)
       (identifier)@function_definition
       )
     )
   (
    expression_list
    (function_definition)
    )
   )
 (set! "priority" 105)
 )

(
  (function_call
    name: (identifier) @keyword
    (#eq? @keyword "pairs")
  )
  (#set! conceal "P")
)

(
  (function_call
    name: (identifier) @keyword
    (#eq? @keyword "ipairs")
  )
  (#set! conceal "I")
)

(("return" @keyword) (#set! conceal "R"))
(("local" @keyword) (#set! conceal "L"))
(("function" @keyword) (#set! conceal "F"))
