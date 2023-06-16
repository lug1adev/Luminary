--[[
    ##:::::::'##::::'##:'##::::'##:'####:'##::: ##::::'###::::'########::'##:::'##:
    ##::::::: ##:::: ##: ###::'###:. ##:: ###:: ##:::'## ##::: ##.... ##:. ##:'##::
    ##::::::: ##:::: ##: ####'####:: ##:: ####: ##::'##:. ##:: ##:::: ##::. ####:::
    ##::::::: ##:::: ##: ## ### ##:: ##:: ## ## ##:'##:::. ##: ########::::. ##::::
    ##::::::: ##:::: ##: ##. #: ##:: ##:: ##. ####: #########: ##.. ##:::::: ##::::
    ##::::::: ##:::: ##: ##:.:: ##:: ##:: ##:. ###: ##.... ##: ##::. ##::::: ##::::
    ########:. #######:: ##:::: ##:'####: ##::. ##: ##:::: ##: ##:::. ##:::: ##::::
    ........:::.......:::..:::::..::....::..::::..::..:::::..::..:::::..:::::..::::

    written by lug1a#0001
]]

local services = setmetatable({}, {
    __index = function(_, service)
        return game:GetService(service)
    end,
})

local lib = {}

function tween(obj, info, properties, callback)
    local anim = services.TweenService:Create(obj, TweenInfo.new(unpack(info)), properties)
    anim:Play()

    if callback then
        anim.Completed:Connect(callback)
    end

    return anim
end

function dragify(object, hoverobj, speed, additionalObject)
    local start, objectPosition, dragging

	speed = speed or 0

	hoverobj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			start = input.Position
			objectPosition = object.Position
		end
	end)

	hoverobj.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	services.InputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
			tween(object, { speed }, {
				Position = UDim2.new(
					objectPosition.X.Scale,
					objectPosition.X.Offset + (input.Position - start).X,
					objectPosition.Y.Scale,
					objectPosition.Y.Offset + (input.Position - start).Y
				),
			})
			
            if additionalObject then
                tween(additionalObject, { speed + 0.0000001 }, {
                    Position = UDim2.new(
                        objectPosition.X.Scale,
                        objectPosition.X.Offset + (input.Position - start).X,
                        objectPosition.Y.Scale,
                        objectPosition.Y.Offset + (input.Position - start).Y
                    ),
                })
            end
		end
	end)
end

function randomName(length)
    local characters = "abcdefghijklmnopqrstuvwxyz1234567890"
	characters = string.split(characters, "")

	local randomString = ""

	for i = 1, length do
		local i = math.random(1, #characters)

		if not tonumber(characters[i]) then
			local uppercase = math.random(1, 2) == 2 and true or false
			randomString = randomString .. (uppercase and characters[i]:upper() or characters[i])
		else
			randomString = randomString .. characters[i]
		end
	end

	return randomString
end

function createObject(class, prop)
    local obj = Instance.new(class)

	for prop, v in next, prop do
		obj[prop] = v
	end

	pcall(function()
		obj.AutoButtonColor = false
	end)

	obj.Name = randomName(16)

	return obj
end

lib.tween = tween
lib.dragify = dragify
lib.random = randomName
lib.create = createObject

return lib