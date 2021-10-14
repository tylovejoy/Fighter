#!mainFile "fighter.opy"

#!define IMPULSE_AMOUNT 8

rule "Ultimate Ability - Shortened":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)

    eventPlayer.setUltCharge(100)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(1.5)
    eventPlayer.cancelPrimaryAction()
    wait(10)

rule "Moveable Ultimate":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isUsingUltimate()

    do:
        if eventPlayer.isHoldingButton(Button.JUMP) == true:
            eventPlayer.applyImpulse(Vector.UP, IMPULSE_AMOUNT, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.isHoldingButton(Button.CROUCH) == true:
            eventPlayer.applyImpulse(Vector.DOWN, IMPULSE_AMOUNT, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().z == 1:
            eventPlayer.applyImpulse(Vector.FORWARD, IMPULSE_AMOUNT, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().z == -1:
            eventPlayer.applyImpulse(Vector.BACKWARD, IMPULSE_AMOUNT, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().x == -1:
            eventPlayer.applyImpulse(Vector.RIGHT, IMPULSE_AMOUNT, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().x == 1:
            eventPlayer.applyImpulse(Vector.LEFT, IMPULSE_AMOUNT, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        wait()
    while RULE_CONDITION

rule "Crouch Descend":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isUsingUltimate() == false
    @Condition eventPlayer.isInAir()

    do:
        eventPlayer.applyImpulse(Vector.DOWN, IMPULSE_AMOUNT, Relativity.TO_PLAYER, Impulse.INCORPORATE_CONTRARY_MOTION)
        wait()
    while RULE_CONDITION