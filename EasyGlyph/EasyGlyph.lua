local ADDON_ICON_PATH = "Interface\\AddOns\\EasyGlyph\\Media\\Icons\\"
local ADDON_ROUNDED_PATH = "Interface\\AddOns\\EasyGlyph\\Media\\Rounded\\"
local ADDON_MAJOR_RING_PATH = "Interface\\AddOns\\EasyGlyph\\Media\\MajorGlyphRing"

local SOCKET_ICON_MAJOR_SCALE = 1.60
local SOCKET_ICON_MINOR_SCALE = 1.16
local SOCKET_ICON_DEFAULT_SCALE = 1.20
local SOCKET_MAJOR_RING_SCALE = 1.90

local SOCKET_OFFSET_X = 0
local SOCKET_OFFSET_Y = 0
local SOCKET_OVERLAY_DRAW_LAYER = "ARTWORK"
local SOCKET_RING_DRAW_LAYER = "OVERLAY"
local SOCKET_OVERLAY_SUBLEVEL = 3
local SOCKET_RING_SUBLEVEL = 12
local SOCKET_OVERLAY_FRAMELEVEL_BONUS = 20
local SOCKET_RING_FRAMELEVEL_BONUS = 40

-- keep these local, HD icon packs can replace Interface\Icons
local glyphIconMap = {
    -- death knight
    ["Glyph of Anti-Magic Shell"] = "spell_shadow_antimagicshell",
    ["Glyph of Blood Strike"] = "spell_deathknight_deathstrike",
    ["Glyph of Blood Tap"] = "spell_deathknight_bloodtap",
    ["Glyph of Bone Shield"] = "inv_chest_leather_13",
    ["Glyph of Chains of Ice"] = "spell_frost_chainsofice",
    ["Glyph of Corpse Explosion"] = "ability_creature_disease_02",
    ["Glyph of Dancing Rune Weapon"] = "inv_sword_07",
    ["Glyph of Dark Command"] = "spell_nature_shamanrage",
    ["Glyph of Dark Death"] = "spell_shadow_deathcoil",
    ["Glyph of Death Grip"] = "spell_deathknight_strangulate",
    ["Glyph of Death Strike"] = "spell_deathknight_butcher2",
    ["Glyph of Death and Decay"] = "spell_shadow_deathanddecay",
    ["Glyph of Death's Embrace"] = "spell_shadow_deathcoil",
    ["Glyph of Disease"] = "spell_shadow_plaguecloud",
    ["Glyph of Frost Strike"] = "spell_deathknight_empowerruneblade2",
    ["Glyph of Heart Strike"] = "inv_weapon_shortblade_40",
    ["Glyph of Horn of Winter"] = "inv_misc_horn_02",
    ["Glyph of Howling Blast"] = "spell_frost_arcticwinds",
    ["Glyph of Hungering Cold"] = "inv_staff_15",
    ["Glyph of Icebound Fortitude"] = "spell_deathknight_iceboundfortitude",
    ["Glyph of Icy Touch"] = "spell_deathknight_icetouch",
    ["Glyph of Obliterate"] = "spell_deathknight_classicon",
    ["Glyph of Pestilence"] = "spell_shadow_plaguecloud",
    ["Glyph of Plague Strike"] = "spell_deathknight_plaguestrike",
    ["Glyph of Raise Dead"] = "spell_shadow_animatedead",
    ["Glyph of Rune Strike"] = "spell_deathknight_darkconviction",
    ["Glyph of Rune Tap"] = "spell_deathknight_runetap",
    ["Glyph of Scourge Strike"] = "spell_deathknight_scourgestrike",
    ["Glyph of Strangulate"] = "spell_deathknight_strangulate",
    ["Glyph of Unbreakable Armor"] = "inv_armor_helm_plate_naxxramas_raidwarrior_c_01",
    ["Glyph of Unholy Blight"] = "spell_shadow_contagion",
    ["Glyph of Vampiric Blood"] = "spell_shadow_lifedrain",
    ["Glyph of the Ghoul"] = "spell_shadow_animatedead",

    -- druid
    ["Glyph of Aquatic Form"] = "ability_druid_aquaticform",
    ["Glyph of Barkskin"] = "spell_nature_stoneclawtotem",
    ["Glyph of Berserk"] = "ability_druid_berserk",
    ["Glyph of Challenging Roar"] = "ability_druid_challangingroar",
    ["Glyph of Claw"] = "ability_druid_rake",
    ["Glyph of Dash"] = "ability_druid_dash",
    ["Glyph of Entangling Roots"] = "spell_nature_stranglevines",
    ["Glyph of Focus"] = "ability_druid_starfall",
    ["Glyph of Frenzied Regeneration"] = "ability_bullrush",
    ["Glyph of Growl"] = "ability_physical_taunt",
    ["Glyph of Healing Touch"] = "spell_nature_healingtouch",
    ["Glyph of Hurricane"] = "spell_nature_cyclone",
    ["Glyph of Innervate"] = "spell_nature_lightning",
    ["Glyph of Insect Swarm"] = "spell_nature_insectswarm",
    ["Glyph of Lifebloom"] = "inv_misc_herb_felblossom",
    ["Glyph of Mangle"] = "ability_druid_mangle2",
    ["Glyph of Maul"] = "ability_druid_maul",
    ["Glyph of Monsoon"] = "ability_druid_typhoon",
    ["Glyph of Moonfire"] = "spell_nature_starfall",
    ["Glyph of Nourish"] = "ability_druid_nourish",
    ["Glyph of Rake"] = "ability_druid_disembowel",
    ["Glyph of Rapid Rejuvenation"] = "spell_nature_rejuvenation",
    ["Glyph of Rebirth"] = "spell_nature_reincarnation",
    ["Glyph of Regrowth"] = "spell_nature_resistnature",
    ["Glyph of Rejuvenation"] = "spell_nature_rejuvenation",
    ["Glyph of Rip"] = "ability_ghoulfrenzy",
    ["Glyph of Savage Roar"] = "ability_druid_skinteeth",
    ["Glyph of Shred"] = "spell_shadow_vampiricaura",
    ["Glyph of Starfall"] = "ability_druid_starfall",
    ["Glyph of Starfire"] = "spell_arcane_starfire",
    ["Glyph of Survival Instincts"] = "ability_druid_tigersroar",
    ["Glyph of Swiftmend"] = "inv_relics_idolofrejuvenation",
    ["Glyph of Thorns"] = "spell_nature_thorns",
    ["Glyph of Typhoon"] = "ability_druid_typhoon",
    ["Glyph of Unburdened Rebirth"] = "spell_nature_reincarnation",
    ["Glyph of Wild Growth"] = "ability_druid_flourish",
    ["Glyph of Wrath"] = "spell_nature_abolishmagic",
    ["Glyph of the Wild"] = "spell_nature_regeneration",

    -- hunter
    ["Glyph of Aimed Shot"] = "inv_spear_07",
    ["Glyph of Arcane Shot"] = "ability_impalingbolt",
    ["Glyph of Aspect of the Viper"] = "ability_hunter_aspectoftheviper",
    ["Glyph of Bestial Wrath"] = "ability_druid_ferociousbite",
    ["Glyph of Chimera Shot"] = "ability_hunter_chimerashot2",
    ["Glyph of Deterrence"] = "ability_whirlwind",
    ["Glyph of Disengage"] = "ability_rogue_feint",
    ["Glyph of Explosive Shot"] = "ability_hunter_explosiveshot",
    ["Glyph of Explosive Trap"] = "spell_fire_selfdestruct",
    ["Glyph of Feign Death"] = "ability_rogue_feigndeath",
    ["Glyph of Freezing Trap"] = "spell_frost_chainsofice",
    ["Glyph of Frost Trap"] = "spell_frost_freezingbreath",
    ["Glyph of Hunter's Mark"] = "ability_hunter_snipershot",
    ["Glyph of Immolation Trap"] = "spell_fire_flameshock",
    ["Glyph of Kill Shot"] = "ability_hunter_assassinate2",
    ["Glyph of Mend Pet"] = "ability_hunter_mendpet",
    ["Glyph of Mending"] = "ability_hunter_mendpet",
    ["Glyph of Multi-Shot"] = "ability_upgrademoonglaive",
    ["Glyph of Possessed Strength"] = "ability_eyeoftheowl",
    ["Glyph of Rapid Fire"] = "ability_hunter_runningshot",
    ["Glyph of Raptor Strike"] = "ability_meleedamage",
    ["Glyph of Revive Pet"] = "ability_hunter_beastsoothe",
    ["Glyph of Scare Beast"] = "ability_druid_cower",
    ["Glyph of Scatter Shot"] = "ability_golemstormbolt",
    ["Glyph of Serpent Sting"] = "ability_hunter_quickshot",
    ["Glyph of Snake Trap"] = "ability_hunter_snaketrap",
    ["Glyph of Steady Shot"] = "ability_hunter_steadyshot",
    ["Glyph of Trueshot Aura"] = "ability_trueshot",
    ["Glyph of Volley"] = "ability_marksmanship",
    ["Glyph of Wyvern Sting"] = "inv_spear_02",
    ["Glyph of the Beast"] = "ability_mount_pinktiger",
    ["Glyph of the Hawk"] = "spell_nature_ravenform",
    ["Glyph of the Pack"] = "ability_mount_whitetiger",

    -- mage
    ["Glyph of Arcane Barrage"] = "ability_mage_arcanebarrage",
    ["Glyph of Arcane Blast"] = "spell_arcane_blast",
    ["Glyph of Arcane Explosion"] = "spell_nature_wispsplode",
    ["Glyph of Arcane Intellect"] = "spell_holy_magicalsentry",
    ["Glyph of Arcane Missiles"] = "spell_nature_starfall",
    ["Glyph of Arcane Power"] = "spell_nature_lightning",
    ["Glyph of Blast Wave"] = "spell_holy_excorcism_02",
    ["Glyph of Blink"] = "spell_arcane_blink",
    ["Glyph of Deep Freeze"] = "ability_mage_deepfreeze",
    ["Glyph of Eternal Water"] = "spell_frost_summonwaterelemental_2",
    ["Glyph of Evocation"] = "spell_nature_purge",
    ["Glyph of Fire Blast"] = "spell_fire_fireball",
    ["Glyph of Fire Ward"] = "spell_fire_firearmor",
    ["Glyph of Fireball"] = "spell_fire_flamebolt",
    ["Glyph of Frost Armor"] = "spell_frost_frostarmor02",
    ["Glyph of Frost Nova"] = "spell_frost_frostnova",
    ["Glyph of Frost Ward"] = "spell_frost_frostward",
    ["Glyph of Frostbolt"] = "spell_frost_frostbolt02",
    ["Glyph of Frostfire"] = "ability_mage_frostfirebolt",
    ["Glyph of Ice Armor"] = "spell_frost_frostarmor02",
    ["Glyph of Ice Barrier"] = "spell_ice_lament",
    ["Glyph of Ice Block"] = "spell_frost_frost",
    ["Glyph of Ice Lance"] = "spell_frost_frostblast",
    ["Glyph of Icy Veins"] = "spell_frost_coldhearted",
    ["Glyph of Invisibility"] = "ability_mage_invisibility",
    ["Glyph of Living Bomb"] = "ability_mage_livingbomb",
    ["Glyph of Mage Armor"] = "spell_magearmor",
    ["Glyph of Mana Gem"] = "inv_misc_gem_sapphire_01",
    ["Glyph of Mirror Image"] = "spell_magic_lesserinvisibilty",
    ["Glyph of Molten Armor"] = "ability_mage_moltenarmor",
    ["Glyph of Polymorph"] = "spell_nature_polymorph",
    ["Glyph of Remove Curse"] = "spell_nature_removecurse",
    ["Glyph of Scorch"] = "spell_fire_soulburn",
    ["Glyph of Slow Fall"] = "spell_magic_featherfall",
    ["Glyph of Water Elemental"] = "spell_frost_summonwaterelemental_2",
    ["Glyph of the Penguin"] = "spell_nature_polymorph",

    -- paladin
    ["Glyph of Avenger's Shield"] = "spell_holy_avengersshield",
    ["Glyph of Avenging Wrath"] = "spell_holy_avenginewrath",
    ["Glyph of Beacon of Light"] = "ability_paladin_beaconoflight",
    ["Glyph of Blessing of Kings"] = "spell_magic_magearmor",
    ["Glyph of Blessing of Might"] = "spell_holy_fistofjustice",
    ["Glyph of Blessing of Wisdom"] = "spell_holy_sealofwisdom",
    ["Glyph of Cleansing"] = "spell_holy_purify",
    ["Glyph of Consecration"] = "spell_holy_innerfire",
    ["Glyph of Crusader Strike"] = "spell_holy_crusaderstrike",
    ["Glyph of Divine Plea"] = "spell_holy_aspiration",
    ["Glyph of Divine Storm"] = "ability_paladin_divinestorm",
    ["Glyph of Divinity"] = "spell_holy_layonhands",
    ["Glyph of Exorcism"] = "spell_holy_excorcism_02",
    ["Glyph of Flash of Light"] = "spell_holy_flashheal",
    ["Glyph of Hammer of Justice"] = "spell_holy_sealofmight",
    ["Glyph of Hammer of Wrath"] = "ability_thunderclap",
    ["Glyph of Hammer of the Righteous"] = "ability_paladin_hammeroftherighteous",
    ["Glyph of Holy Light"] = "spell_holy_holybolt",
    ["Glyph of Holy Shock"] = "spell_holy_searinglight",
    ["Glyph of Holy Wrath"] = "spell_holy_excorcism",
    ["Glyph of Judgement"] = "ability_paladin_judgementred",
    ["Glyph of Lay on Hands"] = "spell_holy_layonhands",
    ["Glyph of Righteous Defense"] = "inv_shoulder_37",
    ["Glyph of Salvation"] = "spell_holy_sealofsalvation",
    ["Glyph of Seal of Command"] = "ability_warrior_innerrage",
    ["Glyph of Seal of Light"] = "spell_holy_healingaura",
    ["Glyph of Seal of Righteousness"] = "ability_thunderbolt",
    ["Glyph of Seal of Vengeance"] = "spell_holy_sealofvengeance",
    ["Glyph of Seal of Wisdom"] = "spell_holy_righteousnessaura",
    ["Glyph of Sense Undead"] = "spell_holy_senseundead",
    ["Glyph of Shield of Righteousness"] = "ability_paladin_shieldofvengeance",
    ["Glyph of Spiritual Attunement"] = "spell_holy_revivechampion",
    ["Glyph of Turn Evil"] = "spell_holy_turnundead",
    ["Glyph of the Wise"] = "spell_holy_righteousnessaura",

    -- priest
    ["Glyph of Circle of Healing"] = "spell_holy_circleofrenewal",
    ["Glyph of Dispel Magic"] = "spell_holy_dispelmagic",
    ["Glyph of Dispersion"] = "spell_shadow_dispersion",
    ["Glyph of Fade"] = "spell_magic_lesserinvisibilty",
    ["Glyph of Fading"] = "spell_magic_lesserinvisibilty",
    ["Glyph of Fear Ward"] = "spell_holy_excorcism",
    ["Glyph of Flash Heal"] = "spell_holy_flashheal",
    ["Glyph of Fortitude"] = "spell_holy_wordfortitude",
    ["Glyph of Guardian Spirit"] = "spell_holy_guardianspirit",
    ["Glyph of Holy Nova"] = "spell_holy_holynova",
    ["Glyph of Hymn of Hope"] = "spell_holy_symbolofhope",
    ["Glyph of Inner Fire"] = "spell_holy_innerfire",
    ["Glyph of Levitate"] = "spell_holy_layonhands",
    ["Glyph of Lightwell"] = "spell_holy_summonlightwell",
    ["Glyph of Mass Dispel"] = "spell_arcane_massdispel",
    ["Glyph of Mind Control"] = "spell_shadow_shadowworddominate",
    ["Glyph of Mind Flay"] = "spell_shadow_siphonmana",
    ["Glyph of Mind Sear"] = "spell_shadow_mindshear",
    ["Glyph of Pain Suppression"] = "spell_holy_painsupression",
    ["Glyph of Penance"] = "spell_holy_penance",
    ["Glyph of Power Word: Shield"] = "spell_holy_powerwordshield",
    ["Glyph of Prayer of Healing"] = "spell_holy_prayerofhealing02",
    ["Glyph of Psychic Scream"] = "spell_shadow_psychicscream",
    ["Glyph of Renew"] = "spell_holy_renew",
    ["Glyph of Scourge Imprisonment"] = "spell_nature_slow",
    ["Glyph of Shackle Undead"] = "spell_nature_slow",
    ["Glyph of Shadow"] = "spell_shadow_shadowform",
    ["Glyph of Shadow Protection"] = "spell_shadow_antishadow",
    ["Glyph of Shadow Word: Death"] = "spell_shadow_demonicfortitude",
    ["Glyph of Shadow Word: Pain"] = "spell_shadow_shadowwordpain",
    ["Glyph of Shadowfiend"] = "spell_shadow_shadowfiend",
    ["Glyph of Smite"] = "spell_holy_holysmite",
    ["Glyph of Spirit of Redemption"] = "inv_enchant_essenceeternallarge",

    -- rogue
    ["Glyph of Adrenaline Rush"] = "spell_shadow_shadowworddominate",
    ["Glyph of Ambush"] = "ability_rogue_ambush",
    ["Glyph of Backstab"] = "ability_backstab",
    ["Glyph of Blade Flurry"] = "ability_warrior_punishingblow",
    ["Glyph of Blurred Speed"] = "ability_rogue_sprint",
    ["Glyph of Cloak of Shadows"] = "spell_shadow_nethercloak",
    ["Glyph of Crippling Poison"] = "ability_poisonsting",
    ["Glyph of Deadly Throw"] = "inv_throwingknife_06",
    ["Glyph of Distract"] = "ability_rogue_distract",
    ["Glyph of Evasion"] = "spell_shadow_shadowward",
    ["Glyph of Eviscerate"] = "ability_rogue_eviscerate",
    ["Glyph of Expose Armor"] = "ability_warrior_riposte",
    ["Glyph of Fan of Knives"] = "ability_rogue_fanofknives",
    ["Glyph of Feint"] = "ability_rogue_feint",
    ["Glyph of Garrote"] = "ability_rogue_garrote",
    ["Glyph of Ghostly Strike"] = "spell_shadow_curse",
    ["Glyph of Gouge"] = "ability_gouge",
    ["Glyph of Hemorrhage"] = "spell_shadow_lifedrain",
    ["Glyph of Hunger for Blood"] = "ability_rogue_hungerforblood",
    ["Glyph of Killing Spree"] = "ability_rogue_murderspree",
    ["Glyph of Mutilate"] = "ability_rogue_shadowstrikes",
    ["Glyph of Pick Lock"] = "spell_nature_moonkey",
    ["Glyph of Pick Pocket"] = "inv_misc_bag_11",
    ["Glyph of Preparation"] = "spell_shadow_antishadow",
    ["Glyph of Rupture"] = "ability_rogue_rupture",
    ["Glyph of Safe Fall"] = "inv_feather_01",
    ["Glyph of Sap"] = "ability_sap",
    ["Glyph of Shadow Dance"] = "ability_rogue_shadowdance",
    ["Glyph of Sinister Strike"] = "spell_shadow_ritualofsacrifice",
    ["Glyph of Slice and Dice"] = "ability_rogue_slicedice",
    ["Glyph of Sprint"] = "ability_rogue_sprint",
    ["Glyph of Tricks of the Trade"] = "ability_rogue_tricksofthetrade",
    ["Glyph of Vanish"] = "ability_vanish",
    ["Glyph of Vigor"] = "spell_nature_earthbindtotem",

    -- shaman
    ["Glyph of Astral Recall"] = "spell_nature_astralrecal",
    ["Glyph of Chain Heal"] = "spell_nature_healingwavegreater",
    ["Glyph of Chain Lightning"] = "spell_nature_chainlightning",
    ["Glyph of Earth Shield"] = "spell_nature_skinofearth",
    ["Glyph of Earthliving Weapon"] = "spell_shaman_earthlivingweapon",
    ["Glyph of Elemental Mastery"] = "spell_nature_wispheal",
    ["Glyph of Feral Spirit"] = "spell_shaman_feralspirit",
    ["Glyph of Fire Elemental Totem"] = "spell_fire_elemental_totem",
    ["Glyph of Fire Nova"] = "spell_fire_sealoffire",
    ["Glyph of Flame Shock"] = "spell_fire_flameshock",
    ["Glyph of Flametongue Weapon"] = "spell_fire_flametounge",
    ["Glyph of Frost Shock"] = "spell_frost_frostshock",
    ["Glyph of Ghost Wolf"] = "spell_nature_spiritwolf",
    ["Glyph of Healing Stream Totem"] = "inv_spear_04",
    ["Glyph of Healing Wave"] = "spell_nature_magicimmunity",
    ["Glyph of Hex"] = "spell_shaman_hex",
    ["Glyph of Lava"] = "spell_shaman_lavaburst",
    ["Glyph of Lava Lash"] = "ability_shaman_lavalash",
    ["Glyph of Lesser Healing Wave"] = "spell_nature_healingwavelesser",
    ["Glyph of Lightning Bolt"] = "spell_nature_lightning",
    ["Glyph of Lightning Shield"] = "spell_nature_lightningshield",
    ["Glyph of Mana Tide Totem"] = "spell_frost_summonwaterelemental",
    ["Glyph of Renewed Life"] = "spell_nature_reincarnation",
    ["Glyph of Riptide"] = "spell_nature_riptide",
    ["Glyph of Shocking"] = "spell_nature_earthshock",
    ["Glyph of Stoneclaw Totem"] = "spell_nature_stoneclawtotem",
    ["Glyph of Stormstrike"] = "ability_shaman_stormstrike",
    ["Glyph of Thunder"] = "spell_shaman_thunderstorm",
    ["Glyph of Thunderstorm"] = "spell_shaman_thunderstorm",
    ["Glyph of Totem of Wrath"] = "spell_fire_totemofwrath",
    ["Glyph of Water Breathing"] = "spell_shadow_demonbreath",
    ["Glyph of Water Mastery"] = "ability_shaman_watershield",
    ["Glyph of Water Shield"] = "ability_shaman_watershield",
    ["Glyph of Water Walking"] = "spell_frost_windwalkon",
    ["Glyph of Windfury Weapon"] = "spell_nature_cyclone",

    -- warlock
    ["Glyph of Chaos Bolt"] = "ability_warlock_chaosbolt",
    ["Glyph of Conflagrate"] = "spell_fire_fireball",
    ["Glyph of Corruption"] = "spell_shadow_abominationexplosion",
    ["Glyph of Curse of Agony"] = "spell_shadow_curseofsargeras",
    ["Glyph of Curse of Exhaustion"] = "spell_shadow_grimward",
    ["Glyph of Death Coil"] = "spell_shadow_deathcoil",
    ["Glyph of Demonic Circle"] = "spell_shadow_demoniccirclesummon",
    ["Glyph of Drain Soul"] = "spell_shadow_haunting",
    ["Glyph of Enslave Demon"] = "spell_shadow_enslavedemon",
    ["Glyph of Fear"] = "spell_shadow_possession",
    ["Glyph of Felguard"] = "spell_shadow_summonfelguard",
    ["Glyph of Felhunter"] = "spell_shadow_summonfelhunter",
    ["Glyph of Haunt"] = "ability_warlock_haunt",
    ["Glyph of Health Funnel"] = "spell_shadow_lifedrain",
    ["Glyph of Healthstone"] = "inv_stone_04",
    ["Glyph of Howl of Terror"] = "spell_shadow_deathscream",
    ["Glyph of Immolate"] = "spell_fire_immolation",
    ["Glyph of Imp"] = "spell_shadow_summonimp",
    ["Glyph of Incinerate"] = "spell_fire_burnout",
    ["Glyph of Kilrogg"] = "spell_shadow_evileye",
    ["Glyph of Life Tap"] = "spell_shadow_burningspirit",
    ["Glyph of Metamorphosis"] = "spell_shadow_demonform",
    ["Glyph of Quick Decay"] = "spell_shadow_abominationexplosion",
    ["Glyph of Searing Pain"] = "spell_fire_soulburn",
    ["Glyph of Shadow Bolt"] = "spell_shadow_shadowbolt",
    ["Glyph of Shadowburn"] = "spell_shadow_scourgebuild",
    ["Glyph of Shadowflame"] = "ability_warlock_shadowflame",
    ["Glyph of Siphon Life"] = "spell_shadow_requiem",
    ["Glyph of Soul Link"] = "spell_shadow_gathershadows",
    ["Glyph of Souls"] = "spell_shadow_shadesofdarkness",
    ["Glyph of Soulstone"] = "spell_shadow_soulgem",
    ["Glyph of Succubus"] = "spell_shadow_mindsteal",
    ["Glyph of Unending Breath"] = "spell_shadow_demonbreath",
    ["Glyph of Unstable Affliction"] = "spell_shadow_unstableaffliction_3",
    ["Glyph of Voidwalker"] = "spell_shadow_summonvoidwalker",

    -- warrior
    ["Glyph of Barbaric Insults"] = "ability_warrior_punishingblow",
    ["Glyph of Battle"] = "ability_warrior_battleshout",
    ["Glyph of Bladestorm"] = "ability_warrior_bladestorm",
    ["Glyph of Blocking"] = "inv_shield_05",
    ["Glyph of Bloodrage"] = "ability_racial_bloodrage",
    ["Glyph of Bloodthirst"] = "spell_nature_bloodlust",
    ["Glyph of Charge"] = "ability_warrior_charge",
    ["Glyph of Cleaving"] = "ability_warrior_cleave",
    ["Glyph of Command"] = "ability_warrior_rallyingcry",
    ["Glyph of Devastate"] = "ability_warrior_devastate",
    ["Glyph of Enduring Victory"] = "ability_warrior_devastate",
    ["Glyph of Enraged Regeneration"] = "ability_warrior_focusedrage",
    ["Glyph of Execution"] = "inv_sword_48",
    ["Glyph of Hamstring"] = "ability_shockwave",
    ["Glyph of Heroic Strike"] = "ability_rogue_ambush",
    ["Glyph of Intervene"] = "ability_warrior_victoryrush",
    ["Glyph of Last Stand"] = "spell_holy_ashestoashes",
    ["Glyph of Mocking Blow"] = "ability_warrior_punishingblow",
    ["Glyph of Mortal Strike"] = "ability_warrior_savageblow",
    ["Glyph of Overpower"] = "ability_meleedamage",
    ["Glyph of Rapid Charge"] = "ability_warrior_charge",
    ["Glyph of Rending"] = "ability_gouge",
    ["Glyph of Resonating Power"] = "spell_nature_thunderclap",
    ["Glyph of Revenge"] = "ability_warrior_revenge",
    ["Glyph of Shield Wall"] = "ability_warrior_shieldwall",
    ["Glyph of Shockwave"] = "ability_warrior_shockwave",
    ["Glyph of Spell Reflection"] = "ability_warrior_shieldreflection",
    ["Glyph of Sunder Armor"] = "ability_warrior_sunder",
    ["Glyph of Sweeping Strikes"] = "ability_rogue_slicedice",
    ["Glyph of Taunt"] = "spell_nature_reincarnation",
    ["Glyph of Thunder Clap"] = "spell_nature_thunderclap",
    ["Glyph of Victory Rush"] = "ability_warrior_devastate",
    ["Glyph of Vigilance"] = "ability_warrior_vigilance",
    ["Glyph of Whirlwind"] = "ability_whirlwind",
}

