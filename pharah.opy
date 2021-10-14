#!mainFile "fighter.opy"

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
            eventPlayer.applyImpulse(Vector.UP, 8, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.isHoldingButton(Button.CROUCH) == true:
            eventPlayer.applyImpulse(Vector.DOWN, 8, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().z == 1:
            eventPlayer.applyImpulse(Vector.FORWARD, 8, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().z == -1:
            eventPlayer.applyImpulse(Vector.BACKWARD, 8, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().x == -1:
            eventPlayer.applyImpulse(Vector.RIGHT, 8, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().x == 1:
            eventPlayer.applyImpulse(Vector.LEFT, 8, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        wait()
    while RULE_CONDITION