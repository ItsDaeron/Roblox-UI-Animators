--!!! ONLY USE THIS SCRIPT IF YOUR UI STROKED USE FIXEDSIZE AND NOT SCALEDSIZE AS STROKESIZINGMETHOD IN TEH PROPERTIES !!!

-->> Services
local _Workspace = game:GetService("Workspace")

-->> Variables
local defaultSize = Vector2.new(1920, 1080) -- set this to the screen resolution at which the UI was designed to work on the script will fix the UI strokes when the resolution changes
local lastSize = nil

-->> Functions
local function average(vector2)
	return (vector2.X + vector2.Y) / 2
end

local function ChangeUIStrokeThickness()
	local average = average(lastSize)/average(defaultSize)
	for _, stroke in pairs(script.Parent.Parent:GetDescendants()) do
		if stroke:IsA("UIStroke") then
			if not stroke:GetAttribute("StrokeThickness") then
				stroke:SetAttribute("StrokeThickness", stroke.Thickness)
			end
			stroke.Thickness = stroke:GetAttribute("StrokeThickness") * average
		end
	end
end

-->> Script
lastSize = _Workspace.Camera.ViewportSize
ChangeUIStrokeThickness()

_Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	lastSize = _Workspace.Camera.ViewportSize
	ChangeUIStrokeThickness()
end)
