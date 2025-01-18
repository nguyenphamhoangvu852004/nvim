return {

  "nvim-neo-tree/neo-tree.nvim",
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      source_selector = {
        winbar = true,
        statusline = true,
      },
    })
  end,
}
