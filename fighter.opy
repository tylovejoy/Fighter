#!include "doomfist.opy"
#!include "echo.opy"
#!include "lucio.opy"
#!include "hud.opy"
#!include "pharah.opy"

#!extension beamEffects
#!extension explosionSounds
#!extension kineticExplosionEffects
#!extension beamSounds

settings "settings.opy.json"

globalvar TimeRemaining 

rule "--- Gamemode ---":
    @Delimiter
    @Disabled

rule "Match Time":
    

rule "Spawn Dummy Bots TESTING":
    @Event eachPlayer
    @Condition eventPlayer.isCommunicatingSpray() == true
    
    createDummy(Hero.WIDOWMAKER, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
            
