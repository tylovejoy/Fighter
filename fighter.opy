#!include "doomfist.opy"
#!include "echo.opy"
#!include "lucio.opy"
#!include "hud.opy"

#!extension beamEffects
#!extension explosionSounds
#!extension kineticExplosionEffects
#!extension beamSounds

settings "settings.opy.json"

globalvar TimeRemaining 

rule "--- Gamemode ---":
    @Delimiter
    @Disabled

rule "Match time":
    if getCurrentGamemode() == Gamemode.SKIRMISH:
        goto lbl_0
    wait(0.25)
    setMatchTime(1)
    wait(1.1)
    setMatchTime(1)
    wait(1.1)
    lbl_0:
    while true:
        setMatchTime(3600)
        wait(2875)
        TimeRemaining += true
        if TimeRemaining == 5:
            TimeRemaining = 1800
            hudHeader(getAllPlayers(), "  Server Restarts In {0} Min  ".format(ceil(TimeRemaining / 60)), HudPosition.RIGHT, -200, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
            chase(TimeRemaining, false, rate=true, ChaseReeval.NONE)
            wait(1795)
            bigMessage(getAllPlayers(), "Restarting")
            wait(5)
            if getCurrentGamemode() == Gamemode.FFA:
                declarePlayerVictory(getAllPlayers()[0])
            else:
                declareTeamVictory(Color.TEAM_1)
            return

rule "Spawn Dummy Bots TESTING":
    @Event eachPlayer
    @Condition eventPlayer.isCommunicatingSpray() == true
    
    createDummy(Hero.WIDOWMAKER, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
            