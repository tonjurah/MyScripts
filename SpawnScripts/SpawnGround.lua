
-- Function to spawn an enemy plane using MIST from a trigger zone and fly to a given point

-- Define the trigger zone name and the destination point coordinates
local triggerZoneName = "GroundPractice"
local destinationPoint = {
    x = -162538,  -- Replace with your desired X coordinate
    --y = 10000,  -- Replace with your desired Y coordinate
    y = 467634
}
local spawnGroup = SPAWN:NewWithAlias("Ground-1")
:InitLimit(10, 0) --Spawn

-- Define the name of the group to be replaced
local groupName = "Ground-1"


function spawnEnemyPlaneFromZone2(triggerZoneName, destinationPoint)
    -- Get the trigger zone details
    local zone = ZONE:New(triggerZoneName)
    trigger.action.outText("start", 5)
    if not zone then
        trigger.action.outText("Trigger zone not found!", 5)
        return
    end
    trigger.action.outText("GREYBE", 5)
    
    spawnGroup:SpawnFromVec2(destinationPoint)

    local group = spawnGroup:Spawn()
end


trigger.action.outText("start",1)

local status, err = pcall(spawnEnemyPlaneFromZone2,triggerZoneName, destinationPoint)

if status then
    -- no errors while running `foo'
    trigger.action.outText("ran to complete", 5)
else
    -- `foo' raised an error: take appropriate actions
    trigger.action.outText(err, 10)
end