
-- Function to spawn an enemy plane using MIST from a trigger zone and fly to a given point
function spawnEnemyPlaneFromZone(triggerZoneName, destinationPoint)
    -- Get the trigger zone details
    trigger.action.outText("test",10)
    local zone = ZONE:FindByName(triggerZoneName)
    
    if not zone then
        trigger.action.outText("Spaghett", 10)
        trigger.action.outText("Trigger zone not found!", 10)
        return
    end
    
    -- Define the spawn parameters
    local spawnGroup = {
        ["country"] = "Russia",   -- Country of the plane
        ["category"] = "plane",   -- Category (plane, helicopter, etc.)
        ["groupName"] = "Enemy Plane",  -- Name of the group
        ["units"] = {
            [1] = {
                ["type"] = "Su-25",   -- Type of the plane
                ["skill"] = "High",   -- Skill level of the pilot
                ["x"] = zone.point.x, -- X coordinate from the trigger zone
                ["y"] = zone.point.z, -- Y coordinate from the trigger zone
                ["heading"] = 0,      -- Initial heading (in radians)
                ["name"] = "EnemyPlane1",  -- Unit name
            },
        },
        ["route"] = {
            ["points"] = {
                [1] = {
                    ["action"] = "Turning Point",
                    ["x"] = zone.point.x,
                    ["y"] = zone.point.z,
                    ["alt"] = 2000,  -- Altitude in meters
                    ["speed"] = 250, -- Speed in meters per second
                },
                [2] = {
                    ["action"] = "Turning Point",
                    ["x"] = destinationPoint.x,
                    ["y"] = destinationPoint.y,
                    ["z"] = destinationPoint.y,
                    ["alt"] = 2000,  -- Altitude in meters
                    ["speed"] = 250, -- Speed in meters per second
                },
            },
        },
    }
    -- Use MIST to spawn the group
    mist.dynAdd(spawnGroup)
end


-- Define the trigger zone name and the destination point coordinates
local triggerZoneName = "WaterSpawnZone"
local destinationPoint = {
    x = -199000,  -- Replace with your desired X coordinate
    y = 10000,  -- Replace with your desired Y coordinate
    z = 402000
}
local spawnGroup = SPAWN:NewWithAlias("Red-1")
:InitLimit(10, 0) --Spawn
    

function spawnEnemyPlaneFromZone2(triggerZoneName, destinationPoint)
    -- Get the trigger zone details
    local zone = ZONE:New(triggerZoneName)
    trigger.action.outText("start", 10)
    if not zone then
        trigger.action.outText("Trigger zone not found!", 10)
        return
    end
    trigger.action.outText("good", 10)
    -- Define the spawn parameters
    --local spawnGroup = SPAWN:New("CAP")
    --    :InitHeading(0)
    --    :InitLimit(1, 0)
    --    :SpawnFromVec2(zone:GetVec2())

    spawnGroup:SpawnFromVec2(zone:GetVec2(), 2000, 4000)

    
    trigger.action.outText("grp made", 10)

    local group = spawnGroup:Spawn()

    trigger.action.outText("spawned?", 10)
    -- Define the destination waypoint
    local destinationVec2 = POINT_VEC2:New(destinationPoint.x, destinationPoint.z)
    -- trigger.action.outText(destinationVec2, 10)
    trigger.action.outText(destinationVec2["x"], 10)
    trigger.action.outText(destinationVec2["y"], 10)
    -- Set the route for the group to fly to the destination point
    group:RouteGroundTo(destinationVec2)

end


trigger.action.outText("start",1)
-- Call the function to spawn the enemy plane

local status, err = pcall(spawnEnemyPlaneFromZone2,triggerZoneName, destinationPoint)

if status then
    -- no errors while running `foo'
    trigger.action.outText("ran to complete", 10)
else
    -- `foo' raised an error: take appropriate actions
    trigger.action.outText(err, 10)
end