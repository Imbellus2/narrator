local Story = require(script.story)

local narrator = { }

---Init a story based on the book
---@param book Narrator.Book
---@return Narrator.Story
function narrator.init_story(book)
  local story = Story.new(book)
  Story.begin(story)
  return story
end

---Step through story
---@param story Narrator.Story
---@return table - Output text
function narrator.continue(story)
  local paragraph_table = { }
  if Story.can_continue(story) or Story.can_choose(story) then
    local paragraphs = Story.continue(story)
    for _, paragraph in ipairs(paragraphs or { }) do
      local text = paragraph.text or ''
      if paragraph.tags then
        local hashtag = #text > 0 and ' #' or '#'
        text = text .. hashtag .. table.concat(paragraph.tags, ' #')
      end
      table.insert(paragraph_table, text)
    end
    local choices = Story.get_choices(story)
    local content = { paragraphs = paragraph_table, choices = choices }
    return { content = content, story = story }
  end
end

---Choose choice in story
---@param story Narrator.Story
---@param index number
---@return Narrator.Story
function narrator.choose(story, index)
  -- Check if the story can accept a choice
  if not Story.can_choose(story) then
    error("Cannot choose at this point in the story.")
  end

  -- Get the available choices
  local choices = Story.get_choices(story)

  -- Check if the index is within the valid range
  if index < 1 or index > #choices then
    error("Choice index out of range.")
  end

  -- Make the choice
  Story.choose(story, index)
  return story
end

return narrator