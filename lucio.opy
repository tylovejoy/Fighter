#!mainFile "fighter.opy"

#!define DOT_DAMAGE 20
#!define AMP_DAMAGE 50

rule "--- [Lucio] ---":
    @Delimiter
    @Disabled

rule "Damage Over Time Aura Ability":
    @Event eachPlayer
    @Hero lucio
    @Condition getPlayersInRadius(eventPlayer, 12, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS) > 0
    do:
        damage(getPlayersInRadius(eventPlayer, 12, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, DOT_DAMAGE)
        wait(1)
    while RULE_CONDITION    
    
rule "Amp DoT Ability":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)

    damage(getPlayersInRadius(eventPlayer, 12, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, AMP_DAMAGE)
