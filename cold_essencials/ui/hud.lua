loadstring(exports.dgs:dgsImportFunction())()
local screenW, screenH = guiGetScreenSize()

local mainWidth, mainHeight = 100, 400
local mainX, mainY = screenW - (mainWidth + 5), screenH - (mainHeight + 5)
local interBlack = dxCreateFont(":cold_assets/fonts/inter/interBlack.ttf", 20)

local show = true
local assets = exports.cold_assets

local elementsOnInterface = {
    [1] = {
        id = "health",
        outsideRadius = 0.4,
        insideRadius = 0.34,
        icon = ":cold_assets/images/hud/health.png",
        iconSize = {18, 18},
        color = tocolor(255, 255, 255),
        backgroundColor = tocolor(100, 100, 100, 155)
    },
    [2] = {
        id = "hunger",
        outsideRadius = 0.4,
        insideRadius = 0.34,
        icon = ":cold_assets/images/hud/hunger.png",
        iconSize = {18, 18},
        color = tocolor(255, 255, 255),
        backgroundColor = tocolor(100, 100, 100, 155)
    },
    [3] = {
        id = "thirst",
        outsideRadius = 0.4,
        insideRadius = 0.34,
        icon = ":cold_assets/images/hud/thirst.png",
        iconSize = {18, 18},
        color = tocolor(255, 255, 255),
        backgroundColor = tocolor(100, 100, 100, 155)
    },
    [4] = {
        id = "armour",
        outsideRadius = 0.4,
        insideRadius = 0.34,
        icon = ":cold_assets/images/hud/armour.png",
        iconSize = {18, 18},
        color = tocolor(255, 255, 255),
        backgroundColor = tocolor(100, 100, 100, 155)
    }
}

-- circle = {
--     mainX + (mainWidth - 60),
--     mainY + (mainHeight - 120),
--     50,
--     50
-- },

local function userInterface()
    for index, value in pairs(elementsOnInterface) do
        if value.id == "armour" then
            assets:circleHud( value.id, {
                circle = {
                    mainX + (mainWidth - 110),
                    mainY + (mainHeight - 60) - 1 * 50,
                    50,
                    50
                },
                exDatas = value
            })
        else
            assets:circleHud( value.id, {
                circle = {
                    mainX + (mainWidth - 60),
                    mainY + (mainHeight - 60) - index * 50,
                    50,
                    50
                },
                exDatas = value
            })
        end
    end
end

local alphaVehicle_155 = 0
local alphaVehicle = 0

function updateStats()
    local healthP = getElementHealth(localPlayer)
    local armourP = getPedArmor(localPlayer)
    local thirstP = getElementData(localPlayer, "cold:thirst") or 50
    local hungerP = getElementData(localPlayer, "cold:hunger") or 90
    assets:setValueCircle("health", healthP * (360 / 100))
    assets:setValueCircle("armour", armourP * (360 / 100))
    assets:setValueCircle("hunger", hungerP)
    assets:setValueCircle("thirst", thirstP)
    local RPM = 0
    local KMH = 0
    local fuel = 0
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if vehicle then
        if alphaVehicle < 255 then alphaVehicle = alphaVehicle + 10 end
        if alphaVehicle > 255 then alphaVehicle = 255 end
        if alphaVehicle_155 < 155 then if alphaVehicle_155 > 155 then alphaVehicle_155 = 155 end alphaVehicle_155 = alphaVehicle_155 + 10 end
        if alphaVehicle_155 > 155 then alphaVehicle_155 = 155 end
        RPM = getVehicleRPM(vehicle)
        KMH = math.floor(getElementSpeed(vehicle, "km/h"))
        fuel = getElementData(vehicle, "cold:fuel") or 15
    else
        if alphaVehicle ~= 0 then alphaVehicle = alphaVehicle - 10 end
        if alphaVehicle < 0 then alphaVehicle = 0 end
        if alphaVehicle_155 ~= 0 then alphaVehicle_155 = alphaVehicle_155 - 10 end
        if alphaVehicle_155 < 0 then alphaVehicle_155 = 0 end
        
    end

    dxDrawImageSection(mainX - (90), mainY + (mainHeight - 190), 78, 119, 0, 0, 78, 119, ":cold_assets/images/hud/speedbg.png", 0, 0, 0, tocolor(100, 100, 100, alphaVehicle_155))
    dxDrawImageSection(mainX - (90), mainY + (mainHeight - 70), 78, -(119 * (RPM / 9900)), 0, 0, 78, -(119 * (RPM / 9900)), ":cold_assets/images/hud/speed.png", 0, 0, 0, tocolor(255, 255, 255, alphaVehicle))
    if KMH > 10 then
        if KMH <= 99 then
            dxDrawText("#4242420#ffffff"..KMH, mainX - (60), mainY + (mainHeight - 140), 0, 0, tocolor(255, 255, 255, alphaVehicle), 1, interBlack, "left", "top", false, false, false, true)
        elseif KMH >= 100 then
            dxDrawText(KMH, mainX - (60), mainY + (mainHeight - 140), 0, 0, tocolor(255, 255, 255, alphaVehicle), 1, interBlack, "left", "top", false, false, false, true)
        end
    else
        dxDrawText("#42424200#ffffff"..KMH, mainX - (60), mainY + (mainHeight - 140), 0, 0, tocolor(255, 255, 255, alphaVehicle), 1, interBlack, "left", "top", false, false, false, true)
    end

    dxDrawImage(mainX - (130), mainY + (mainHeight - 115), 15, 15, ":cold_assets/images/hud/iconfuel.png", 0, 0, 0, tocolor(255, 255, 255, alphaVehicle))
    dxDrawImageSection(mainX - (150), mainY + (mainHeight - 140), 72, 73, 0, 0, 72, 73, ":cold_assets/images/hud/bgFuel.png", 0, 0, 0, tocolor(100, 100, 100, alphaVehicle_155))
    if fuel <= 15 then
        dxDrawImageSection(mainX - (150), mainY + (mainHeight - 70), 53, -(69 * fuel / 100), 0, 0, 53, -(69 * fuel / 100), ":cold_assets/images/hud/fuel.png", 0, 0, 0, tocolor(255, 0, 0, alphaVehicle))
    else
        dxDrawImageSection(mainX - (150), mainY + (mainHeight - 70), 53, -(69 * fuel / 100), 0, 0, 53, -(69 * fuel / 100), ":cold_assets/images/hud/fuel.png", 0, 0, 0, tocolor(255, 255, 255, alphaVehicle))
    end


end

function Initial()
    userInterface()
    addEventHandler("onClientRender", root, updateStats)
end
addEventHandler("onClientResourceStart", resourceRoot, Initial)

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function getVehicleRPM(vehicle)
    local vehicleRPM = 0
    if (vehicle) then
        if (getVehicleEngineState(vehicle) == true) then
            if getVehicleCurrentGear(vehicle) > 0 then
                vehicleRPM = math.floor(((getElementSpeed(vehicle, "km/h") / getVehicleCurrentGear(vehicle)) * 160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9000) then
                    vehicleRPM = math.random(9000, 9900)
                end
            else
                vehicleRPM = math.floor((getElementSpeed(vehicle, "km/h") * 160) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9000) then
                    vehicleRPM = math.random(9000, 9900)
                end
            end
        else
            vehicleRPM = 0
        end

        return tonumber(vehicleRPM)
    else
        return 0
    end
end