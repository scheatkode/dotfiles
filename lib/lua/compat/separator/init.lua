---The directory separator character for the current platform.
---`/` on unixes, `\\` on windows.
return _G.package.config:sub(1, 1)
