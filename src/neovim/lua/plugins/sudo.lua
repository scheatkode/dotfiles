local apply_conf = require('lib.config').variables.use

local configuration = {
   ['suda#prompt'] = "What's the magic word ? "
}

apply_conf('g', configuration)
