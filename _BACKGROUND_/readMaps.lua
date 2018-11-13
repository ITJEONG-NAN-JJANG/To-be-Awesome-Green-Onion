local physics = require "physics"

local readMaps = {}

local drawingInfo = {}

local wall, floor = "_BACKGROUND_/2_1.png", "_BACKGROUND_/2_0.png"

local function drawing(content, i, j)
	drawingInfo[i][j] = display.newImage( content == 0 and floor or wall, 440 + 40*(j-1), content == 0 and 20 or 0 + 40*(i-1) )

	local physicsData = (require ("_BACKGROUND_.2_"..content) ).physicsData(1)

	physics.addBody( drawingInfo[i][j], physics:get("2_"..content))
end

function readMaps.readFile(stageNum)
	if stageNum < 1 or stageNum > 4 then
		print("Error : Invalid Stage")
		return
	end

	local path = system.pathForFile( "mapInfo" .. stageNum .. ".txt", system.DocumentsDirectory )

	local file, errorString = io.open( path, "r" )

	if not file then
		print( "Error : File Error " .. errorString )
		return
	end

	local content = 0

	for i = 1, 27, 1 do
		drawingInfo[i] = {}
		for j = 1, 27, 1 do
			content = file:read( "*n" )

			drawing( content, i, j )
			end
		end
	end
end

function readMaps.setLayer(character)
	local order = math.floor(character_y / 40)
end

return readMaps