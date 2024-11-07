--- STEAMODDED HEADER
--- MOD_NAME: beelatro
--- MOD_ID: beelatro
--- PREFIX: bees
--- MOD_AUTHOR: [coveredinbees]
--- MOD_DESCRIPTION: Added some Jokers

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
  key = "beelatro",
  path = "spritesheet.png",
  px = 71,
  py = 95
}

--dayjoker
SMODS.Joker {
	key = 'dayjoker',
	loc_txt = {
		name = 'Day Joker',
		text = {
				"Increase the rank of each ", 	
				"scored {C:hearts}Heart{} card by {C:attention}1{}" 
			}
	},
	config = { extra = { suit = 'Hearts' } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.suit } }
	end,
	rarity = 3,
	cost = 8,
	atlas = "beelatro",                                        --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
	soul_pos = nil,
	pos = { x = 3, y = 0 },
	blueprint_compat = true,                           
	eternal_compat = true,                              
	unlocked = true,                                  
	discovered = true,
	calculate = function(self, card, context)                 
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit(card.ability.extra.suit) then
				local card_to_change = context.other_card
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						local suit_prefix = string.sub(card_to_change.base.suit, 1, 1) .. '_'
						local rank_suffix = card_to_change.base.id == 14 and 2 or math.min(card_to_change.base.id+1, 14)
						if rank_suffix < 10 then
							rank_suffix = tostring(rank_suffix)
						elseif rank_suffix == 10 then
							rank_suffix = 'T'
						elseif rank_suffix == 11 then
							rank_suffix = 'J'
						elseif rank_suffix == 12 then
							rank_suffix = 'Q'
						elseif rank_suffix == 13 then
							rank_suffix = 'K'
						elseif rank_suffix == 14 then
							rank_suffix = 'A'
						end
						card_to_change.dissolve = 1
						card_to_change.dissolve_colours = {G.C.WHITE,G.C.YELLOW}
						G.E_MANAGER:add_event(Event({
							trigger = 'ease',
							blockable = false,
							ref_table = card_to_change,
							ref_value = 'dissolve',
							ease_to = 0,
							delay =  2,
							func = (function(t) return t end)
						}))
						play_sound('whoosh1', math.random()*0.1 + 0.6,0.3)
						play_sound('crumple'..math.random(1,5), math.random()*0.2 + 1.2,0.8)
						card_to_change:set_base(G.P_CARDS[suit_prefix .. rank_suffix])
						card:juice_up()
						return true
					end
				}))
			end
		end
	end
}
--nightjoker
SMODS.Joker {
	key = 'nightjoker',
	loc_txt = {
		name = 'Night Joker',
		text = {
			   "Decrease the rank of each ",            				
				"scored {C:clubs}Club{} card by {C:attention}1{}"
			}
	},
	config = { extra = { suit = 'Clubs' } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.suit } }
	end,
	rarity = 3,
	cost = 8,
	atlas = 'beelatro',                                       
	soul_pos = nil,
	pos = { x = 5, y = 0 },
	blueprint_compat = true,                           
	eternal_compat = true,                              
	unlocked = true,                                  
	discovered = true,
	calculate = function(self, card, context)                
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit(card.ability.extra.suit) then
				local card_to_change = context.other_card
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						local suit_prefix = string.sub(card_to_change.base.suit, 1, 1) .. '_'
						local rank_suffix = card_to_change.base.id == 2 and 14 or math.max(card_to_change.base.id-1, 2)
						if rank_suffix < 10 then
							rank_suffix = tostring(rank_suffix)
						elseif rank_suffix == 10 then
							rank_suffix = 'T'
						elseif rank_suffix == 11 then
							rank_suffix = 'J'
						elseif rank_suffix == 12 then
							rank_suffix = 'Q'
						elseif rank_suffix == 13 then
							rank_suffix = 'K'
						elseif rank_suffix == 14 then
							rank_suffix = 'A'
						end
						--card:start_materialize({G.C.PURPLE,G.C.BLACK}, false, 1.5*G.SETTINGS.GAMESPEED)
						card_to_change.dissolve = 1
						card_to_change.dissolve_colours = {G.C.PURPLE,G.C.BLACK}
						G.E_MANAGER:add_event(Event({
							trigger = 'ease',
							blockable = false,
							ref_table = card_to_change,
							ref_value = 'dissolve',
							ease_to = 0,
							delay =  2,
							func = (function(t) return t end)
						}))
						play_sound('whoosh1', math.random()*0.1 + 0.6,0.3)
						play_sound('crumple'..math.random(1,5), math.random()*0.2 + 1.2,0.8)
						card_to_change:set_base(G.P_CARDS[suit_prefix .. rank_suffix])
						card:juice_up()
						return true
					end
				}))
			end
		end
	end
}
--highjoker
SMODS.Joker {
	key = 'highjoker',
	loc_txt = {
		name = 'High Joker',
		text = {
			"All hands are scored",                	
			"as {C:attention}High Card{}" 
		}
	},
	config = { extra = { var = null } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 1,
	cost = 3,
	atlas = 'beelatro',                                       
	soul_pos = nil,
	pos = { x = 4, y = 0 },
	blueprint_compat = true,                           
	eternal_compat = true,                              
	unlocked = true,                                  
	discovered = true,
	add_to_deck = function(self, card, from_debuff)
		if G.hand.highlighted then
			G.FUNCS.get_poker_hand_info(G.hand.highlighted)
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if G.hand.highlighted then
			G.FUNCS.get_poker_hand_info(G.hand.highlighted)
		end
	end,
	calculate = function(self, context)                 --define calculate functions here
		if context and G.GAME then
		end
	end
}
--arsonist
SMODS.Joker {
	key = 'arsonist',
	loc_txt = {
		name = 'Arsonist',
		text = {
			"When you discard exactly",                
            "{C:attention}#1#{} card, discard your hand"  
		}
	},
	config = { extra = { cards = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	rarity = 2,
	cost = 6,
	atlas = 'beelatro',                                       
	soul_pos = nil,
	pos = { x = 0, y = 0 },
	blueprint_compat = true,                           
	eternal_compat = true,                              
	unlocked = true,                                  
	discovered = true,
	calculate = function(self, card, context)                
		if context.discard and math.min(#G.hand.highlighted, G.discard.config.card_limit - #G.play.cards) == 1 and not context.blueprint then
			card:juice_up()
			local hand_count = #G.hand.cards
			for i=1, hand_count do
				if G.hand.cards[i] ~= G.hand.highlighted[1] then
					draw_card(G.hand, G.discard, i*100/hand_count, 'down', false, G.hand.cards[i])
				end
			end
			return {
				message = "Burn!"
			}
		end
	end
}
--tomato
SMODS.Joker {
	key = 'tomato',
	loc_txt = {
		name = 'Tomato',
		text = {
			"Disables the current",
			"{C:attention}Boss Blind{}",
			"for {C:attention}#1#{} hand"  
		}
	},
	config = { extra = {hands = 1, used = false} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands } }
	end,
	rarity = 1,
	cost = 5,
	atlas = 'beelatro',                                       
	soul_pos = nil,
	pos = { x = 6, y = 0 },
	blueprint_compat = true,                           
	eternal_compat = true,                              
	unlocked = true,                                  
	discovered = true,
	calculate = function(self, card, context)                 --define calculate functions here
		if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) and not context.blueprint then
				card.ability.extra.used = true
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
				G.GAME.blind:disable()
				local eval = function() return G.GAME.blind and G.GAME.blind:get_type() == 'Boss' and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
		end
		if context.after and G.GAME.blind and card.ability.extra.used and not context.blueprint then
			sendDebugMessage(inspect(context))
			if card.ability.extra.hands - 1 <= 0 then 
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('timpani')
							card.T.r = -0.2
							card:juice_up(0.3, 0.4)
							card.states.drag.is = true
							card.children.center.pinch.x = true
							card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Splat!", colour = G.C.RED})
							G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
								func = function()
										--G.GAME.blind:enable()
										G.jokers:remove_card(card)
										card:remove()
										card = nil
									return true; end})) 
							return true
						end
					})) 
				else
					card.ability.extra.hands = card.ability.extra.hands - 1
					return {
						message = card.ability.extra.hands..'',
						colour = G.C.RED
					}
			end
		end
		if context.end_of_round and card.ability.extra.used then
			card.ability.extra.used = false
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if G.GAME.blind and ((G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) and card.ability.extra.used then
			G.GAME.blind:enable()
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then
				card.ability.extra.used = true
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
				G.GAME.blind:disable()
				local eval = function() return G.GAME.blind and G.GAME.blind:get_type() == 'Boss' and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
		end
	end
}
--bogdonoff
SMODS.Joker {
	key = 'bogdonoff',
	loc_txt = {
		name = 'Bogdonoff',
		text = {
			"Everything costs {C:money}$0{}!"
		}
	},
	config = { extra = { prev_discount = 0, discount = 100 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.discount } }
	end,
	rarity = 4,
	cost = 10,
	atlas = 'beelatro',                                       
	soul_pos = { x = 2, y = 0 },
	pos = { x = 1, y = 0 },
	blueprint_compat = true,                           
	eternal_compat = true,                              
	unlocked = true,                                  
	discovered = true,
	calculate = function(self, card, context)                 --define calculate functions here
	end,
	add_to_deck = function(self, card, from_debuff)
		-- card.ability.extra.prev_discount = G.GAME.discount_percent
		-- G.GAME.discount_percent = card.ability.extra.discount
		for k, v in pairs(G.I.CARD) do
			if v.set_cost then v:set_cost(true) end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		-- if G.GAME.used_vouchers.v_liquidation then
			-- G.GAME.discount_percent = 50
		-- elseif G.GAME.used_vouchers.v_clearance_sale then
			-- G.GAME.discount_percent = 25
		-- else 
			-- G.GAME.discount_percent = 0
		-- end
		for k, v in pairs(G.I.CARD) do
			if v.set_cost then v:set_cost() end
		end
	end
}
--bigjoker
SMODS.Atlas {
  key = "bigjoker",
  path = "j_bigjoker.png",
  px = 142,
  py = 190
}

