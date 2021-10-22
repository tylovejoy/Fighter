#!include "doomfist.opy"
#!include "echo.opy"
#!include "lucio.opy"
#!include "hud.opy"
#!include "pharah.opy"
#!include "reinhardt.opy"

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
    wait(1)
    setMatchTime(1)
    wait(5)
    setMatchTime(9999)
    wait(1)
    pauseMatchTime()

rule "Spawn Dummy Bots TESTING":
    @Event eachPlayer
    @Condition eventPlayer.isCommunicatingSpray() == true
    
    createDummy(Hero.REINHARDT, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
            

