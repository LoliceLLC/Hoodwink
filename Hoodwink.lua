local Hoodwink = {}

-- Core init
local CoreHero = Heroes.GetLocal()
local IsHoodwink = false
if (CoreHero) then
    IsHoodwink = NPC.GetUnitName(CoreHero) == 'npc_dota_hero_hoodwink'
end
HeroesCore.UseCurrentPath(IsHoodwink)

-- Enable script
Hoodwink.MainEnable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Agility',  'Hoodwink' }, 'Enable', false)
HeroesCore.AddOptionIcon(Hoodwink.MainEnable, '~/MenuIcons/Enable/enable_check_boxed.png')
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Agility', 'Hoodwink' }, 'panorama/images/heroes/icons/npc_dota_hero_hoodwink_png.vtex_c')

-- Combo key
Hoodwink.ComboKey = HeroesCore.AddKeyOption({ 'Hero Specific', 'Agility',  'Hoodwink' }, 'Combo key', Enum.ButtonCode.KEY_NONE)
HeroesCore.AddOptionIcon(Hoodwink.ComboKey, '~/MenuIcons/status.png')

-- Blink usage
local BlinkArgs = {
    style = HeroesCore.AddOptionCombo({'Hero Specific', 'Agility', 'Hoodwink', 'Blink options'}, 'Usage style', { "Don't use", 'To enemy', 'To cursor' }, 2),
    key = HeroesCore.AddKeyOption({ 'Hero Specific', 'Agility',  'Hoodwink', 'Blink options' }, 'Additional key', Enum.ButtonCode.KEY_NONE),
    graded_always = HeroesCore.AddOptionBool({ 'Hero Specific', 'Agility',  'Hoodwink', 'Blink options' }, 'Use graded blink on close distance', true)
    }
    HeroesCore.AddMenuIcon({'Hero Specific', 'Agility', 'Hoodwink', 'Blink options'}, 'panorama/images/items/blink_png.vtex_c')
    HeroesCore.AddOptionIcon(BlinkArgs.style, '~/MenuIcons/Lists/single_choice.png')
    HeroesCore.AddOptionIcon(BlinkArgs.key, '~/MenuIcons/status.png')
    HeroesCore.AddOptionIcon(BlinkArgs.graded_always, 'panorama/images/items/overwhelming_blink_png.vtex_c')
    function Hoodwink.OnMenuOptionChange(option, oldValue, newValue)
        if (option ~= BlinkArgs.style) then return end
        HeroesCore.UseCurrentPath(IsHoodwink)
        if (newValue == 1) then
            BlinkArgs.distance = HeroesCore.AddOptionSlider({ 'Hero Specific', 'Agility',  'Hoodwink', 'Blink options' }, 'Blink distance', 0, 1200, 400)
            HeroesCore.AddOptionIcon(BlinkArgs.distance, '~/MenuIcons/edit.png')
        else
            HeroesCore.RemoveOption(BlinkArgs.distance)
        BlinkArgs.distance = nil
    end
end

