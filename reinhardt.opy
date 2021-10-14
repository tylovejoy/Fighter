#!mainFile "fighter.opy"

rule "Spinning hammer":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)

    do:
        eventPlayer.startFacing(directionTowards(eventPlayer.getPosition(), eventPlayer.getFacingDirection()), 100, Relativity.TO_PLAYER, FacingReeval.DIRECTION_AND_TURN_RATE)
        eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    while RULE_CONDITION