local iconCache = {}
local hooksInstalled

local function GetSpellNameSafe(spellID)
    if type(GetSpellInfo) ~= "function" then
        return nil
    end

    local name = GetSpellInfo(spellID)
    return name
end

local function TrimText(value)
    if type(value) ~= "string" then
        return nil
    end

    local text = value:gsub("^%s+", "")
    text = text:gsub("%s+$", "")
    return text
end

local function GetIconStemFromGlyphName(glyphName)
    glyphName = TrimText(glyphName)
    if not glyphName then
        return nil
    end

    return glyphIconMap[glyphName]
end

local function GetIconStemFromValue(value)
    if type(value) == "number" then
        return GetIconStemFromGlyphName(GetSpellNameSafe(value))
    end

    if type(value) == "string" then
        return GetIconStemFromGlyphName(value)
    end

    return nil
end

local function GetIconStemFromValues(...)
    for i = 1, select("#", ...) do
        local iconStem = GetIconStemFromValue(select(i, ...))
        if iconStem then
            return iconStem
        end
    end

    return nil
end

local function BuildTexturePath(iconStem, socketed)
    if not iconStem then
        return nil
    end

    local cacheKey = iconStem .. (socketed and ":socket" or ":list")
    if iconCache[cacheKey] then
        return iconCache[cacheKey]
    end

    local texturePath
    if socketed then
        texturePath = ADDON_ROUNDED_PATH .. iconStem
    else
        texturePath = ADDON_ICON_PATH .. iconStem
    end

    iconCache[cacheKey] = texturePath
    return texturePath
