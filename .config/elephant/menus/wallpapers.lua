--
-- Dynamic Wallpaper Menu for Elephant/Walker
--
Name = "wallpapers"
NamePretty = "Wallpapers"

-- Check if file exists
local function file_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

-- The main function elephant will call
function GetEntries()
  local entries = {}
  local home = os.getenv("HOME")
  local wallpaper_dir = home .. "/Wallpapers"

  -- Single find call to list image files
  local handle = io.popen(
    "find -L '" .. wallpaper_dir .. "' -maxdepth 1 -type f " ..
    "\\( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \\) 2>/dev/null"
  )

  if not handle then
    return entries
  end

  for file_path in handle:lines() do
    local file_name = file_path:match(".*/(.+)$")

    if file_name and file_exists(file_path) then
      local display_name = file_name
        :gsub("%.%w+$", "")         -- remove extension
        :gsub("_", " ")
        :gsub("%-", " ")
        :gsub("(%a)([%w_']*)", function(first, rest)
          return first:upper() .. rest:lower()
        end)

      table.insert(entries, {
        Text = display_name,
        Preview = file_path,
        PreviewType = "file",
        Actions = {
          activate = "matugen image --source-color-index 0 '" .. file_path .. "'",
        },
      })
    end
  end

  handle:close()
  return entries
end
