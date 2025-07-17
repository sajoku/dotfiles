vim.filetype.add({
  extension = {
    strings = "yaml",
    md = "markdown",
    jbuilder = "ruby",
    eex = "html",
    exs = "elixir",
    handlebars = "mustache",
  },
  filename = {
    ["Gemfile"] = "ruby",
    ["Rakefile"] = "ruby",
    ["Guardfile"] = "ruby",
    ["Vagrantfile"] = "ruby",
    ["Thorfile"] = "ruby",
    ["Capfile"] = "ruby",
    ["config.ru"] = "ruby",
  },
})
