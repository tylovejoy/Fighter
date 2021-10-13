#!mainFile "fighter.opy"

#!extension beamEffects
#!extension beamSounds
#!extension explosionSounds
#!extension energyExplosionEffects
#!extension kineticExplosionEffects

#!define DOT_DAMAGE 20
#!define AMP_DAMAGE 50


rule "--- [Lucio] ---":
    @Delimiter


rule "[Lucio] Damage Over Time Aura Ability":
    @Event eachPlayer
    @Hero lucio
    @Condition getPlayersInRadius(eventPlayer, 12, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS) > 0
    do:
        damage(getPlayersInRadius(eventPlayer, 12, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, DOT_DAMAGE)
        wait(1)
    while RULE_CONDITION    
    
rule "[Lucio] Amp DoT Ability":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)

    damage(getPlayersInRadius(eventPlayer, 12, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, AMP_DAMAGE)
