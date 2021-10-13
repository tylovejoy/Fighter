#!mainFile "fighter.opy"

#!extension explosionSounds
#!extension energyExplosionEffects
#!extension kineticExplosionEffects

#!define GRAPPLE_DAMAGE 100

playervar grappleTarget

rule "--- [Doomfist] ---":
    @Delimiter

rule "[Doomfist] Grapple/RKO Ability":
    @Event eachPlayer
    @Hero doomfist
    @Condition isGameInProgress()
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)

    # Grapple closest enemy
    eventPlayer.grappleTarget = [x for x in getPlayersInRadius(eventPlayer.getPosition(), 2, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS) if x != eventPlayer][0]
    eventPlayer.grappleTarget.attachTo(eventPlayer, vectorTowards(eventPlayer, eventPlayer.grappleTarget))
    # Ground pound
    while eventPlayer.isInAir():
        eventPlayer.applyImpulse(vect(0, -1, 0), 1000, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
        wait()
    playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_METEOR_STRIKE_IMPACT_SOUND, Color.WHITE, eventPlayer.getPosition(), 10)
    playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_METEOR_STRIKE_IMPACT, Color.WHITE, eventPlayer.getPosition(), 10)
    damage(eventPlayer.grappleTarget, eventPlayer, GRAPPLE_DAMAGE)
    # Reset grapple target
    eventPlayer.grappleTarget = null