end

local function SetFullIconTexture(textureObject, texturePath)
    if not textureObject or not texturePath then
        return
    end

    if type(textureObject.SetTexture) == "function" then
        textureObject:SetTexture(texturePath)
    end

    if type(textureObject.SetVertexColor) == "function" then
        textureObject:SetVertexColor(1, 1, 1, 1)
    end

    if type(textureObject.SetAlpha) == "function" then
        textureObject:SetAlpha(1)
    end

    if type(textureObject.SetTexCoord) == "function" then
        textureObject:SetTexCoord(0, 1, 0, 1)
    end
end

local function HideTexture(textureObject)
    if textureObject and type(textureObject.Hide) == "function" then
        textureObject:Hide()
    end
end

local function ShowTexture(textureObject)
    if textureObject and type(textureObject.Show) == "function" then
        textureObject:Show()
    end
end

local function SetTextureAlpha(textureObject, alpha)
    if textureObject and type(textureObject.SetAlpha) == "function" then
        textureObject:SetAlpha(alpha)
    end
end

local function SetTextureLayer(textureObject, drawLayer, subLevel)
    if textureObject and type(textureObject.SetDrawLayer) == "function" then
        textureObject:SetDrawLayer(drawLayer, subLevel)
    end
end

local function HideSocketOverlay(slotFrame)
    if slotFrame then
        HideTexture(slotFrame._EasyGlyphOverlay)
    end
