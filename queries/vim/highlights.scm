(
    (command 
        (command_name)@keyword
    )
    (#match? @keyword "augroup")
        (set! "priority" 105)
)
