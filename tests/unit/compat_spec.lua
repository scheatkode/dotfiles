local compat = require('compat')

describe('compatibilty', function ()
   describe('of neovim', function ()
      it('should detect being inside neovim', function ()
         local should_detect_vim = not not vim
         assert.same(should_detect_vim, compat.neovim)
      end)
   end)

   describe('of load', function ()
      local code_generator = coroutine.wrap(function ()
         local result = { 'ret', 'urn \'Hello there !\'' }

         for _, v in ipairs(result) do
            coroutine.yield(v)
         end

         coroutine.yield(nil)
      end)

      it('should match the original function behaviour', function ()
         local f, err = compat.load(code_generator)

         assert.same(nil, err)
         assert.same(f(), 'Hello there !')
      end)
   end)

      describe('of package.searchpath', function ()
         it('should match the original function behaviour when a package is found', function ()
            local path = 'lib/lua/?.lua'

            assert.is_truthy(
               compat
                  .package_searchpath('compat', path)
                  :match('lib[/\\]lua[/\\]compat')
            )
         end)

         local path = 'some/?/random.path;another/?.path'

         it('should match the original function behaviour when a package is not found', function ()
            local ok, err = compat.package_searchpath('some.file.name', path, '.', '/')

            assert.is_nil(ok)
            assert.same(
               '\n\tno file \'some/some/file/name/random.path\'\n\tno file \'another/some/file/name.path\'',
               err
            )
         end)

         it('should match the original function behaviour when a package is not found', function ()
            local ok, err = compat.package_searchpath('some/file/name', path, '/', '.')

            assert.is_nil(ok)
            assert.same(
               '\n\tno file \'some/some.file.name/random.path\'\n\tno file \'another/some.file.name.path\'',
               err
            )
         end)
      end)
end)