end

local function HideSocketRing(slotFrame)
    if slotFrame then
        HideTexture(slotFrame._EasyGlyphMajorRing)
    end
end

local function HideNativeMajorRing(slotFrame)
    if not slotFrame then
        return
    end

    -- leave highlight alone or hover dies
    if slotFrame.setting then
        SetTextureAlpha(slotFrame.setting, 0)
        HideTexture(slotFrame.setting)
    end

    if slotFrame.ring then
        SetTextureAlpha(slotFrame.ring, 0)
        HideTexture(slotFrame.ring)
    end
end

local function RestoreNativeRing(slotFrame)
    if not slotFrame then
        return
    end

    if slotFrame.setting then
        SetTextureAlpha(slotFrame.setting, 1)
        ShowTexture(slotFrame.setting)
    end

    if slotFrame.ring then
        SetTextureAlpha(slotFrame.ring, 1)
        ShowTexture(slotFrame.ring)
    end
end

local function CreateHolder(slotFrame, key, frameLevelBonus)
    if not slotFrame or type(CreateFrame) ~= "function" then
        return nil
    end

    if slotFrame[key] then
        return slotFrame[key]
    end

    local holder = CreateFrame("Frame", nil, slotFrame)
    if not holder then
        return nil
    end

    if type(holder.SetAllPoints) == "function" then
        holder:SetAllPoints(slotFrame)
    end

    if type(holder.SetFrameStrata) == "function" and type(slotFrame.GetFrameStrata) == "function" then
        holder:SetFrameStrata(slotFrame:GetFrameStrata())
    end

    if type(holder.SetFrameLevel) == "function" and type(slotFrame.GetFrameLevel) == "function" then
        holder:SetFrameLevel((slotFrame:GetFrameLevel() or 0) + frameLevelBonus)
    end

    slotFrame[key] = holder
    return holder
