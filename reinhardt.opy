#!mainFile "fighter.opy"

rule "Spinning hammer":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)

    #eventPlayer.startCamera(eventPlayer.getPosition() + vect(5,5,5), eventPlayer.getPosition(), 100)
    while eventPlayer.isHoldingButton(Button.ABILITY_1):  
        eventPlayer.startFacing(updateEveryTick(directionTowards(eventPlayer.getPosition(), eventPlayer.getFacingDirection())), 100000, Relativity.TO_PLAYER, FacingReeval.DIRECTION_AND_TURN_RATE)
        wait()
    eventPlayer.stopFacing()
    #eventPlayer.stopCamera()

rule "Burst Firestrike":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
        wait(0.48)
        eventPlayer.cancelPrimaryAction()
        wait()            
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
        wait()
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        wait(0.48)
        eventPlayer.cancelPrimaryAction()
        wait()
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
        wait()
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        wait(0.48)
        eventPlayer.cancelPrimaryAction()
        wait()
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 6)
        wait(6)

rule "Burning Firestrike":
    @Event playerTookDamage
