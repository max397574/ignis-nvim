(list_item
    (paragraph)@list_item.inner
)@list_item.outer

(task_list_item
    (paragraph
        (text)@list_item.inner
    )
)@list_item.outer


(fenced_code_block
    (code_fence_content)@code_block.inner
)@code_block.outer
