#!mainFile "fighter.opy"

#!define DOT_DAMAGE 10
#!define AMP_DAMAGE 50

rule "--- [Lucio] ---":
    @Delimiter
    @Disabled

rule "Damage Over Time Aura Ability":
    @Event eachPlayer
    @Hero lucio
    @Condition len(getPlayersInRadius(eventPlayer.getPosition(), 12, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS)) > 0
    do:
        damage([player for player in getPlayersInRadius(eventPlayer.getPosition(), 12, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS) if player != eventPlayer], eventPlayer, DOT_DAMAGE)
        wait(1)
    while RULE_CONDITION    
    
rule "Amp DoT Ability":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    damage([player for player in getPlayersInRadius(eventPlayer.getPosition(), 12, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS) if player != eventPlayer], eventPlayer, AMP_DAMAGE)
