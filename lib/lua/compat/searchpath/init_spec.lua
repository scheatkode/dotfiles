local searchpath = require("compat.searchpath")

describe("compat", function()
	describe("package.searchpath()", function()
		local original_searchpath = package.searchpath

		before_each(function()
			package.searchpath = nil
			package.loaded["compat.searchpath"] = nil
			package.searchpath = require("compat.searchpath")
		end)

		after_each(function()
			package.searchpath = original_searchpath
		end)

		it(
			"should match the original function behaviour when a package is found",
			function()
				local path = "lib/lua/?/init.lua"

				assert.is_truthy(
					searchpath("compat", path):match("lib[/\\]lua[/\\]compat")
				)
			end
		)

		local path = "some/?/random.path;another/?.path"

		it(
			"should match the original function behaviour when a package is not found",
			function()
				local ok, err = searchpath("some.file.name", path, ".", "/")

				assert.is_nil(ok)
				assert.same(
					"\n\tno file 'some/some/file/name/random.path'\n\tno file 'another/some/file/name.path'",
					err
				)
			end
		)

		it(
			"should match the original function behaviour when a package is not found",
			function()
				local ok, err = searchpath("some/file/name", path, "/", ".")

				assert.is_nil(ok)
				assert.same(
					"\n\tno file 'some/some.file.name/random.path'\n\tno file 'another/some.file.name.path'",
					err
				)
			end
		)
	end)
end)