-- Linken breaker
Hoodwink.LinkenBreakerEnable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Agility', 'Hoodwink', 'Linken breaker' }, 'Enable', false)
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Agility', 'Hoodwink', 'Linken breaker' }, '~/MenuIcons/dota/linken.png')
HeroesCore.AddOptionIcon(Hoodwink.LinkenBreakerEnable, '~/MenuIcons/Enable/enable_check_boxed.png')
-- Use in MirrorShield
Hoodwink.LinkenBreakerMirrorShieldEnable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Agility', 'Hoodwink', 'Linken breaker' }, 'Use in MirrorShield', false)
HeroesCore.AddOptionIcon(Hoodwink.LinkenBreakerMirrorShieldEnable, 'panorama/images/items/mirror_shield_png.vtex_c')
-- Items for linken breaker
Hoodwink.ItemsForLinkenBreaker = HeroesCore.AddOptionMultiSelect({'Hero Specific', 'Agility', 'Hoodwink', 'Linken breaker'}, 'Items:',
{
    { 'item_book_of_shadows', 'panorama/images/items/book_of_shadows_png.vtex_c', true },
    { 'item_heavens_halberd', 'panorama/images/items/heavens_halberd_png.vtex_c', true },
    { 'item_wind_waker', 'panorama/images/items/wind_waker_png.vtex_c', true },
    { 'item_cyclone', 'panorama/images/items/cyclone_png.vtex_c', true },
    { 'item_hurricane_pike', 'panorama/images/items/hurricane_pike_png.vtex_c', true },
    { 'item_force_staff', 'panorama/images/items/force_staff_png.vtex_c', true },
    { 'item_diffusal_blade', 'panorama/images/items/diffusal_blade_png.vtex_c', true },
    { 'item_bloodthorn', 'panorama/images/items/bloodthorn_png.vtex_c', true },
    { 'item_orchid', 'panorama/images/items/orchid_png.vtex_c', true },
    { 'item_rod_of_atos', 'panorama/images/items/rod_of_atos_png.vtex_c', true },
    { 'item_sheepstick', 'panorama/images/items/sheepstick_png.vtex_c', true },
    { 'item_nullifier', 'panorama/images/items/nullifier_png.vtex_c', true },
    { 'item_ethereal_blade', 'panorama/images/items/ethereal_blade_png.vtex_c', true }
}, false)
HeroesCore.AddOptionIcon(Hoodwink.ItemsForLinkenBreaker, '~/MenuIcons/dots.png')
Menu.AddOptionTip(Hoodwink.ItemsForLinkenBreaker, 'You can move items on LMB to change priority!')

-- Items usage
-- Important items
Hoodwink.ImportantItemsUsage = HeroesCore.AddOptionMultiSelect({'Hero Specific', 'Agility', 'Hoodwink', 'Items usage'}, 'Important usage:',
{
    { 'item_black_king_bar', 'panorama/images/items/black_king_bar_png.vtex_c', false },
    { 'item_abyssal_blade', 'panorama/images/items/abyssal_blade_png.vtex_c', true },
    { 'item_sheepstick', 'panorama/images/items/sheepstick_png.vtex_c', true },
    { 'item_bloodthorn', 'panorama/images/items/bloodthorn_png.vtex_c', true },
    { 'item_orchid', 'panorama/images/items/orchid_png.vtex_c', true }
}, false)
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Agility', 'Hoodwink', 'Items usage' }, '~/MenuIcons/ps_items.png')
HeroesCore.AddOptionIcon(Hoodwink.ImportantItemsUsage, '~/MenuIcons/ellipsis.png')
-- Semi-Important items
Hoodwink.SemiImportantItemsUsage = HeroesCore.AddOptionMultiSelect({'Hero Specific', 'Agility', 'Hoodwink', 'Items usage'}, 'Semi-Important usage:',
{
    { 'item_heavy_blade', 'panorama/images/items/heavy_blade_png.vtex_c', true },
    { 'item_nullifier', 'panorama/images/items/nullifier_png.vtex_c', true },
    { 'item_veil_of_discord', 'panorama/images/items/veil_of_discord_png.vtex_c', true },
    { 'item_ethereal_blade', 'panorama/images/items/ethereal_blade_png.vtex_c', false },
    { 'item_gungir', 'panorama/images/items/gungir_png.vtex_c', true },
    { 'item_rod_of_atos', 'panorama/images/items/rod_of_atos_png.vtex_c', true },
    { 'item_diffusal_blade', 'panorama/images/items/diffusal_blade_png.vtex_c', true }
}, false)
HeroesCore.AddOptionIcon(Hoodwink.SemiImportantItemsUsage, '~/MenuIcons/ellipsis.png')
-- Other items
Hoodwink.OtherItemsUsage = HeroesCore.AddOptionMultiSelect({'Hero Specific', 'Agility', 'Hoodwink', 'Items usage'}, 'Other usage:',
{
    { 'item_heavens_halberd', 'panorama/images/items/heavens_halberd_png.vtex_c', true },
    { 'item_solar_crest', 'panorama/images/items/solar_crest_png.vtex_c', true },
    { 'item_medallion_of_courage', 'panorama/images/items/medallion_of_courage_png.vtex_c', true },
    { 'item_spirit_vessel', 'panorama/images/items/spirit_vessel_png.vtex_c', false },
    { 'item_urn_of_shadows', 'panorama/images/items/urn_of_shadows_png.vtex_c', false },
    { 'item_shivas_guard', 'panorama/images/items/shivas_guard_png.vtex_c', true },
    { 'item_demonicon', 'panorama/images/items/demonicon_png.vtex_c', false },
    { 'item_manta', 'panorama/images/items/manta_png.vtex_c', true },
    { 'item_lotus_orb', 'panorama/images/items/lotus_orb_png.vtex_c', false },
    { 'item_blade_mail', 'panorama/images/items/blade_mail_png.vtex_c', true },
    { 'item_mjollnir', 'panorama/images/items/mjollnir_png.vtex_c', true },
    { 'item_satanic', 'panorama/images/items/satanic_png.vtex_c', true },
    { 'item_mask_of_madness', 'panorama/images/items/mask_of_madness_png.vtex_c', true },
    { 'item_boots_of_bearing', 'panorama/images/items/boots_of_bearing_png.vtex_c', true },
    { 'item_ancient_janggo', 'panorama/images/items/ancient_janggo_png.vtex_c', true },
    { 'item_dagger_of_ristul', 'panorama/images/items/dagger_of_ristul_png.vtex_c', true },
}, false)
HeroesCore.AddOptionIcon(Hoodwink.OtherItemsUsage, '~/MenuIcons/ellipsis.png')
-- Close distance items
Hoodwink.CloseDistanceItemsUsage = HeroesCore.AddOptionMultiSelect({'Hero Specific', 'Agility', 'Hoodwink', 'Items usage'}, 'Close distance:',
{
    { 'item_fallen_sky', 'panorama/images/items/fallen_sky_png.vtex_c', false },
    { 'item_force_staff', 'panorama/images/items/force_staff_png.vtex_c', false },
    { 'item_hurricane_pike', 'panorama/images/items/hurricane_pike_png.vtex_c', false },
    { 'item_invis_sword', 'panorama/images/items/invis_sword_png.vtex_c', false },
    { 'item_silver_edge', 'panorama/images/items/silver_edge_png.vtex_c', true }
}, false)
HeroesCore.AddOptionIcon(Hoodwink.CloseDistanceItemsUsage, '~/MenuIcons/ellipsis.png')

