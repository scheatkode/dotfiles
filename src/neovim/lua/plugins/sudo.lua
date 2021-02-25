local apply_conf = require('core/config').variables.use

local configuration = {
   ['suda#prompt'] = "What's the magic word ? "
}

apply_conf('g', configuration)
