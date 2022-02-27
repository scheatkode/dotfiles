local has_annotation, annotation = pcall(require, 'neogen')

if not has_annotation then
   print('Tried loading plugin ... unsuccessfully ‼', 'neogen')
   return has_annotation
end

annotation.setup({
   enabled = true,

   languages = {
      cs = {
         template = {
            annotation_convention = 'xmldoc',
         }
      },
   }
})
