#!mainFile "fighter.opy"

#!define GRAPPLE_DAMAGE 100

playervar grappleTarget

rule "--- [Doomfist] ---":
    @Delimiter
    @Disabled

rule "Grapple/RKO Ability":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.isInAir()

    if event.getPlayerClosestToReticle(Team.ALL) in getPlayersInRadius(eventPlayer.getPosition(), 3, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS):
        eventPlayer.grappleTarget = eventPlayer.getPlayerClosestToReticle(Team.ALL) 
        eventPlayer.grappleTarget.attachTo(eventPlayer, vectorTowards(eventPlayer, eventPlayer.grappleTarget))
        # Ground pound
        while eventPlayer.isInAir():
            eventPlayer.applyImpulse(vect(0, -1, 0), 1000, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
            wait()
        playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_METEOR_STRIKE_IMPACT_SOUND, Color.WHITE, eventPlayer.getPosition(), 100)
        playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_METEOR_STRIKE_IMPACT, Color.WHITE, eventPlayer.getPosition(), 100)
        # Damage more the higher up you are
        damage(eventPlayer.grappleTarget, eventPlayer, GRAPPLE_DAMAGE * distance(eventPlayer.getPosition(), nearestWalkablePosition(eventPlayer.getPosition())))
        eventPlayer.grappleTarget.detach()
        # Reset grapple target
        eventPlayer.grappleTarget = null
        wait(6)