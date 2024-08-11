--Put this script in a part in Workspace that's sized in 16:9 ratio

local HttpService = game:GetService("HttpService")
local Part = script.Parent
local SurfaceGui = Instance.new("SurfaceGui", Part)
SurfaceGui.Face = Enum.NormalId.Front
SurfaceGui.CanvasSize = Vector2.new(128, 72)
SurfaceGui.Adornee = Part

local Pixels = {}

for Y = 0, 71 do
	for X = 0, 127 do 
		local Pixel = Instance.new("Frame")
		Pixel.Size = UDim2.new(0, 1, 0, 1)
		Pixel.Position = UDim2.new(0, X, 0, Y)
		Pixel.BorderSizePixel = 0
		Pixel.BackgroundColor3 = Color3.new(0, 0, 0)
		Pixel.Parent = SurfaceGui
		Pixels[X + Y * 128 + 1] = Pixel
	end
end

local function Update(Colors)
	for _, PixelData in pairs(Colors) do
		local X = PixelData.x
		local Y = PixelData.y
		local Color = PixelData.color

		local R = tonumber(Color:sub(2, 3), 16) / 255
		local G = tonumber(Color:sub(4, 5), 16) / 255
		local B = tonumber(Color:sub(6, 7), 16) / 255

		local PixelIndex = X + Y * 128 + 1
		local PixelFrame = Pixels[PixelIndex]

		if PixelFrame then
			PixelFrame.BackgroundColor3 = Color3.new(R, G, B)
		end
	end
end

local function Fetch()
	local Response = HttpService:GetAsync("https://wernisch.xyz/api/fetch.php")
	local Data = HttpService:JSONDecode(Response)
	if Data and Data.pixels then
		Update(Data.pixels)
	end
end

while true do
	Fetch()
	task.wait(0.15)
end
