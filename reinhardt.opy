#!mainFile "fighter.opy"

playervar facingDirection

rule "Spinning hammer":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)

    eventPlayer.facingDirection = evalOnce(eventPlayer.getFacingDirection())
    eventPlayer.startCamera(eventPlayer.getEyePosition(), eventPlayer.getEyePosition(), 0)
    eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + Vector.UP * 5 + evalOnce(normalize(eventPlayer.getFacingDirection() * vect(1, 0, 1)) * -5), getAllPlayers(), eventPlayer, true).getHitPosition()), updateEveryTick(eventPlayer.getEyePosition()), 0)
    eventPlayer.startTransformingThrottle(1, 1, eventPlayer.facingDirection)
    eventPlayer.setMoveSpeed(0)
    eventPlayer.startFacing(Vector.LEFT, 10000, Relativity.TO_PLAYER, FacingReeval.DIRECTION_AND_TURN_RATE)
    
    
    while eventPlayer.isHoldingButton(Button.ABILITY_1):  
        if eventPlayer.isHoldingButton(Button.JUMP) == true:
            eventPlayer.applyImpulse(Vector.UP, IMPULSE_AMOUNT, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.isHoldingButton(Button.CROUCH) == true:
            eventPlayer.applyImpulse(Vector.DOWN, IMPULSE_AMOUNT, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().z == 1:
            eventPlayer.applyImpulse(Vector.FORWARD, IMPULSE_AMOUNT, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().z == -1:
            eventPlayer.applyImpulse(Vector.BACKWARD, IMPULSE_AMOUNT, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().x == -1:
            eventPlayer.applyImpulse(Vector.RIGHT, IMPULSE_AMOUNT, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        if eventPlayer.getThrottle().x == 1:
            eventPlayer.applyImpulse(Vector.LEFT, IMPULSE_AMOUNT, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        wait()

    eventPlayer.stopFacing()
    eventPlayer.stopCamera()
    eventPlayer.setMoveSpeed(100)
    eventPlayer.stopTransformingThrottle()


rule "Burst Firestrike":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
        wait(0.50)
        eventPlayer.cancelPrimaryAction()
        wait()            
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
        wait()
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        wait(0.50)
        eventPlayer.cancelPrimaryAction()
        wait()
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
        wait()
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        wait(0.50)
        eventPlayer.cancelPrimaryAction()
        wait()
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 6)
        wait(6)

rule "Burning Firestrike":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ABILITY_2
    victim.setStatusEffect(attacker, Status.BURNING, 4)
