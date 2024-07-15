![logo](https://user-images.githubusercontent.com/4752473/85455900-141f8f80-b5a7-11ea-8cd7-b441d662b361.png)

# Narrator

[![Release](https://img.shields.io/github/v/release/Imbellus2/narrator.svg?include_prereleases=&sort=semver&color=blue)](https://github.com/Imbellus2/narrator/releases)
[![Website](https://img.shields.io/badge/website-gray.svg?&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxOCIgaGVpZ2h0PSIxNiIgZmlsbD0ibm9uZSIgdmlld0JveD0iMCAwIDE4IDE2Ij48Y2lyY2xlIGN4PSIzLjY2IiBjeT0iMTQuNzUiIHI9IjEuMjUiIGZpbGw9InVybCgjYSkiLz48Y2lyY2xlIGN4PSI4LjY2IiBjeT0iMTQuNzUiIHI9IjEuMjUiIGZpbGw9InVybCgjYikiLz48Y2lyY2xlIGN4PSIxMy42NSIgY3k9IjE0Ljc1IiByPSIxLjI1IiBmaWxsPSJ1cmwoI2MpIi8+PHBhdGggZmlsbD0idXJsKCNkKSIgZmlsbC1ydWxlPSJldmVub2RkIiBkPSJNNy42MyAxLjQ4Yy41LS43IDEuNTUtLjcgMi4wNSAwbDYuMjIgOC44MWMuNTguODMtLjAxIDEuOTctMS4wMyAxLjk3SDIuNDRhMS4yNSAxLjI1IDAgMCAxLTEuMDItMS45N2w2LjIxLTguODFaIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiLz48ZGVmcz48bGluZWFyR3JhZGllbnQgaWQ9ImEiIHgxPSIyLjQxIiB4Mj0iMi40MSIgeTE9IjEzLjUiIHkyPSIxNiIgZ3JhZGllbnRVbml0cz0idXNlclNwYWNlT25Vc2UiPjxzdG9wIHN0b3AtY29sb3I9IiNGRDhENDIiLz48c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiNGOTU0MUYiLz48L2xpbmVhckdyYWRpZW50PjxsaW5lYXJHcmFkaWVudCBpZD0iYiIgeDE9IjcuNDEiIHgyPSI3LjQxIiB5MT0iMTMuNSIgeTI9IjE2IiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHN0b3Agc3RvcC1jb2xvcj0iI0ZEOEQ0MiIvPjxzdG9wIG9mZnNldD0iMSIgc3RvcC1jb2xvcj0iI0Y5NTQxRiIvPjwvbGluZWFyR3JhZGllbnQ+PGxpbmVhckdyYWRpZW50IGlkPSJjIiB4MT0iMTIuNCIgeDI9IjEyLjQiIHkxPSIxMy41IiB5Mj0iMTYiIGdyYWRpZW50VW5pdHM9InVzZXJTcGFjZU9uVXNlIj48c3RvcCBzdG9wLWNvbG9yPSIjRkQ4RDQyIi8+PHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjRjk1NDFGIi8+PC9saW5lYXJHcmFkaWVudD48bGluZWFyR3JhZGllbnQgaWQ9ImQiIHgxPSIuMDMiIHgyPSIuMDMiIHkxPSIuMDMiIHkyPSIxMi4yNiIgZ3JhZGllbnRVbml0cz0idXNlclNwYWNlT25Vc2UiPjxzdG9wIHN0b3AtY29sb3I9IiNGRkU2NUUiLz48c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiNGRkM4MzAiLz48L2xpbmVhckdyYWRpZW50PjwvZGVmcz48L3N2Zz4=)](https://astronachos.com/)

## Overview

The [Ink](https://www.inklestudios.com/ink/) language parser and runtime implementation in Roblox Lua.

Ink is a powerful narrative scripting language. You can find more information about how to write Ink scripts [here](https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md). There is also [Inky](https://github.com/inkle/inky) editor with useful features to test and debug Ink scripts.

Narrator allows to convert raw Ink scripts to the book (a lua table) and play it as story.

- 📖 A book is a passive model on the shelf like a game level.
- ✨ A story is a runtime state of the book reading like a game process.

## Quick example

```lua
local narrator = require('narrator.narrator')

-- Parse a book from the Ink file.
local book = narrator.parse_file('stories.game')

-- Init a story from the book
local story = narrator.init_story(book)

-- Begin the story
story:begin()

while story:can_continue() do

  -- Get current paragraphs to output
  local paragraphs = story:continue()

  for _, paragraph in ipairs(paragraphs) do
    local text = paragraph.text

    -- You can handle tags as you like, but we attach them to text here.
    if paragraph.tags then
      text = text .. ' #' .. table.concat(paragraph.tags, ' #')
    end

    -- Output text to the player
    print(text)
  end

  -- If there is no choice it seems like the game is over
  if not story:can_choose() then break end

  -- Get available choices and output them to the player
  local choices = story:get_choices()
  for i, choice in ipairs(choices) do
    print(i .. ') ' .. choice.text)
  end

  -- Read the choice from the player input
  local answer = tonumber(io.read())

  -- Send answer to the story to generate new paragraphs
  story:choose(answer)
end
```

## Features

### Supported

- [x] Comments: singleline, multiline, todo's
- [x] Tags: global tags, knot tags, stitch tags, paragraph tags
- [x] Paths and sections: inclusions, knots, stitches, labels
- [x] Choices: suppressing and mixing, labels, conditions, sticky and fallback choices, tags
- [x] Branching: diversions, glues, gathers, nesting
- [x] Tunnels
- [x] Alternatives: sequences, cycles, once-only, shuffles, empty steps, nesting
- [x] Multiline alternatives: all the same + shuffle options
- [x] Conditions: logical operations, string queries, if and else statements, nesting
- [x] Multiline conditions: all the same + elseif statements, switches, nesting
- [x] Variables: assignments, constants, global variables, temporary variables, visits, lists
- [x] Lists: logical operations, multivalued lists, multi-list lists, all the queries, work with numbers
- [x] Game queries: all the queries without `TURNS()` and `TURNS_SINCE()`
- [x] State: saving and loading
- [x] Integration: external functions, variables observing, jumping
- [x] Migration: the ability to implement the migration of player's saves after the book update
- [x] Internal functions

### Unsupported

- [ ] [Threads](https://github.com/astrochili/narrator/issues/22)
- [ ] [Divert target as variable type](https://github.com/astrochili/narrator/issues/23)
- [ ] [Assigning string evaluations to variables](https://github.com/astrochili/narrator/issues/24)
- [ ] [Multiple parallel flows](https://github.com/astrochili/narrator/issues/25)

Also there is a list of [known limitations](https://github.com/astrochili/narrator/labels/known%20limitation) on the issues page.

## Installation

### Common case (Löve, pure Lua, etc.)

Download the latest [release archive](https://github.com/astrochili/narrator/releases) and require the `narrator` module.

```lua
local narrator = require('narrator.narrator')
```

Narrator requires [lpeg](http://www.inf.puc-rio.br/~roberto/lpeg/) as dependency to parse Ink content. You can install it with [luarocks](https://luarocks.org/). But we currently do not support the Lpeg library at Roblox, until we do .ink parsing will have to happen offline, stored as a .lua and uploaded as a 'dataset'.

### Parsing .ink files Offline

Follow [this guide](https://docs.google.com/document/d/1kvr5_7Y5QYk1ea53jOyKLnRXfoWBX45ZGG1lvElq9Og/edit?pli=1#heading=h.zi8clh5jyu67) for Narrator installation and offline parsing.

### Running Narrator in Roblox experience

With Narrator.choice, a dynamic string is executed based on the path of the story tree traversal using `loadstring()`. This is by default disabled in production experiences, so enable it as a flag in project.json:

```json
"ServerScriptService": {
    "$className": "ServerScriptService",
    "Scripts": {
        "$path": "src/Server/Scripts"
    },
    "$properties": {
        "LoadStringEnabled": true
    }
},
```


## Documentation

### narrator.parse_file(path, params)

Parses the Ink file at path with all the inclusions and returns a book instance. Path notations `'stories/game.ink'`, `'stories/game'` and `'stories.game'` are valid.

You can save a parsed book to the lua file with the same path by passing `{ save = true }` as `params` table. By default, the `params` table is `{ save = false }`.

```lua
-- Parse a Ink file at path 'stories/game.ink'
local book = narrator.parse_file('stories.game')

-- Parse a Ink file at path 'stories/game.ink'
-- and save the book at path 'stories/game.lua'
local book = narrator.parse_file('stories.game', { save = true })
```
Reading and saving files required `io` so if you can't work with files by this way use `narrator.parse_content()`.

### narrator.parse_content(content, inclusions)

Parses the string with Ink content and returns a book instance. The `inclusions` param is optional and can be used to pass an array of strings with Ink content of inclusions.

```lua
local content = 'Content of a root Ink file'
local inclusions = {
  'Content of an included Ink file',
  'Content of another included Ink file'
}

-- Parse a string with Ink content
local book = narrator.parse_content(content)

-- Parse a string with Ink content and inclusions
local book = narrator.parse_content(content, inclusions)
```

Content parsing is useful when you should manage files by your engine environment and don't want to use `io` module. For example, in Defold, you may want to load ink files as custom resources with [sys.load_resource()](https://defold.com/ref/sys/#sys.load_resource:filename).

### Narrator.init_story(book)

Inits a story instance from the book. This is aclual to use in production. For example, just load a book with `require()` and pass it to this function.

```lua
-- Require a parsed and saved before book
local Narrator = require(ReplicatedStorage.Packages.Narrator)
-- Load runtime story of book
local story = Narrator.init_story(book)
```

### Narrator.continue(story)

Continue a story along the book state

```lua
local Narrator = require(ReplicatedStorage.Packages.Narrator)
local output = Narrator.continue(story)

local story = output.story
local content = output.content

local choices = content.choices
local paragraphs = content.paragraphs
```

### Narrator.choose(story, index)

Make a choice to continue the story. Pass the `index` of the choice that you was received with `get_choices()` before. Will do nothing if `can_continue()` returns `false`.

```lua
local Narrator = require(ReplicatedStorage.Packages.Narrator)
story = Narrator.choose(story, index)
```

## Contribution

### Development

There are some useful extensions and configs for [VSCode](https://code.visualstudio.com/) that I use in development of Narrator.

- [Local Lua Debugger](https://github.com/tomblind/local-lua-debugger-vscode) by [tomblind](https://github.com/tomblind/).
- [Lua Language Server](https://github.com/sumneko/lua-language-server) by [sunmeko](https://github.com/sumneko).
- A task named `Busted` runs tests with `tests/run.lua`.
- A lunch configuration named `Busted` runs the debugger with `tests/run.lua`.
- A lunch configuration named `Debug` runs the debugger with `debug.lua`.



## Third Party Libraries

- [LPeg](http://www.inf.puc-rio.br/~roberto/lpeg/) by [Roberto Ierusalimschy](http://www.inf.puc-rio.br/~roberto/) (MIT Licence).
- [classic](https://github.com/rxi/classic) by [rxi](https://github.com/rxi) (MIT Licence).
- [lume](https://github.com/rxi/lume) by [rxi](https://github.com/rxi) (MIT Licence).
