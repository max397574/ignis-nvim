local settings = {
  header = {
    type = "text",
    content = require("startup.buildingblocks.headers").hydra(),
    align = "center",
  },
  footer = {
    type = "text",
    content = require("startup.buildingblocks.functions").quote(),
    align = "center",
  },
}

return settings
