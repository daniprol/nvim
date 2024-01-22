return {
  'echasnovski/mini.bracketed',
  version = '*',
  opts = {
    --   Supply empty string `''` to not create mappings.
    -- - <options> - table overriding target options.
    -- See `:h MiniBracketed.config` for more info.
    buffer     = { suffix = '', options = {} },
    comment    = { suffix = 'c', options = {} }, -- Comment block
    conflict   = { suffix = 'x', options = {} }, -- Git conflicts
    diagnostic = { suffix = 'd', options = {} },
    -- file       = { suffix = 'f', options = {} }, -- Next file on CWD
    file       = { suffix = '', options = {} },
    indent     = { suffix = '', options = {} }, -- Change indent
    jump       = { suffix = '', options = {} }, -- Jumplist inside current buffer
    location   = { suffix = 'l', options = {} },
    oldfile    = { suffix = '', options = {} },
    quickfix   = { suffix = 'q', options = {} },
    treesitter = { suffix = 't', options = {} }, -- Treesitter nodes and parents
    -- undo       = { suffix = 'u', options = {} }, -- Linear undo history
    undo       = { suffix = '', options = {} },
    window     = { suffix = '', options = {} },
    yank       = { suffix = 'y', options = {} }, -- Yank selection replacing latest put region
  }
}
