#!mainFile "fighter.opy"

#!define GRAPPLE_DAMAGE 100

playervar grappleTarget
playervar doomFX

rule "--- [Doomfist] ---":
    @Delimiter
    @Disabled

# rule "Grapple/RKO Ability":
#     @Event eachPlayer
#     @Hero doomfist
#     @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
#     @Condition eventPlayer.isInAir()
#     @Condition distance(eventPlayer.getPosition(), nearestWalkablePosition(eventPlayer.getPosition())) > 3

#     # Check for grapple target on crosshair is in range
#     if eventPlayer.getPlayerClosestToReticle(Team.ALL) in getPlayersInRadius(eventPlayer.getPosition(), 3, Team.ALL, LosCheck.SURFACES_AND_ENEMY_BARRIERS).exclude(eventPlayer):
#         eventPlayer.grappleTarget = eventPlayer.getPlayerClosestToReticle(Team.ALL) 
#     else:
#         return

#     # Grapple closest enemy if near crosshair
#     eventPlayer.grappleTarget.attachTo(eventPlayer, vectorTowards(eventPlayer, eventPlayer.grappleTarget))
    
#     # Stun grapple target
#     eventPlayer.grappleTarget.setStatusEffect(eventPlayer, Status.STUNNED, 9999)

#     # Ground pound
#     while eventPlayer.isInAir():
#         eventPlayer.applyImpulse(Vector.DOWN, 1000, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
#         wait()
    
#     playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_METEOR_STRIKE_IMPACT_SOUND, Color.WHITE, eventPlayer.getPosition(), 100)
#     playEffect(getAllPlayers(), DynamicEffect.DOOMFIST_METEOR_STRIKE_IMPACT, Color.WHITE, eventPlayer.getPosition(), 100)

#     # Damage more the higher up you are
#     damage(eventPlayer.grappleTarget, eventPlayer, GRAPPLE_DAMAGE * distance(eventPlayer.getPosition(), nearestWalkablePosition(eventPlayer.getPosition())))
#     eventPlayer.grappleTarget.detach()
#     wait(1)
    
#     # Reset grapple target
#     eventPlayer.grappleTarget.clearStatusEffect(Status.STUNNED)
    
#     eventPlayer.grappleTarget = null
#     wait(5)

rule "Slam Replacement":
    @Event eachPlayer
    @Hero doomfist
    createEffect(getAllPlayers(), Effect.GOOD_AURA, Color.RED, eventPlayer.getPosition(), 50, EffectReeval.POSITION_AND_RADIUS)
    eventPlayer.doomFX[0] = getLastCreatedEntity()
    eventPlayer.setStatusEffect(null, Status.BURNING, 7)
    eventPlayer.setMoveSpeed(250)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 2)
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 1)
    wait(10)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 6)
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 4)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.clearStatusEffect(Status.BURNING)
    destroyEffect(eventPlayer.doomFX)