-- Abilities usage
Hoodwink.AbilitiesForCombo = HeroesCore.AddOptionMultiSelect({ 'Hero Specific', 'Agility', 'Hoodwink', }, 'Abilities usage:',
{
    { 'acorn_shot', 'panorama/images/spellicons/hoodwink_acorn_shot_png.vtex_c', true },
    { 'bushwhack', 'panorama/images/spellicons/hoodwink_bushwhack_png.vtex_c', true },
    { 'scurry', 'panorama/images/spellicons/hoodwink_scurry_png.vtex_c', false },
    { 'decoy', 'panorama/images/spellicons/hoodwink_decoy_png.vtex_c', false },
    { 'hunters_boomerang', 'panorama/images/spellicons/hoodwink_hunters_boomerang_png.vtex_c', true },
    { 'sharpshooter', 'panorama/images/spellicons/hoodwink_sharpshooter_png.vtex_c', false }
}, false)
HeroesCore.AddOptionIcon(Hoodwink.AbilitiesForCombo, '~/MenuIcons/dots.png')

-- Sharpshooter settings
Hoodwink.SharpshooterModeCombo = HeroesCore.AddOptionCombo({ 'Hero Specific', 'Agility',  'Hoodwink', 'Sharpshooter settings' }, 'Sharpshooter use mode', { 'Use always', 'Only if target stuned' }, 1)
HeroesCore.AddMenuIcon({ 'Hero Specific', 'Agility',  'Hoodwink', 'Sharpshooter settings' }, 'panorama/images/spellicons/hoodwink_sharpshooter_png.vtex_c')
HeroesCore.AddOptionIcon(Hoodwink.SharpshooterModeCombo, '~/MenuIcons/align.png')
-- Sharpshooter release settings
Hoodwink.SharpshooterModeRelease = HeroesCore.AddOptionCombo({ 'Hero Specific', 'Agility',  'Hoodwink', 'Sharpshooter settings' }, 'Sharpshooter release mode', { 'If counter equals 100 or killable', 'Wait to kill' }, 0)
HeroesCore.AddOptionIcon(Hoodwink.SharpshooterModeRelease, '~/MenuIcons/align.png')

