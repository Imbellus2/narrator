-- TODO: Commenting parser code out for now until we decide if we want to refactor it with https://github.com/pygy/LuLPeg
-- local lume = require(script.libs.lume)
-- local enums = require(script.enums)
-- local parser = require(script.parser)
local Story = require(script.story)

--
-- Local

-- local folder_separator = "/"

---Clear path from '.lua' and '.ink' extensions and replace '.' to '/' or '\'
---@param path string
---@return string normalized_path
-- local function normalize_path(path)
--   local path = path:gsub('.lua$', '')
--   local path = path:gsub('.ink$', '')

--   if path:match('%.') and not path:match(folder_separator) then
--     path = path:gsub('%.', folder_separator)
--   end

--   return path
-- end

---Parse an .ink file to the content string.
---@param path string
---@return string content
-- local function read_ink_file(path)
--   local path = normalize_path(path) .. '.ink'

--   local file = io.open(path, 'r')
--   assert(file, 'File doesn\'t exist: ' .. path)

--   local content = file:read('*all')
--   file:close()

--   return content
-- end

---Save a book to the lua module
---@param book Narrator.Book
---@param path string
---@return boolean success
-- local function save_book(book, path)
--   local path = normalize_path(path)  .. '.lua'

--   local data = lume.serialize(book)
--   data = data:gsub('%[%d+%]=', '')
--   data = data:gsub('[\'[%w_]+\']', function(match) return
--     match:sub(3, #match - 2)
--   end)

--   local file = io.open(path, 'w')
--   if file == nil then
--     return false
--   end

--   file:write('return ' .. data)
--   file:close()

--   return true
-- end

---Merge a chapter to the book
---@param book Narrator.Book
---@param chapter Narrator.Book
---@return Narrator.Book
-- local function merge_chapter_to_book(book, chapter)
--   -- Check a engine version compatibility
--   if chapter.version.engine and chapter.version.engine ~= enums.engine_version then
--     assert('Version ' .. chapter.version.engine .. ' of book isn\'t equal to the version ' .. enums.engine_version .. ' of Narrator.')
--   end

--   --Merge the root knot and it's stitch
--   book.tree._._ = lume.concat(chapter.tree._._, book.tree._._)
--   chapter.tree._._ = nil
--   book.tree._ = lume.merge(chapter.tree._, book.tree._)
--   chapter.tree._ = nil

--   --Merge a chapter to the book
--   book.tree = lume.merge(book.tree or { }, chapter.tree or { })
--   book.constants = lume.merge(book.constants or { }, chapter.constants or { })
--   book.lists = lume.merge(book.lists or { }, chapter.lists or { })
--   book.variables = lume.merge(book.variables or { }, chapter.variables or { })
--   book.params = lume.merge(book.params or { }, chapter.params or { })

--   return book
-- end

--
-- Public

local narrator = { }

---Parse a book from an Ink file
---Use it during development, but prefer already parsed and stored books in production
---Requires `lpeg` and `io`.
---@param path string
---@param params Narrator.ParsingParams|nil
---@return Narrator.Book
-- function narrator.parse_file(path, params)
--   local params = params or { save = false }
--   assert(parser, 'Can\'t parse anything without lpeg, sorry.')

--   local content = read_ink_file(path)
--   local book = parser.parse(content)

--   for _, inclusion in ipairs(book.inclusions) do
--     local folder_path = normalize_path(path):match('(.*' .. folder_separator .. ')')
--     local inclusion_path = folder_path .. normalize_path(inclusion) .. '.ink'
--     local chapter = narrator.parse_file(inclusion_path)

--     merge_chapter_to_book(book, chapter)
--   end

--   if params.save then
--     save_book(book, path)
--   end

--   return book
-- end

---Parse a book from the ink content string
---Use it during development, but prefer already parsed and stored books in production
---Requires `lpeg`
---@param content string
---@param inclusions string[]
---@return Narrator.Book
-- function narrator.parse_content(content, inclusions)
--   local inclusions = inclusions or { }
--   assert(parser, 'Can\'t parse anything without a parser.')

--   local book = parser.parse(content)

--   for _, inclusion in ipairs(inclusions) do
--     local chapter = parser.parse(inclusion)
--     merge_chapter_to_book(book, chapter)
--   end

--   return book
-- end

---Init a story based on the book
---@param book Narrator.Book
---@return Narrator.Story
function narrator.init_story(book)
  local story = Story(book)
  story:begin()
  return story
end

---Step through story
---@param story Narrator.Story
---@return table - Output text
function narrator.continue(story)
  local paragraph_table = { }
  if story:can_continue() or story:can_choose() then
    local paragraphs = story:continue()
    for _, paragraph in ipairs(paragraphs or { }) do
      local text = paragraph.text or ''
      if paragraph.tags then
        local hashtag = #text > 0 and ' #' or '#'
        text = text .. hashtag .. table.concat(paragraph.tags, ' #')
      end
      table.insert(paragraph_table, text)
    end
    local choices = story:get_choices()
    local state = { paragraphs = paragraph_table, choices = choices }
    return state
  end
end

---Choose choice in story
---@param story Narrator.Story
---@param index number
---@return Narrator.Story
function narrator.choose(story, index)
  -- Check if the story can accept a choice
  if not story:can_choose() then
    error("Cannot choose at this point in the story.")
  end

  -- Get the available choices
  local choices = story:get_choices()

  -- Check if the index is within the valid range
  if index < 1 or index > #choices then
    error("Choice index out of range.")
  end

  -- Make the choice
  story:choose(index)
  return story
end

return narrator