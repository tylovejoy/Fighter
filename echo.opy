#!mainFile "fighter.opy"

#!extension beamEffects
#!extension beamSounds
#!extension explosionSounds
#!extension energyExplosionEffects
#!extension kineticExplosionEffects

#!define BEAM_DAMAGE 100

rule "--- [Echo] ---":
    @Delimiter

rule "[Echo] Large Beam Ability":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)

    createBeam(
        getAllPlayers(), 
        Beam.MOIRA_COALESCENCE, 
        updateEveryTick(eventPlayer.getEyePosition()), 
        updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 10), 
        Color.WHITE, 
        EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR
    )
    damage(
        raycast(
            updateEveryTick(eventPlayer.getEyePosition()), 
            updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 10), 
            getAllPlayers(), 
            eventPlayer, 
            true
        ).getPlayerHit(), 
        eventPlayer, 
        BEAM_DAMAGE
    )

    