-- Sharpshooter auto aim
Hoodwink.SharpshooterAimKey = HeroesCore.AddKeyOption({ 'Hero Specific', 'Agility',  'Hoodwink' }, 'Sharpshooter aim', Enum.ButtonCode.KEY_NONE)
HeroesCore.AddOptionIcon(Hoodwink.SharpshooterAimKey, 'panorama/images/spellicons/hoodwink_sharpshooter_png.vtex_c')

-- Combo in lotus
Hoodwink.ComboInLotusEnable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Agility',  'Hoodwink', }, 'Combo in LotusOrb', false)
HeroesCore.AddOptionIcon(Hoodwink.ComboInLotusEnable, 'panorama/images/items/lotus_orb_png.vtex_c')
Menu.AddOptionTip(Hoodwink.ComboInLotusEnable, 'If you are immune to magic, the combo will work in LotusOrb.')
-- Combo in mirror shield
Hoodwink.ComboInMirrorShieldEnable = HeroesCore.AddOptionBool({ 'Hero Specific', 'Agility',  'Hoodwink' }, 'Combo in MirrorShield', false)
HeroesCore.AddOptionIcon(Hoodwink.ComboInMirrorShieldEnable, 'panorama/images/items/mirror_shield_png.vtex_c')
Menu.AddOptionTip(Hoodwink.ComboInMirrorShieldEnable, 'If you are immune to magic, the combo will work in MirrorShield.')

-- Timer
local Timer = -6061
local GameTime = nil

-- Me
local MyHero = nil
local MyTeam = nil
local MyMana = nil

-- My skills
local AcornShot = nil
local Bushwhack = nil
local Scurry = nil
local Decoy = nil
local HuntersBoomerang = nil
local Sharpshooter = nil
local SharpshooterRelease = nil

-- Range and radius and damage
local BushwhackTrapRadius = nil
local SharpshooterDamage = nil

-- Combo
local EnemyTarget = nil
local BreakerItem = nil
local ItemsToUse = { { items = Menu.GetItems(Hoodwink.ImportantItemsUsage) }, { items = Menu.GetItems(Hoodwink.SemiImportantItemsUsage) }, { items = Menu.GetItems(Hoodwink.OtherItemsUsage) }, { items = Menu.GetItems(Hoodwink.CloseDistanceItemsUsage) } }
local IsSaveToCastItems = { InLotus = nil, InMirrorShield = nil }

-- Particle
local ParticleHandler = 0

-- Init
function Hoodwink.Init()
    if (Engine.IsInGame()) then
        if (IsHoodwink) then
            MyHero = Heroes.GetLocal()
            MyPlayer = Players.GetLocal()
            MyTeam = Entity.GetTeamNum(MyHero)
        end
    end
end

Hoodwink.Init()

function Hoodwink.OnGameStart()
    Hoodwink.Init()
end

-- Updater
function Hoodwink.UpdateInfo()
    -- My mana
    MyMana = NPC.GetMana(MyHero)
    -- My skills
    AcornShot = NPC.GetAbility(MyHero, 'hoodwink_acorn_shot')
    Bushwhack = NPC.GetAbility(MyHero, 'hoodwink_bushwhack')
    Scurry = NPC.GetAbility(MyHero, 'hoodwink_scurry')
    Decoy = NPC.GetAbility(MyHero, 'hoodwink_decoy')
    HuntersBoomerang = NPC.GetAbility(MyHero, 'hoodwink_hunters_boomerang')
    Sharpshooter = NPC.GetAbility(MyHero, 'hoodwink_sharpshooter')
    SharpshooterRelease = NPC.GetAbility(MyHero, 'hoodwink_sharpshooter_release')
    -- Other
    BushwhackTrapRadius = Ability.GetLevelSpecialValueFor(Bushwhack, 'trap_radius')
    HuntersBoomerangRadius = Ability.GetCastRange(HuntersBoomerang)
    SharpshooterDamage = Ability.GetLevelSpecialValueFor(Sharpshooter, 'max_damage')
