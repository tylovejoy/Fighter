#!include "doomfist.opy"
#!include "echo.opy"
#!include "lucio.opy"
#!include "hud.opy"
#!include "pharah.opy"
#!include "reinhardt.opy"

#!extension beamEffects
#!extension explosionSounds
#!extension kineticExplosionEffects
#!extension beamSounds

settings "settings.opy.json"

globalvar TimeRemaining 

playervar eye_pos_temp
playervar ThirdPersonCamVars

rule "--- Gamemode ---":
    @Delimiter
    @Disabled

rule "Match Time":
    wait(1)
    setMatchTime(1)
    wait(5)
    setMatchTime(9999)
    wait(1)
    pauseMatchTime()

rule "Spawn Dummy Bots TESTING":
    @Event eachPlayer
    @Condition eventPlayer.isCommunicatingSpray() == true
    
    createDummy(Hero.WIDOWMAKER, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
            
rule "3DCam | By DarkShadow#24346":
    @Event eachPlayer
    
    eventPlayer.ThirdPersonCamVars[8] = eventPlayer.getHealth()
    eventPlayer.ThirdPersonCamVars[9] = createWorkshopSetting(bool, "3D cam | DarkShadow#24346", "Damage Feedback", true, 0)
    eventPlayer.ThirdPersonCamVars[5] = createWorkshopSetting(float[-5:5], "3D cam | DarkShadow#24346", "Camera position [X axis]", 0, 0)
    eventPlayer.ThirdPersonCamVars[6] = createWorkshopSetting(float[-1:20], "3D cam | DarkShadow#24346", "Camera position [Y axis]", 3, 0)
    eventPlayer.ThirdPersonCamVars[7] = createWorkshopSetting(float[-50:-0.1], "3D cam | DarkShadow#24346", "Camera position [Z axis]", -3, 0)
    #i-0 = Cam_Activated | i-1 = Ability1 | i-2 = Crouch | i-3 = SeconderyFire | i-4 = Ult
    while true:
        #toggle cam
        if eventPlayer.isHoldingButton(Button.INTERACT) == true:
            if eventPlayer.ThirdPersonCamVars[0] == true:
                eventPlayer.ThirdPersonCamVars[0] = false
                eventPlayer.startCamera(eventPlayer.eye_pos_temp, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()), 0)
                chase(eventPlayer.eye_pos_temp, eventPlayer.getEyePosition(), duration=1, ChaseReeval.DESTINATION_AND_DURATION)
                wait(1)
                eventPlayer.stopCamera()
                eventPlayer.disallowButton(Button.INTERACT)
                wait(0.25)
                eventPlayer.allowButton(Button.INTERACT)
            elif eventPlayer.ThirdPersonCamVars[0] != true:
                eventPlayer.ThirdPersonCamVars[0] = true
                eventPlayer.eye_pos_temp = eventPlayer.getEyePosition()
                chase(eventPlayer.eye_pos_temp, raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition(), duration=1, ChaseReeval.DESTINATION_AND_DURATION)
                eventPlayer.startCamera(eventPlayer.eye_pos_temp, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()), 0)
                wait(1)
                eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()), updateEveryTick(raycast(updateEveryTick(eventPlayer.getEyePosition()), updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000), getAllPlayers(), eventPlayer, true).getHitPosition()), 25)
                eventPlayer.disallowButton(Button.INTERACT)
                wait(0.25)
                eventPlayer.allowButton(Button.INTERACT)
        if eventPlayer.ThirdPersonCamVars[0] == true:
            if (eventPlayer.getCurrentHero() == Hero.SOLDIER or eventPlayer.getCurrentHero() == Hero.REAPER) and eventPlayer.isUsingAbility1() == true:
                eventPlayer.ThirdPersonCamVars[1] = true
                eventPlayer.eye_pos_temp = raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()
                chase(eventPlayer.eye_pos_temp, raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6] + 1, eventPlayer.ThirdPersonCamVars[7] + -3), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition(), duration=2, ChaseReeval.DESTINATION_AND_DURATION)
                eventPlayer.startCamera(eventPlayer.eye_pos_temp, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()), 0)
                eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6] + 1, eventPlayer.ThirdPersonCamVars[7] + -3), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()), updateEveryTick(raycast(updateEveryTick(eventPlayer.getEyePosition()), updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000), getAllPlayers(), eventPlayer, true).getHitPosition()), 25)
            elif (not eventPlayer.isUsingAbility1()) == true:
                if eventPlayer.ThirdPersonCamVars[1] == true:
                    eventPlayer.ThirdPersonCamVars[1] = false
                    chase(eventPlayer.eye_pos_temp, raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition(), duration=1, ChaseReeval.DESTINATION_AND_DURATION)
                    eventPlayer.startCamera(eventPlayer.eye_pos_temp, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()), 0)
                    eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()), updateEveryTick(raycast(updateEveryTick(eventPlayer.getEyePosition()), updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000), getAllPlayers(), eventPlayer, true).getHitPosition()), 25)
            if eventPlayer.isCrouching() == true:
                eventPlayer.ThirdPersonCamVars[2] = true
                chase(eventPlayer.eye_pos_temp, raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6] - 1, eventPlayer.ThirdPersonCamVars[7] - -1), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition(), duration=2, ChaseReeval.DESTINATION_AND_DURATION)
                eventPlayer.startCamera(eventPlayer.eye_pos_temp, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()), 0)
                eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6] - 1, eventPlayer.ThirdPersonCamVars[7] - -1), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()), updateEveryTick(raycast(updateEveryTick(eventPlayer.getEyePosition()), updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000), getAllPlayers(), eventPlayer, true).getHitPosition()), 25)
            elif (not eventPlayer.isCrouching()) == true:
                if eventPlayer.ThirdPersonCamVars[2] == true:
                    eventPlayer.ThirdPersonCamVars[2] = false
                    chase(eventPlayer.eye_pos_temp, raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition(), duration=1, ChaseReeval.DESTINATION_AND_DURATION)
                    eventPlayer.startCamera(eventPlayer.eye_pos_temp, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()), 0)
                    eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()), updateEveryTick(raycast(updateEveryTick(eventPlayer.getEyePosition()), updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000), getAllPlayers(), eventPlayer, true).getHitPosition()), 25)
            if (eventPlayer.getCurrentHero() == Hero.ANA or eventPlayer.getCurrentHero() == Hero.WIDOWMAKER) and eventPlayer.isFiringSecondaryFire() == true:
                eventPlayer.ThirdPersonCamVars[3] = true
                eventPlayer.stopCamera()
            else:
                if eventPlayer.ThirdPersonCamVars[3] == true:
                    eventPlayer.ThirdPersonCamVars[3] = false
                    eventPlayer.ThirdPersonCamVars[0] = false
                    eventPlayer.ThirdPersonCamVars[0] = true
                    eventPlayer.eye_pos_temp = eventPlayer.getEyePosition()
                    chase(eventPlayer.eye_pos_temp, raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition(), duration=1, ChaseReeval.DESTINATION_AND_DURATION)
                    eventPlayer.startCamera(eventPlayer.eye_pos_temp, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()), 0)
                    wait(1)
                    eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()), updateEveryTick(raycast(updateEveryTick(eventPlayer.getEyePosition()), updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000), getAllPlayers(), eventPlayer, true).getHitPosition()), 25)
            if (eventPlayer.getCurrentHero() == Hero.DOOMFIST or eventPlayer.getCurrentHero() == Hero.JUNKRAT) and eventPlayer.isUsingUltimate() == true:
                eventPlayer.ThirdPersonCamVars[4] = true
                eventPlayer.stopCamera()
            else:
                if eventPlayer.ThirdPersonCamVars[4] == true:
                    eventPlayer.ThirdPersonCamVars[4] = false
                    eventPlayer.ThirdPersonCamVars[0] = false
                    eventPlayer.ThirdPersonCamVars[0] = true
                    eventPlayer.eye_pos_temp = eventPlayer.getEyePosition()
                    chase(eventPlayer.eye_pos_temp, raycast(eventPlayer.getEyePosition(), worldVector(vect(0, eventPlayer.eye_pos_temp, eventPlayer.ThirdPersonCamVars[3]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition(), duration=1, ChaseReeval.DESTINATION_AND_DURATION)
                    eventPlayer.startCamera(eventPlayer.eye_pos_temp, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()), 0)
                    wait(1)
                    eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()), updateEveryTick(raycast(updateEveryTick(eventPlayer.getEyePosition()), updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000), getAllPlayers(), eventPlayer, true).getHitPosition()), 25)
        if eventPlayer.ThirdPersonCamVars[9] == true:
            if eventPlayer.getHealth() < eventPlayer.ThirdPersonCamVars[8]:
                eventPlayer.ThirdPersonCamVars[8] = eventPlayer.getHealth()
                eventPlayer.eye_pos_temp = raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()
                chase(eventPlayer.eye_pos_temp, raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6] + 1, eventPlayer.ThirdPersonCamVars[7] + -1), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition(), duration=1, ChaseReeval.DESTINATION_AND_DURATION)
                eventPlayer.startCamera(eventPlayer.eye_pos_temp, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()), 0)
                eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6] + 1, eventPlayer.ThirdPersonCamVars[7] + -1), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()), updateEveryTick(raycast(updateEveryTick(eventPlayer.getEyePosition()), updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000), getAllPlayers(), eventPlayer, true).getHitPosition()), 25)
                chase(eventPlayer.eye_pos_temp, raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition(), duration=1, ChaseReeval.DESTINATION_AND_DURATION)
                wait(0.2)
                eventPlayer.startCamera(eventPlayer.eye_pos_temp, updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 100, getAllPlayers(), eventPlayer, true).getHitPosition()), 0)
                eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), worldVector(vect(eventPlayer.ThirdPersonCamVars[5], eventPlayer.ThirdPersonCamVars[6], eventPlayer.ThirdPersonCamVars[7]), eventPlayer, Transform.ROTATION_AND_TRANSLATION), getAllPlayers(), eventPlayer, true).getHitPosition()), updateEveryTick(raycast(updateEveryTick(eventPlayer.getEyePosition()), updateEveryTick(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000), getAllPlayers(), eventPlayer, true).getHitPosition()), 25)
        if eventPlayer.getHealth() > eventPlayer.ThirdPersonCamVars[8]:
            eventPlayer.ThirdPersonCamVars[8] = eventPlayer.getHealth()
        wait(0.25)


