#!mainFile "fighter.opy"

rule "Abilities HUD":
    @Event global

    if localPlayer.getCurrentHero() == Hero.DOOMFIST:
        hudText(
            localPlayer, 
            "Abilities", "", "Use {0} to grab and slam an enemy into the ground!".format(Button.ABILITY_2), 
            HudPosition.LEFT, 
            0, 
            Color.WHITE, 
            Color.WHITE, 
            Color.WHITE, 
            HudReeval.VISIBILITY, 
            SpecVisibility.ALWAYS
        )
    elif localPlayer.getCurrentHero() == Hero.ECHO:
        hudText(
            localPlayer, 
            "Abilities", "", "Press {0} to use a powerful beam attack!".format(Button.ULTIMATE), 
            HudPosition.LEFT, 
            0, 
            Color.WHITE, 
            Color.WHITE, 
            Color.WHITE, 
            HudReeval.VISIBILITY, 
            SpecVisibility.ALWAYS
        )
    elif localPlayer.getCurrentHero() == Hero.LUCIO:
        hudText(
            localPlayer, 
            "Abilities", "", "Damage Over Time Aura\nAmp it up for a burst of AoE damage!", 
            HudPosition.LEFT, 
            0, 
            Color.WHITE, 
            Color.WHITE, 
            Color.WHITE, 
            HudReeval.VISIBILITY, 
            SpecVisibility.ALWAYS
        )
    elif localPlayer.getCurrentHero() == Hero.REINHARDT:
        pass