SMODS.Joker {
	key = 'bigjoker',
	loc_txt = {
		name = 'Big Joker',
		text = {
			"{X:mult,C:white} X#1# {} Mult",
			"-2 Joker Slots"
		}
	},
	config = { extra = { Xmult = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,
	rarity = 3,
	cost = 8,
	atlas = 'bigjoker',                                       
	soul_pos = nil,
	pos = { x = 0, y = 0 },
	blueprint_compat = true,                           
	eternal_compat = true,                              
	unlocked = true,                                  
	discovered = true,
	calculate = function(self, card, context)
		if context.joker_main then
		  return {
			message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
			Xmult_mod = card.ability.extra.Xmult
		  }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit - 2
        end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit + 2
        end
	end
}

--gayjoker
SMODS.Atlas {
  key = "gayjoker",
  path = "j_gayjoker.png",
  px = 71,
  py = 95
}

SMODS.Joker {
	key = 'gayjoker',
	loc_txt = {
		name = 'Gay Joker',
		text = {
			"If poker hand is a {C:attention}Straight{}",
			"or {C:attention}Straight Flush{}, destroy it"
		}
	},
	config = { extra = { trash_list = {}, straight = false } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.straight } }
	end,
	rarity = 3,
	cost = 8,
	atlas = 'gayjoker',                                       
	soul_pos = nil,
	pos = { x = 0, y = 0 },
	blueprint_compat = false,                           
	eternal_compat = true,                              
	unlocked = true,                                  
	discovered = true,
	calculate = function(self, card, context)
        if (context.scoring_name=="Straight" or context.scoring_name=="Straight Flush") then
			card.ability.extra.trash_list = context.scoring_hand
			card.ability.extra.straight = true
		elseif context.scoring_name then
			card.ability.extra.straight = false
		end
		if context.destroying_card and card.ability.extra.straight then
			-- for i=1, 50 do 
				-- context.destroying_card:start_dissolve({G.C.RED, G.C.GREEN, G.C. YELLOW, G.C.BLUE, G.C.PURPLE})
			-- end
			return true
		end
		if context.after then
			card.ability.extra.straight = true
		end
    end
}

--dirtyjoker
SMODS.Atlas {
  key = "dirtyjoker",
  path = "j_dirtyjoker.png",
  px = 71,
  py = 95
}

SMODS.Joker {
	key = 'dirtyjoker',
	loc_txt = {
		name = 'Dirty Joker',
		text = {
			"Retrigger the first",
			"played {C:attention}6{} and {C:attention}9{}"
		}
	},
	config = { extra = { six = false, nine = false, reps = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.six } }
	end,
	rarity = 1,
	cost = 5,
	atlas = 'dirtyjoker',                                       
	soul_pos = nil,
	pos = { x = 0, y = 0 },
	blueprint_compat = false,                           
	eternal_compat = true,                              
	unlocked = true,                                  
	discovered = true,
	calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and not context.repetition_only then
			if context.other_card:get_id() == 6 and not card.ability.extra.six then
				card.ability.extra.six = true
				return {
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra.reps,
                        card = context.other_card
                    }
			end
			if context.other_card:get_id() == 9 and not card.ability.nine then
				card.ability.extra.nine = true
				return {
						message = localize('k_again_ex'),
						repetitions = card.ability.extra.reps,
						card = context.other_card
					}
			end
		end
		if not context.repetition then
			card.ability.extra.six = false
			card.ability.extra.nine = false
		end
    end
}


-- local get_poker_hand_info = G.FUNCS.get_poker_hand_info
-- G.FUNCS.get_poker_hand_info = function(_cards)
	-- if next(SMODS.find_card("j_bees_highjoker")) then
			-- local poker_hands = evaluate_poker_hand(_cards)
			-- local scoring_hand = {}
			-- local high = next(SMODS.find_card("j_bees_highjoker"))
			-- local text,disp_text,loc_disp_text = 'NULL','NULL', 'NULL'
			-- if next(poker_hands["High Card"]) then text = "High Card"; scoring_hand = poker_hands["High Card"][1]
				-- disp_text = text
				-- loc_disp_text = localize(disp_text, 'poker_hands')
				-- return text, loc_disp_text, poker_hands, scoring_hand, disp_text
			-- end
	-- else 
		-- get_poker_hand_info(_cards, self)
	-- end
-- end
G.FUNCS.get_poker_hand_info = function(_cards)
    local poker_hands = evaluate_poker_hand(_cards)
    local scoring_hand = {}
	local high = next(SMODS.find_card("j_bees_highjoker"))
    local text,disp_text,loc_disp_text = 'NULL','NULL', 'NULL'
	if next(poker_hands["High Card"]) and high then text = "High Card"; scoring_hand = poker_hands["High Card"][1]
    elseif next(poker_hands["Flush Five"]) then text = "Flush Five"; scoring_hand = poker_hands["Flush Five"][1]
    elseif next(poker_hands["Flush House"]) then text = "Flush House"; scoring_hand = poker_hands["Flush House"][1]
    elseif next(poker_hands["Five of a Kind"]) then text = "Five of a Kind"; scoring_hand = poker_hands["Five of a Kind"][1]
    elseif next(poker_hands["Straight Flush"]) then text = "Straight Flush"; scoring_hand = poker_hands["Straight Flush"][1]
    elseif next(poker_hands["Four of a Kind"]) then text = "Four of a Kind"; scoring_hand = poker_hands["Four of a Kind"][1]
    elseif next(poker_hands["Full House"]) then text = "Full House"; scoring_hand = poker_hands["Full House"][1]
    elseif next(poker_hands["Flush"]) then text = "Flush"; scoring_hand = poker_hands["Flush"][1]
    elseif next(poker_hands["Straight"]) then text = "Straight"; scoring_hand = poker_hands["Straight"][1]
    elseif next(poker_hands["Three of a Kind"]) then text = "Three of a Kind"; scoring_hand = poker_hands["Three of a Kind"][1]
    elseif next(poker_hands["Two Pair"]) then text = "Two Pair"; scoring_hand = poker_hands["Two Pair"][1]
    elseif next(poker_hands["Pair"]) then text = "Pair"; scoring_hand = poker_hands["Pair"][1]
    elseif next(poker_hands["High Card"]) then text = "High Card"; scoring_hand = poker_hands["High Card"][1] end

    disp_text = text
    if text =='Straight Flush' then
        local min = 10
        for j = 1, #scoring_hand do
            if scoring_hand[j]:get_id() < min then min =scoring_hand[j]:get_id() end
        end
        if min >= 10 then 
            disp_text = 'Royal Flush'
        end
    end
    loc_disp_text = localize(disp_text, 'poker_hands')
    return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

--thanks balt!
-- local card_draw = Card.draw
-- function Card:draw()
  -- if --[[ some condition ]] then
    -- -- stuff goes here
  -- else 
    -- card_draw(self)
  -- end
-- end

local card_set_cost = Card.set_cost
function Card:set_cost(bogdonoff)
    bogdonoff = bogdonoff or next(SMODS.find_card('j_bees_bogdonoff'))
	if bogdonoff then
		self.cost = 0
		self.sell_cost = 0 + (self.ability.extra_value or 0)
		return
	else 
		card_set_cost(self)
	end
end

-- function Card:set_cost(bogdonoff)
	
	-- bogdonoff = bogdonoff or next(SMODS.find_card('j_bees_bogdonoff'))
	-- if bogdonoff then
		-- self.cost = 0
		-- self.sell_cost = 0 + (self.ability.extra_value or 0)
		-- return
	-- end
    -- self.extra_cost = 0 + G.GAME.inflation
    -- if self.edition then
        -- self.extra_cost = self.extra_cost + (self.edition.holo and 3 or 0) + (self.edition.foil and 2 or 0) + 
        -- (self.edition.polychrome and 5 or 0) + (self.edition.negative and 5 or 0)
    -- end
    -- self.cost = math.max(1, math.floor((self.base_cost + self.extra_cost + 0.5)*(100-G.GAME.discount_percent)/100))
    -- if self.ability.set == 'Booster' and G.GAME.modifiers.booster_ante_scaling then self.cost = self.cost + G.GAME.round_resets.ante - 1 end
    -- if self.ability.set == 'Booster' and (not G.SETTINGS.tutorial_complete) and G.SETTINGS.tutorial_progress and (not G.SETTINGS.tutorial_progress.completed_parts['shop_1']) then
        -- self.cost = self.cost + 3
    -- end
    -- if (self.ability.set == 'Planet' or (self.ability.set == 'Booster' and self.ability.name:find('Celestial'))) and #find_joker('Astronomer') > 0 then self.cost = 0 end
    -- if self.ability.rental then self.cost = 1 end
    -- self.sell_cost = math.max(1, math.floor(self.cost/2)) + (self.ability.extra_value or 0)
    -- if self.area and self.ability.couponed and (self.area == G.shop_jokers or self.area == G.shop_booster) then self.cost = 0 end
    -- self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
-- end

function Blind:enable()
    self.disabled = false
	--water
    if self.name == 'The Water' then 
        ease_discard(-G.GAME.current_round.discards_left, nil, true)
    end
	--needle
    if self.name == 'The Needle' then 
        ease_hands_played(-(G.GAME.current_round.hands_left-1))
    end
	--wall
    if self.name == 'The Wall' then 
        self.chips = self.chips*2
        self.chip_text = number_format(self.chips)
    end
    if self.name == 'Cerulean Bell' then 
        for k, v in ipairs(G.playing_cards) do
            v.ability.forced_selection = nil
        end
    end
	--manacle
    if self.name == 'The Manacle' then 
        G.hand:change_size(-1)
    end
    if self.name == 'The Serpent' then
    end
	--vessel
    if self.name == 'Violet Vessel' then 
        self.chips = self.chips*3
        self.chip_text = number_format(self.chips)
    end
	--heart
	if self.name == 'Crimson Heart' and #G.jokers.cards > 0 then
		local jokers = {}
		self.prepped = true
		for i = 1, #G.jokers.cards do
			if not G.jokers.cards[i].debuff or #G.jokers.cards < 2 then jokers[#jokers+1] =G.jokers.cards[i] end
			G.jokers.cards[i]:set_debuff(false)
		end 
		local _card = pseudorandom_element(jokers, pseudoseed('crimson_heart'))
		if _card then
			_card:set_debuff(true)
			_card:juice_up()
			self:wiggle()
		end
	end
	--acorn
	if self.name == 'Amber Acorn' and #G.jokers.cards > 0 then
        G.jokers:unhighlight_all()
        for k, v in ipairs(G.jokers.cards) do
            v:flip()
        end
        if #G.jokers.cards > 1 then 
            G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.2, func = function() 
                G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 0.85);return true end })) 
                delay(0.15)
                G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1.15);return true end })) 
                delay(0.15)
                G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1);return true end })) 
                delay(0.5)
            return true end })) 
        end
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
        if self.boss and G.GAME.chips - G.GAME.blind.chips >= 0 then
            G.STATE = G.STATES.NEW_ROUND
            G.STATE_COMPLETE = false
        end
        return true
    end
    }))
    for _, v in ipairs(G.playing_cards) do
        self:debuff_card(v)
    end
    for _, v in ipairs(G.jokers.cards) do
        self:debuff_card(v)
    end
    self:set_text()
    self:wiggle()
end

----------------------------------------------
------------MOD CODE END----------------------
