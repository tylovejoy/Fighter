#!mainFile "fighter.opy"

rule "Spinning hammer":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)

    while eventPlayer.isHoldingButton(Button.ABILITY_1):  
        eventPlayer.startFacing(updateEveryTick(directionTowards(eventPlayer.getPosition(), eventPlayer.getFacingDirection())), 10000, Relativity.TO_PLAYER, FacingReeval.DIRECTION_AND_TURN_RATE)
        wait()
    eventPlayer.stopFacing()

rule "Burst Firestrike":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
        wait(0.5)
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        wait(0.5)
        eventPlayer.cancelPrimaryAction()
        wait(0.5)
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
        wait(0.5)
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        wait(0.5)
        eventPlayer.cancelPrimaryAction()
        wait(0.5)
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 6)
        wait(6)