end

-- For LinkenBreaker
function Hoodwink.IsTargetedByProjectile(Hero)
    for _, TargetProjectile in pairs(TargetProjectiles.GetAll()) do
        if (TargetProjectile.Hero == Hero) then
            return true
        end
    end
    return false
end

-- Target particle
function Hoodwink.UpdateParticle()
    if (EnemyTarget and Menu.IsKeyDown(Hoodwink.ComboKey) and HeroesCore.IsTSelectorParticle()) then
        if (ParticleHandler == 0) then
            ParticleHandler = Particle.Create('particles/ui_mouseactions/range_finder_tower_aoe.vpcf', Enum.ParticleAttachment.PATTACH_INVALID, EnemyTarget)
        end
        Particle.SetControlPoint(ParticleHandler, 2, Entity.GetOrigin(MyHero))
        Particle.SetControlPoint(ParticleHandler, 6, Vector(1, 0, 0))
        Particle.SetControlPoint(ParticleHandler, 7, Entity.GetOrigin(EnemyTarget))
    else
        if (ParticleHandler > 0) then
            Particle.Destroy(ParticleHandler)
            ParticleHandler = 0
        end
    end
end

-- Determines whether it is currently possible to cast a spell or item
function Hoodwink.IsAvailableToCast(Items, Npc)
    if not Entity.IsAlive(Npc) or NPC.IsStunned(Npc) then
        return false
    end

    if Items and NPC.HasState(Npc, Enum.ModifierState.MODIFIER_STATE_MUTED) then
        return false
    end

    if NPC.HasModifier(Npc, 'modifier_obsidian_destroyer_astral_imprisonment_prison') or NPC.HasModifier(Npc, 'modifier_teleporting') or NPC.HasModifier(Npc, 'modifier_axe_berserkers_call') then
        return false
    end

    if not Items and (NPC.IsSilenced(Npc) or NPC.HasState(Npc, Enum.ModifierState.MODIFIER_STATE_HEXED) or NPC.HasState(Npc, Enum.ModifierState.MODIFIER_STATE_NIGHTMARED)) then
        return false
    end

    return true
end