end

local function RefreshHolderLevel(slotFrame, key, frameLevelBonus)
    local holder = slotFrame and slotFrame[key]
    if holder and type(holder.SetFrameLevel) == "function" and type(slotFrame.GetFrameLevel) == "function" then
        holder:SetFrameLevel((slotFrame:GetFrameLevel() or 0) + frameLevelBonus)
    end
end

local function CreateSlotTexture(slotFrame, textureKey, holderKey, frameLevelBonus, drawLayer, subLevel)
    if not slotFrame then
        return nil
    end

    if slotFrame[textureKey] then
        return slotFrame[textureKey]
    end

    local holder = CreateHolder(slotFrame, holderKey, frameLevelBonus) or slotFrame
    if type(holder.CreateTexture) ~= "function" then
        return nil
    end

    local textureObject = holder:CreateTexture(nil, drawLayer)
    if not textureObject then
        return nil
    end

    SetTextureLayer(textureObject, drawLayer, subLevel)
    HideTexture(textureObject)

    slotFrame[textureKey] = textureObject
    return textureObject
end

local function GetOrCreateSocketOverlay(slotFrame)
    return CreateSlotTexture(
        slotFrame,
        "_EasyGlyphOverlay",
        "_EasyGlyphOverlayHolder",
        SOCKET_OVERLAY_FRAMELEVEL_BONUS,
        SOCKET_OVERLAY_DRAW_LAYER,
        SOCKET_OVERLAY_SUBLEVEL
    )
