---@type string
local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

---@param path string
local function have(path)
  return vim.loop.fs_stat(xdg_config .. "/" .. path) ~= nil
end

return {
  -- add some stuff to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      local function add(lang)
        if type(opts.ensure_installed) == "table" then
          table.insert(opts.ensure_installed, lang)
        end
      end

      vim.filetype.add({
        extension = { rasi = "rasi" },
        pattern = {
          [".*/waybar/config"] = "jsonc",
          [".*/mako/config"] = "dosini",
          [".*/kitty/*.conf"] = "bash",
          [".*/hypr/.*%.conf"] = "hyprlang",
        },
      })

      add("git_config")

      if have("hypr") then
        add("hyprlang")
      end

      if have("fish") then
        add("fish")
      end

      if have("rofi") or have("wofi") then
        add("rasi")
      end
    end,
  },
}
