#!mainFile "fighter.opy"

#!define BEAM_DAMAGE 100
#!define beamDamage() damage([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if dotProduct(vectorTowards(eventPlayer, player), eventPlayer.getFacingDirection()) > 0 and dotProduct(vectorTowards(eventPlayer, player), eventPlayer.getFacingDirection()) <= 20 and magnitude(crossProduct( vectorTowards( eventPlayer, player), eventPlayer.getFacingDirection())) <= 1 and isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)], eventPlayer, 150)


playervar abilityFX

rule "--- [Echo] ---":
    @Delimiter
    @Disabled

rule "Large Beam Ability":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)

    createBeam(
        getAllPlayers(), 
        Beam.MOIRA_COALESCENCE, 
        updateEveryTick(eventPlayer.getEyePosition() - vect(0, 0.5, 0)), 
        updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 10), 
        Color.WHITE, 
        EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR
    )
    eventPlayer.abilityFX[0] = getLastCreatedEntity()
    createEffect(
        getAllPlayers(), 
        Effect.MOIRA_COALESCENCE_SOUND, 
        Color.WHITE, 
        eventPlayer.getPosition(), 
        100, 
        EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR
    )
    eventPlayer.abilityFX[1] = getLastCreatedEntity()
    
    beamDamage()
    wait(0.5)
    beamDamage()
    wait(0.5)
    beamDamage()
    
    destroyEffect(eventPlayer.abilityFX[0])
    destroyEffect(eventPlayer.abilityFX[1])
    wait(5)

        

    