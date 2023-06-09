--// Initialization
local Module = {}
Module.__index = Module

--// Functions
local function AnglesBetween(vectorA: Vector3, vectorB: Vector3): number
	return math.atan2(vectorA:Cross(vectorB).Magnitude, vectorA:Dot(vectorB))
end

local function AngleBetweenSigned(vectorA: Vector3, vectorB: Vector3, axisVector: Vector3): number
	local angle = AnglesBetween(vectorA, vectorB)
	return angle * math.sign(axisVector:Dot(vectorA:Cross(vectorB)))
end

local function IsWithinPath(point, points, MinAngle, MinYPos, Direction): boolean
	local AngleTotal = 0

	for i = 1, #points do
		local p1 = points[i - 1] or points[#points]
		local p2 = points[i]
		local p1Dir = (p1.Position - point).Unit
		local p2Dir = (p2.Position - point).Unit
		local Angle = AnglesBetween(p1Dir, p2Dir, Vector3.new(0, 1, 0))
		AngleTotal += Angle
	end

	AngleTotal = math.floor((math.deg(AngleTotal) + 0.5))
		
	if Direction == "Up" then
		if point.Y >= MinYPos then
			return AngleTotal >= MinAngle
		end
	elseif Direction == "Down" then
		if point.Y <= MinYPos then
			return AngleTotal >= MinAngle
		end
	else
		return AngleTotal >= MinAngle
	end
end

--// Methods
function Module:IsWithin(Part, Folder, MinAngle, MinYPos, Direction)
	local Table = {}
		
	for _, Node in pairs(Folder:GetChildren()) do
		table.insert(Table, Node)
	end
	
	table.sort(Table,
		function(a,b)
			if a and b then
				return tonumber(a.Name) < tonumber(b.Name)
			end
		end)
	
	return IsWithinPath(Part.Position, Table, MinAngle, MinYPos, Direction)
end

--// Return
return Module
