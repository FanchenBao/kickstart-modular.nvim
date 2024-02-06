local util = {}

--- Auxiliary function to build as set
--- Taken from https://www.lua.org/pil/11.5.html
---@param list Array a list of values to turn into a set
---@return table # table pretending as set
function util.Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

return util