end

local function GetOrCreateSocketRing(slotFrame)
    return CreateSlotTexture(
        slotFrame,
        "_EasyGlyphMajorRing",
        "_EasyGlyphRingHolder",
        SOCKET_RING_FRAMELEVEL_BONUS,
        SOCKET_RING_DRAW_LAYER,
        SOCKET_RING_SUBLEVEL
    )
end

local function SaveSocketTextureLayout(slotFrame)
    if not slotFrame or slotFrame._EasyGlyphSocketLayout or not slotFrame.glyph then
        return
    end

    local textureObject = slotFrame.glyph
    local layout = {
        points = {},
    }

    if type(textureObject.GetWidth) == "function" then
        layout.width = textureObject:GetWidth()
    end

    if type(textureObject.GetHeight) == "function" then
        layout.height = textureObject:GetHeight()
    end

    if type(textureObject.GetNumPoints) == "function" and type(textureObject.GetPoint) == "function" then
        local numPoints = textureObject:GetNumPoints() or 0
        for i = 1, numPoints do
            local point, relativeTo, relativePoint, xOfs, yOfs = textureObject:GetPoint(i)
            layout.points[i] = {
                point = point,
                relativeTo = relativeTo,
                relativePoint = relativePoint,
                xOfs = xOfs,
                yOfs = yOfs,
            }
        end
    end

    slotFrame._EasyGlyphSocketLayout = layout
