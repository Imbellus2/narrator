return {
	["constants"] = {},
	["tree"] = {
		["_"] = {
			["_"] = {
				"I looked at Monsieur Fogg",
				{
					["text"] = "... and I could contain myself no longer.",
					["choice"] = "... and I could contain myself no longer.",
					["node"] = {
						"'What is the purpose of our journey, Monsieur?'",
						"'A wager,' he replied.",
						{
							["text"] = "'A wager!' I returned.",
							["choice"] = "'A wager!'",
							["node"] = {
								"He nodded.",
								{
									["text"] = "'But surely that is foolishness!'",
									["choice"] = "'But surely that is foolishness!'",
								},
								{ ["text"] = "'A most serious matter then!'", ["choice"] = "'A most serious matter then!'" },
								"He nodded again.",
								{
									["text"] = "'But can we win?'",
									["choice"] = "'But can we win?'",
									["node"] = { "'That is what we will endeavour to find out,' he answered." },
								},
								{
									["text"] = "'A modest wager, I trust?'",
									["choice"] = "'A modest wager, I trust?'",
									["node"] = { "'Twenty thousand pounds,' he replied, quite flatly." },
								},
								{
									["text"] = "I asked nothing further of him then, and after a final, polite cough, he offered nothing more to me. <>",
									["choice"] = "I asked nothing further of him then.",
								},
							},
						},
						{ ["text"] = "'Ah,' I replied, uncertain what I thought.", ["choice"] = "'Ah.'" },
						"After that, <>",
					},
				},
				{ ["text"] = "... but I said nothing and <>", ["choice"] = "... but I said nothing" },
				"we passed the day in silence.",
				{ ["divert"] = { ["path"] = "END", ["tunnel"] = false } },
			},
		},
	},
	["params"] = {},
	["lists"] = {},
	["inclusions"] = {},
	["version"] = { ["tree"] = 1, ["engine"] = 2 },
	["variables"] = {},
}