function Hoodwink.OnUpdate()

    if (Menu.IsEnabled(Hoodwink.MainEnable)) then

        if (MyHero == nil) then return end
        if (not IsHoodwink) then return end

        -- Target particle
        Hoodwink.UpdateParticle()

        -- Amazing timer
        GameTime = GameRules.GetGameTime()
        if (Timer > GameTime) then return end
        Timer = HeroesCore.GetSleep(0.1)

        -- Updater
        Hoodwink.UpdateInfo()

        -- EnemyTarget writer
        if not EnemyTarget or not Entity.IsAlive(EnemyTarget) or Entity.IsDormant(EnemyTarget) then
            if HeroesCore.GetTSelectorStyle() == 1 and (Menu.IsKeyDown(Hoodwink.ComboKey)) or HeroesCore.GetTSelectorStyle() ~= 1 then
                EnemyTarget = HeroesCore.GetTarget(MyTeam, Enum.TeamType.TEAM_ENEMY)
            end
        elseif HeroesCore.GetTSelectorStyle() == 1 and not Menu.IsKeyDown(Hoodwink.ComboKey) then
            EnemyTarget = nil
        end

        if (not Entity.IsAlive(MyHero)) then
            EnemyTarget = nil
        end

        -- Move to cursor
        if not EnemyTarget and (HeroesCore.IsTSelectorMove() and (Menu.IsKeyDown(Hoodwink.ComboKey))) then
            NPC.MoveTo(MyHero, Input.GetWorldCursorPos())
            return
        end

        -- Sharpshooter aim bot
        if (Menu.IsKeyDown(Hoodwink.SharpshooterAimKey)) then
            if (NPC.HasModifier(MyHero, 'modifier_hoodwink_sharpshooter_windup')) then
                NPC.MoveTo(MyHero, HeroesCore.GetPredictionPos(Input.GetNearestHeroToCursor(MyTeam, Enum.TeamType.TEAM_ENEMY), 0.6), false)
                if (Modifier.GetStackCount(NPC.GetModifier(MyHero, 'modifier_hoodwink_sharpshooter_windup')) == 100) then
                    Ability.CastNoTarget(SharpshooterRelease)
                end
            end
        end

        -- LinkenBreaker
        if Menu.IsKeyDown(Hoodwink.ComboKey) and (Menu.IsEnabled(Hoodwink.LinkenBreakerEnable) or Menu.IsEnabled(Hoodwink.LinkenBreakerMirrorShieldEnable)) and not Hoodwink.IsTargetedByProjectile(EnemyTarget) and not NPC.HasState(EnemyTarget, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
            for _, Item in ipairs(Menu.GetItems(Hoodwink.ItemsForLinkenBreaker)) do
                if Menu.IsSelected(Hoodwink.ItemsForLinkenBreaker, Item) and Ability.IsCastable(NPC.GetItem(MyHero, Item), MyMana) then
                    BreakerItem = NPC.GetItem(MyHero, Item)
                    if NPC.IsLinkensProtected(EnemyTarget) and Menu.IsEnabled(Hoodwink.LinkenBreakerEnable) or NPC.GetItem(EnemyTarget, 'item_mirror_shield') and Menu.IsEnabled(Hoodwink.LinkenBreakerMirrorShieldEnable) then
                        Ability.CastTarget(BreakerItem, EnemyTarget)
                        break
                    end
                end
            end
        end

        -- Combo
        if (Menu.IsKeyDown(Hoodwink.ComboKey)) then

            -- If not is real target return end
            if (Entity.IsDormant(EnemyTarget) or not Entity.IsAlive(EnemyTarget) or NPC.IsStructure(EnemyTarget)) then return end

            -- LotusOrb check
            IsSaveToCastItems.InLotus = Menu.IsEnabled(Hoodwink.ComboInLotusEnable) or NPC.HasState(MyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) or (not NPC.HasModifier(EnemyTarget, 'modifier_item_lotus_orb_active'))

            -- MirrorShield check
            IsSaveToCastItems.InMirrorShield = Menu.IsEnabled(Hoodwink.ComboInMirrorShieldEnable) or NPC.HasState(MyHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) or (not Ability.IsReady(NPC.GetItem(EnemyTarget, 'item_mirror_shield')))

            -- Linken breaker check
            if (Menu.IsEnabled(Hoodwink.LinkenBreakerEnable)) then
                if (NPC.IsLinkensProtected(EnemyTarget)) then return end
            end

            -- Blink usage
            HeroesCore.BlinkUsage(MyHero, EnemyTarget, BlinkArgs)

            -- Stepping for combo
            local ComboCastStep = 0

            -- Items
            if (ComboCastStep == 0) then
                if not NPC.HasState(EnemyTarget, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
                    for _, ItemCategory in ipairs(ItemsToUse) do
                        for _, ItemName in ipairs(ItemCategory.items) do
                            if Ability.IsCastable(NPC.GetItem(MyHero, ItemName), MyMana) then
                                if Menu.IsSelected(Hoodwink.ImportantItemsUsage, ItemName) or Menu.IsSelected(Hoodwink.SemiImportantItemsUsage, ItemName) or Menu.IsSelected(Hoodwink.OtherItemsUsage, ItemName) or Menu.IsSelected(Hoodwink.CloseDistanceItemsUsage, ItemName) then
                                    if Hoodwink.IsAvailableToCast(true, MyHero) then
                                        if ItemName == 'item_black_king_bar' or ItemName == 'item_veil_of_discord' or ItemName == 'item_gungir' or ItemName == 'item_heavy_blade' or ItemName == 'item_shivas_guard'
                                        or ItemName == 'item_manta' or ItemName == 'item_lotus_orb' or ItemName == 'item_blade_mail' or ItemName == 'item_mjollnir' or ItemName == 'item_satanic'
                                        or ItemName == 'item_mask_of_madness' or ItemName == 'item_boots_of_bearing' or ItemName == 'item_ancient_janggo' or ItemName == 'item_dagger_of_ristul' then
                                            HeroesCore.ItemsUsage[ItemName](NPC.GetItem(MyHero, ItemName), EnemyTarget)
                                        elseif ItemName == 'item_fallen_sky' or ItemName == 'item_force_staff' or ItemName == 'item_hurricane_pike' or ItemName == 'item_invis_sword' or ItemName == 'item_silver_edge' then
                                            HeroesCore.ItemsUsage[ItemName .. '_c'](NPC.GetItem(MyHero, ItemName), EnemyTarget)
                                        else
                                            if (IsSaveToCastItems.InMirrorShield) then
                                                HeroesCore.ItemsUsage[ItemName](NPC.GetItem(MyHero, ItemName), EnemyTarget)
                                            end
                                        end
                                    end
                                end
                            else
                                ComboCastStep = 1
                            end
                        end
                    end
                end
            end

            local CantAttack = false

            -- Decoy
            if (ComboCastStep == 1) then
                if (Ability.IsCastable(Decoy, MyMana) and Hoodwink.IsAvailableToCast(false, MyHero) and Menu.IsSelected(Hoodwink.AbilitiesForCombo, 'decoy')) then
                    Ability.CastNoTarget(Decoy)
                else
                    ComboCastStep = 2
                end
            end

            -- HuntersBoomerang
            if (ComboCastStep == 2) then
                if (Ability.IsCastable(HuntersBoomerang, MyMana) and Hoodwink.IsAvailableToCast(false, MyHero) and Menu.IsSelected(Hoodwink.AbilitiesForCombo, 'hunters_boomerang')) then
                    local InRangeEnemies = Entity.GetHeroesInRadius(MyHero, HuntersBoomerangRadius, Enum.TeamType.TEAM_ENEMY)
                    for _, Enemy in ipairs(InRangeEnemies) do
                        if (Enemy == EnemyTarget) then
                            if (not IsSaveToCastItems.InLotus or not IsSaveToCastItems.InMirrorShield) then
                                ComboCastStep = 3
                            else
                                Ability.CastTarget(HuntersBoomerang, EnemyTarget)
                            end
                        else
                            ComboCastStep = 3
                        end
                    end
                else
                    ComboCastStep = 3
                end
            end

            -- Enemy pos
            local EnemyPosition = Entity.GetAbsOrigin(EnemyTarget)

            -- Trees
            local Trees = Trees.InRadius(EnemyPosition, BushwhackTrapRadius, true)
            local TempTrees = TempTrees.InRadius(EnemyPosition, BushwhackTrapRadius, true)

            CantAttack = false

            -- AcornShot
            if (ComboCastStep == 3) then
                if (Ability.IsCastable(AcornShot, MyMana) and Hoodwink.IsAvailableToCast(false, MyHero) and Menu.IsSelected(Hoodwink.AbilitiesForCombo, 'acorn_shot')) then
                    if (Ability.GetAutoCastState(AcornShot) and ((not (Trees[1] or TempTrees[1])) or not Ability.IsReady(Bushwhack))) then
                        Ability.CastPosition(AcornShot, EnemyPosition)
                    elseif (not Ability.GetAutoCastState(AcornShot)) then
                        if (not IsSaveToCastItems.InLotus or not IsSaveToCastItems.InMirrorShield) then
                            ComboCastStep = 4
                        else
                            Ability.CastTarget(AcornShot, EnemyTarget)
                        end
                    else
                        ComboCastStep = 4
                    end
                else
                    ComboCastStep = 4
                end
            end

            CantAttack = true

            -- Scurry
            if (ComboCastStep == 4) then
                if (Ability.IsCastable(Scurry, MyMana) and Hoodwink.IsAvailableToCast(false, MyHero) and Menu.IsSelected(Hoodwink.AbilitiesForCombo, 'scurry') and (not NPC.HasModifier(MyHero, 'modifier_hoodwink_scurry_active')) and (not NPC.HasModifier(MyHero, 'modifier_hoodwink_sharpshooter_windup'))) then
                    Ability.CastNoTarget(Scurry)
                else
                    ComboCastStep = 5
                end
            end

            CantAttack = false

            -- Bushwhack
            if (ComboCastStep == 5) then
                if (Ability.IsCastable(Bushwhack, MyMana) and Hoodwink.IsAvailableToCast(false, MyHero) and Menu.IsSelected(Hoodwink.AbilitiesForCombo, 'bushwhack')) then
                    -- Check if there are trees in the area and the enemy hero is disabled long enough
                    local IsBushwhackReady = Trees[1] or TempTrees[1] and (math.max(HeroesCore.GetDisableDuration(EnemyTarget), HeroesCore.GetHexDuration(EnemyTarget)) < (0.35 + ((EnemyPosition - Entity.GetAbsOrigin(MyHero)):Length2D() / 1200)))

                    if (IsBushwhackReady) then
                        Ability.CastPosition(Bushwhack, EnemyPosition)
                    else
                        ComboCastStep = 6
                    end
                else
                    ComboCastStep = 6
                end
            end

            CantAttack = true

            -- Sharpshooter
            if (ComboCastStep == 6) then
                if (Ability.IsCastable(Sharpshooter, MyMana) and Hoodwink.IsAvailableToCast(false, MyHero) and Menu.IsSelected(Hoodwink.AbilitiesForCombo, 'sharpshooter')) then
                    if (Menu.GetValue(Hoodwink.SharpshooterModeCombo) == 0 or NPC.HasState(EnemyTarget, Enum.ModifierState.MODIFIER_STATE_STUNNED) or NPC.HasState(EnemyTarget, Enum.ModifierState.MODIFIER_STATE_HEXED) or NPC.HasState(EnemyTarget, Enum.ModifierState.MODIFIER_STATE_ROOTED)) then
                        Ability.CastPosition(Sharpshooter, EnemyPosition)
                    else
                        ComboCastStep = 7
                    end
                else
                    ComboCastStep = 7
                end
            end

            -- Aimbot and stealer for Sharpshooter
            if (ComboCastStep == 7) then
                if (NPC.HasModifier(MyHero, 'modifier_hoodwink_sharpshooter_windup')) then
                    NPC.MoveTo(MyHero, HeroesCore.GetPredictionPos(EnemyTarget, 1), false)

                    local SharpshooterModifier = NPC.GetModifier(MyHero, 'modifier_hoodwink_sharpshooter_windup')
                    local StackCount = Modifier.GetStackCount(sharpshooterModifier)
                    local MySpellAmplification = NPC.GetModifierProperty(MyHero, Enum.ModifierFunction.MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE) + NPC.GetModifierProperty(MyHero, Enum.ModifierFunction.MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE)
                    local SharpshooterCounterDamage = (SharpshooterDamage * (StackCount / 100))
                    local SharpshooterFinalDamage = ((SharpshooterCounterDamage + (SharpshooterCounterDamage * (MySpellAmplification * 0.01))) * NPC.GetMagicalArmorDamageMultiplier(EnemyTarget)) - (((EnemyPosition - Entity.GetAbsOrigin(MyHero)):Length2D() / 2200.0) * NPC.GetHealthRegen(EnemyTarget)) - 25

                    if (NPC.HasModifier(EnemyTarget, 'modifier_hoodwink_hunters_mark')) then
                        SharpshooterFinalDamage = SharpshooterFinalDamage / 0.8
                    end

                    if (Menu.GetValue(Hoodwink.SharpshooterModeRelease) == 0) then
                        if (Entity.GetHealth(EnemyTarget) < SharpshooterFinalDamage or
                            Modifier.GetStackCount(SharpshooterModifier) == 100) then
                            Ability.CastNoTarget(SharpshooterRelease)
                        end
                    else
                        if (Entity.GetHealth(EnemyTarget) < SharpshooterFinalDamage) then
                            Ability.CastNoTarget(SharpshooterRelease)
                        end
                    end
                end
            end

            -- Orbwalker
            if (HeroesCore.IsAttackable(EnemyTarget) and CantAttack and (not NPC.HasModifier(MyHero, 'modifier_hoodwink_sharpshooter_windup'))) then
                HeroesCore.Orbwalker(MyHero, EnemyTarget)
            end
        end
    end
end

return Hoodwink
