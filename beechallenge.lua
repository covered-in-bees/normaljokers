--- STEAMODDED HEADER
--- MOD_NAME: Test Challenges
--- MOD_ID: TestChallenges
--- PREFIX: testch
--- MOD_AUTHOR: [bees]
--- MOD_DESCRIPTION: Testing jokers.

----------------------------------------------
------------MOD CODE -------------------------


SMODS.Challenge({
    name = "Bee Testing",
    key = "beetestchallenge",
	id = "beetestchallenge",
	loc_txt = {
        ["en-us"] = {
            name = "Bee Testing"
        }
    },
    rules = {
        custom = {
            {id = 'no_reward_specific', value = 'Boss'},
        },
        modifiers = {
            {id = 'discards', value = 10},
            {id = 'hands', value = 15},
            {id = 'hand_size', value = 10},
        }
    },
    jokers = {
        {id = 'j_bees_dayjoker'},
	{id = 'j_bees_nightjoker'},
	{id = 'j_bees_highjoker'},
	{id = 'j_bees_arsonist'},
	{id = 'j_bees_tomato'},
	{id = 'j_bees_bogdonoff'},
    },
    deck = {
        type = 'Challenge Deck'
    },
        consumeables = {
            {id = 'c_strength'},
	{id = 'c_lovers'},
	{id = 'c_lovers'},
	{id = 'c_lovers'},
	{id = 'c_lovers'},
        },
    restrictions = {
            banned_cards = {
            },
            banned_tags = {
            },
            banned_other = {
            }
     }
})

SMODS.Challenge({
    name = "Gay Agenda",
    key = "gayagenda",
	id = "gayagenda",
	loc_txt = {
        ["en-us"] = {
            name = "Gay Agenda"
        }
    },
    rules = {
        custom = {
            {id = 'no_reward_specific', value = 'Boss'},
        },
        modifiers = {
            {id = 'discards', value = 10},
            {id = 'hands', value = 15},
            {id = 'hand_size', value = 10},
        }
    },
    jokers = {
	{id = 'j_bees_gayjoker'},
	{id = 'j_shortcut'},
	{id = 'j_four_fingers'},
	{id = 'j_caino'},
    },
    deck = {
        type = 'Challenge Deck'
    },
        consumeables = {
            {id = 'c_strength'},
        },
    restrictions = {
            banned_cards = {
            },
            banned_tags = {
            },
            banned_other = {
            }
     }
})
----------------------------------------------
------------MOD CODE END----------------------