end

local function RestoreSocketTextureLayout(slotFrame)
    if not slotFrame or not slotFrame.glyph or not slotFrame._EasyGlyphSocketLayout then
        return
    end

    local textureObject = slotFrame.glyph
    local layout = slotFrame._EasyGlyphSocketLayout

    if layout.width and type(textureObject.SetWidth) == "function" then
        textureObject:SetWidth(layout.width)
    end

    if layout.height and type(textureObject.SetHeight) == "function" then
        textureObject:SetHeight(layout.height)
    end

    if type(textureObject.ClearAllPoints) == "function" then
        textureObject:ClearAllPoints()
    end

    if type(textureObject.SetPoint) == "function" and layout.points then
        for i = 1, #layout.points do
            local pointData = layout.points[i]
            if pointData and pointData.point then
                if pointData.relativeTo then
                    textureObject:SetPoint(pointData.point, pointData.relativeTo, pointData.relativePoint or pointData.point, pointData.xOfs or 0, pointData.yOfs or 0)
                else
                    textureObject:SetPoint(pointData.point, pointData.xOfs or 0, pointData.yOfs or 0)
                end
            end
        end
    end
end

local function GetSocketBaseSize(slotFrame)
    SaveSocketTextureLayout(slotFrame)

    local layout = slotFrame and slotFrame._EasyGlyphSocketLayout or nil
    local width = layout and layout.width
    local height = layout and layout.height

    if (not width or width <= 0) and slotFrame and slotFrame.glyph and type(slotFrame.glyph.GetWidth) == "function" then
        width = slotFrame.glyph:GetWidth()
    end

    if (not height or height <= 0) and slotFrame and slotFrame.glyph and type(slotFrame.glyph.GetHeight) == "function" then
        height = slotFrame.glyph:GetHeight()
    end

    return width or 64, height or 64
end

local function GetSocketIconScale(glyphType)
    if glyphType == 1 then
        return SOCKET_ICON_MAJOR_SCALE
    end

    if glyphType == 2 then
        return SOCKET_ICON_MINOR_SCALE
    end

    return SOCKET_ICON_DEFAULT_SCALE
end

local function LayoutCenteredTexture(textureObject, slotFrame, width, height, scale, drawLayer, subLevel)
    if not textureObject or not slotFrame then
        return
    end

    if type(textureObject.ClearAllPoints) == "function" then
        textureObject:ClearAllPoints()
    end

    if type(textureObject.SetPoint) == "function" then
        textureObject:SetPoint("CENTER", slotFrame, "CENTER", SOCKET_OFFSET_X, SOCKET_OFFSET_Y)
    end

    if type(textureObject.SetWidth) == "function" then
        textureObject:SetWidth(width * scale)
    end

    if type(textureObject.SetHeight) == "function" then
        textureObject:SetHeight(height * scale)
    end

    SetTextureLayer(textureObject, drawLayer, subLevel)
end

local function ApplySocketOverlayLayout(slotFrame, glyphType)
    local overlay = GetOrCreateSocketOverlay(slotFrame)
    if not overlay then
        return nil
    end

    RefreshHolderLevel(slotFrame, "_EasyGlyphOverlayHolder", SOCKET_OVERLAY_FRAMELEVEL_BONUS)

    local width, height = GetSocketBaseSize(slotFrame)
    LayoutCenteredTexture(overlay, slotFrame, width, height, GetSocketIconScale(glyphType), SOCKET_OVERLAY_DRAW_LAYER, SOCKET_OVERLAY_SUBLEVEL)

    return overlay
end

local function ApplySocketRingLayout(slotFrame, glyphType)
    if glyphType ~= 1 then
        HideSocketRing(slotFrame)
        return nil
    end

    local ring = GetOrCreateSocketRing(slotFrame)
    if not ring then
        return nil
    end

    RefreshHolderLevel(slotFrame, "_EasyGlyphRingHolder", SOCKET_RING_FRAMELEVEL_BONUS)

    local width, height = GetSocketBaseSize(slotFrame)
    LayoutCenteredTexture(ring, slotFrame, width, height, SOCKET_MAJOR_RING_SCALE, SOCKET_RING_DRAW_LAYER, SOCKET_RING_SUBLEVEL)

    return ring
end

local function GetSocketIconStemAndType(slotID)
    if not slotID or type(GetGlyphSocketInfo) ~= "function" then
        return nil, nil
    end

    local result
    if GlyphFrame and GlyphFrame.talentGroup then
        result = { pcall(GetGlyphSocketInfo, slotID, GlyphFrame.talentGroup) }
    else
        result = { pcall(GetGlyphSocketInfo, slotID) }
    end

    if not result[1] then
        return nil, nil
    end

    table.remove(result, 1)

    local glyphType = result[2]
    local iconStem = GetIconStemFromValues(unpack(result))

    return iconStem, glyphType
end

