return {
   {
      'vim-denops/denops.vim',
      event = "BufRead",
   },
   {
      'lambdalisue/kensaku-search.vim',
      event = "BufRead",
      config = function()
         vim.keymap.set('c', '<C-j>', '<Plug>(kensaku-search-replace)<CR>')
      end
   },
   {
      'lambdalisue/kensaku.vim',
      event = "BufRead",
   },
   {
      'yuki-yano/fuzzy-motion.vim',
      event = "BufRead",
      config = function()
         vim.keymap.set('', 's', '<cmd>FuzzyMotion<CR>')
         vim.g.fuzzy_motion_matchers = "['kensaku', 'fzf']"
      end
   },
}
