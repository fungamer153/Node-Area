# Node-Area
Determine if anything is inside of a specified area

# Usage
## void:IsWithin(Target:basePart, Folder:ObjectValue, MinRadius:integer, MinYPos:integer, Direction:string)
### Return value: `boolean`

```lua
--// Services
local SS = game:GetService('ServerScriptService')

--// Modules
local Area = require(SS:WaitForChild('Algebra'))

--// Events
while task.wait(.1) do
	local Target = workspace.Target
	local Within = Area:IsWithin(Target, workspace.Points, 350)

	for _, Beam in pairs(workspace.Points:GetDescendants()) do
		if Beam.ClassName == 'Beam' then
			if Within then
				Beam.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 229, 74)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 229, 74))
				}
			else
				Beam.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
				}
			end
		end
	end
end
```