local function ApplySocketedGlyphIcon(slotFrame, slotID)
    if not slotFrame or not slotID then
        return
    end

    local iconStem, glyphType = GetSocketIconStemAndType(slotID)
    if not slotFrame.glyph then
        HideSocketOverlay(slotFrame)
        HideSocketRing(slotFrame)
        RestoreNativeRing(slotFrame)
        return
    end

    SaveSocketTextureLayout(slotFrame)
    RestoreSocketTextureLayout(slotFrame)
    ShowTexture(slotFrame.glyph)
    SetTextureAlpha(slotFrame.glyph, 1)

    if type(slotFrame.glyph.SetVertexColor) == "function" then
        slotFrame.glyph:SetVertexColor(1, 1, 1, 1)
    end

    if not iconStem then
        HideSocketOverlay(slotFrame)
        HideSocketRing(slotFrame)
        RestoreNativeRing(slotFrame)
        return
    end

    local overlay = ApplySocketOverlayLayout(slotFrame, glyphType)
    if not overlay then
        HideSocketRing(slotFrame)
        RestoreNativeRing(slotFrame)
        return
    end

    SetFullIconTexture(overlay, BuildTexturePath(iconStem, true))
    ShowTexture(overlay)

    if glyphType == 1 then
        HideNativeMajorRing(slotFrame)

        local ring = ApplySocketRingLayout(slotFrame, glyphType)
        if ring then
            SetFullIconTexture(ring, ADDON_MAJOR_RING_PATH)
            ShowTexture(ring)
        end
    else
        HideSocketRing(slotFrame)
        RestoreNativeRing(slotFrame)
    end
end

local function PostGlyphSlotUpdate(a, b)
    local slotFrame
    local slotID

    -- old glyph ui is inconsistent here
    if type(a) == "table" then
        slotFrame = a
        slotID = b
    elseif type(b) == "table" then
        slotFrame = b
        slotID = a
    elseif type(a) == "number" then
        slotID = a
        slotFrame = _G["GlyphFrameGlyph" .. a]
    end

    if not slotID and slotFrame and type(slotFrame.GetID) == "function" then
        slotID = slotFrame:GetID()
    end

    ApplySocketedGlyphIcon(slotFrame, slotID)
end

local function GetFontStringText(object)
    if object and type(object.GetText) == "function" then
        return object:GetText()
    end

    return nil
end

local function GetButtonGlyphName(button)
    if not button then
        return nil
    end

    if type(button.name) == "string" then
        return button.name
    end

    if type(button.text) == "string" then
        return button.text
    end

    local text = GetFontStringText(button.name)
    if text then
        return text
    end

    text = GetFontStringText(button.text)
    if text then
        return text
    end

    text = GetFontStringText(button.Name)
    if text then
        return text
    end

    text = GetFontStringText(button.Text)
    if text then
        return text
    end

    if type(button.GetName) == "function" then
        local baseName = button:GetName()
        if baseName then
            text = GetFontStringText(_G[baseName .. "Name"])
            if text then
                return text
            end

            text = GetFontStringText(_G[baseName .. "Text"])
            if text then
                return text
            end
        end
    end

    return nil
end

local function GetButtonIconStem(button)
    if not button then
        return nil
    end

    local spellFields = {
        "glyphSpellID",
        "glyphSpell",
        "spellID",
        "spell",
        "glyphID",
    }

    for i = 1, #spellFields do
        local iconStem = GetIconStemFromValue(button[spellFields[i]])
        if iconStem then
            return iconStem
        end
    end

    return GetIconStemFromValue(GetButtonGlyphName(button))
end

local function GetButtonIcon(button)
    if not button then
        return nil
    end

    if button.icon and type(button.icon.SetTexture) == "function" then
        return button.icon
    end

    if button.Icon and type(button.Icon.SetTexture) == "function" then
        return button.Icon
    end

    if type(button.GetName) == "function" then
        local baseName = button:GetName()
        if baseName then
            if _G[baseName .. "Icon"] and type(_G[baseName .. "Icon"].SetTexture) == "function" then
                return _G[baseName .. "Icon"]
            end

            if _G[baseName .. "icon"] and type(_G[baseName .. "icon"].SetTexture) == "function" then
                return _G[baseName .. "icon"]
            end
        end
    end

    return nil
end

local function ApplyGlyphListIcons()
    if not GlyphFrame then
        return
    end

    local scrollFrame = GlyphFrame.scrollFrame or GlyphFrameScrollFrame
    if not scrollFrame or not scrollFrame.buttons then
        return
    end

    for i = 1, #scrollFrame.buttons do
        local button = scrollFrame.buttons[i]
        if button and type(button.IsShown) == "function" and button:IsShown() then
            local iconStem = GetButtonIconStem(button)
            local iconTexture = iconStem and GetButtonIcon(button)

            if iconTexture then
                SetFullIconTexture(iconTexture, BuildTexturePath(iconStem, false))
            end
        end
    end
end

local function ApplyAllSocketedGlyphIcons()
    local numSlots = 6

    if type(GetNumGlyphSockets) == "function" then
        numSlots = GetNumGlyphSockets() or numSlots
    end

    for i = 1, numSlots do
        ApplySocketedGlyphIcon(_G["GlyphFrameGlyph" .. i], i)
    end
end

local function ApplyAll()
    ApplyAllSocketedGlyphIcons()
    ApplyGlyphListIcons()
end

local function InstallHooks()
    if hooksInstalled or type(hooksecurefunc) ~= "function" then
        return
    end

    if type(GlyphFrameGlyph_UpdateSlot) == "function" then
        hooksecurefunc("GlyphFrameGlyph_UpdateSlot", PostGlyphSlotUpdate)
    end

    if type(GlyphFrame_UpdateGlyphList) == "function" then
        hooksecurefunc("GlyphFrame_UpdateGlyphList", ApplyGlyphListIcons)
    end

    if GlyphFrame and type(GlyphFrame.HookScript) == "function" then
        GlyphFrame:HookScript("OnShow", ApplyAll)
    end

    hooksInstalled = true
    ApplyAll()
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:RegisterEvent("PLAYER_LOGIN")

loader:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "Blizzard_GlyphUI" then
        InstallHooks()
        self:UnregisterEvent("ADDON_LOADED")
        return
    end

    if event == "PLAYER_LOGIN" then
        if type(IsAddOnLoaded) == "function" and IsAddOnLoaded("Blizzard_GlyphUI") then
            InstallHooks()
        end
    end
end)

if type(IsAddOnLoaded) == "function" and IsAddOnLoaded("Blizzard_GlyphUI") then
    InstallHooks()
end
