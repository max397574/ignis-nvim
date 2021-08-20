(
    (command 
        (command_name)@mapping_command
    )
    (#match? @mapping_command "inoremap|nnoremap|vnoremap")
    (set! "priority" 105)
)
