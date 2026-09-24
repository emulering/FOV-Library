local ReplicatedStorage: ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage")) :: ReplicatedStorage
local Players: Players = cloneref(game:GetService("Players")) :: Players

local Types = require(Path.To.Types)

local Draw = {}

local InstanceNew: (string) -> Instance = Instance.new

local Vector2New: (number, number) -> Vector2 = Vector2.new
local UDimNew: (number, number) -> UDim = UDim.new
local UDim2New: (number, number, number, number) -> UDim2 = UDim2.new
local Color3FromRGB: (number, number, number) -> Color3 = Color3.fromRGB
local ColorSequenceNew: (Color3, Color3) -> ColorSequence = ColorSequence.new

function Draw.New(): Types.Drawing
    local Drawing: Types.Drawing = {} :: Types.Drawing

    Drawing._Gui = InstanceNew("ScreenGui") :: ScreenGui
    Drawing._Gui.Parent = gethui and gethui() or Players.LocalPlayer.PlayerGui :: Instance
    Drawing._Gui.Name = "FOVGui" :: string
    Drawing._Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling :: Enum.ZIndexBehavior

    Drawing._Circle = InstanceNew("Frame") :: Frame
    Drawing._Circle.BorderColor3 = Color3FromRGB(0, 0, 0) :: Color3
    Drawing._Circle.AnchorPoint = Vector2New(0.5, 0.5) :: Vector2
    Drawing._Circle.Parent = Drawing._Gui :: Instance
    Drawing._Circle.BackgroundTransparency = 1 :: number
    Drawing._Circle.Position = UDim2New(0.5, 0, 0.5, 0) :: UDim2
    Drawing._Circle.Name = "CircleFrame" :: string
    Drawing._Circle.Size = UDim2New(0, 100, 0, 100) :: UDim2
    Drawing._Circle.BorderSizePixel = 0 :: number
    Drawing._Circle.BackgroundColor3 = Color3FromRGB(255, 255, 255) :: Color3

    Drawing._Corner = InstanceNew("UICorner") :: UICorner
    Drawing._Corner.TopLeftRadius = UDimNew(1, 0) :: UDim
    Drawing._Corner.Name = "CircleCorner" :: string
    Drawing._Corner.TopRightRadius = UDimNew(1, 0) :: UDim
    Drawing._Corner.BottomRightRadius = UDimNew(1, 0) :: UDim
    Drawing._Corner.Parent = Drawing._Circle :: Instance
    Drawing._Corner.BottomLeftRadius = UDimNew(1, 0) :: UDim

    Drawing._Outline = InstanceNew("UIStroke") :: UIStroke
    Drawing._Outline.Thickness = 3 :: number
    Drawing._Outline.Parent = Drawing._Circle :: Instance
    Drawing._Outline.Name = "OutlineStroke" :: string
    Drawing._Outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border :: Enum.ApplyStrokeMode

    Drawing._Inline = InstanceNew("UIStroke") :: UIStroke
    Drawing._Inline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border :: Enum.ApplyStrokeMode
    Drawing._Inline.ZIndex = 2 :: number
    Drawing._Inline.BorderOffset = UDimNew(0, 1) :: UDim
    Drawing._Inline.Name = "InlineStroke" :: string
    Drawing._Inline.Color = Color3FromRGB(255, 255, 255) :: Color3
    Drawing._Inline.Parent = Drawing._Circle :: Instance

    Drawing._InlineGradient = InstanceNew("UIGradient") :: UIGradient
    Drawing._InlineGradient.Name = "InlineGradient" :: string
    Drawing._InlineGradient.Parent = Drawing._Inline :: Instance

    Drawing._FillGradient = InstanceNew("UIGradient") :: UIGradient
    Drawing._FillGradient.Name = "FillGradient" :: string
    Drawing._FillGradient.Parent = Drawing._Circle :: Instance

    return Drawing
end

function Draw.SetRadius(
    Drawing: Types.Drawing,
    Radius: number
): ()
    Drawing._Circle.Size = UDim2New(
        0,
        Radius * 2,
        0,
        Radius * 2
    ) :: UDim2
end

function Draw.SetColor(
    Drawing: Types.Drawing,
    Color1: Color3,
    Color2: Color3?
): ()
    Drawing._InlineGradient.Color = ColorSequenceNew(
        Color1,
        Color2 or Color1
    ) :: ColorSequence
end

function Draw.SetFillColor(
    Drawing: Types.Drawing,
    Color1: Color3,
    Color2: Color3?
): ()
    Drawing._FillGradient.Color = ColorSequenceNew(
        Color1,
        Color2 or Color1
    ) :: ColorSequence
end

function Draw.SetFillRotation(
    Drawing: Types.Drawing,
    Rotation: number
): ()
    Drawing._FillGradient.Rotation = Rotation :: number
end

function Draw.SetFillTransparency(
    Drawing: Types.Drawing,
    Transparency: number
): ()
    Drawing._Circle.BackgroundTransparency = Transparency :: number
end

function Draw.SetRotation(
    Drawing: Types.Drawing,
    Rotation: number
): ()
    Drawing._InlineGradient.Rotation = Rotation :: number
end

function Draw.SetTransparency(
    Drawing: Types.Drawing,
    Transparency: number
): ()
    Drawing._Circle.BackgroundTransparency = Transparency :: number
    Drawing._Outline.Transparency = Transparency :: number
    Drawing._Inline.Transparency = Transparency :: number
end

function Draw.SetThickness(
    Drawing: Types.Drawing,
    Thickness: number
): ()
    Drawing._Inline.Thickness = Thickness :: number
    Drawing._Outline.Thickness = Thickness + 2 :: number
end

function Draw.SetPosition(
    Drawing: Types.Drawing,
    Position: Vector2
): ()
    Drawing._Circle.Position = UDim2New(
        0,
        Position.X,
        0,
        Position.Y
    ) :: UDim2
end

function Draw.SetVisible(
    Drawing: Types.Drawing,
    Visible: boolean
): ()
    Drawing._Gui.Enabled = Visible :: boolean
end

function Draw.Destroy(Drawing: Types.Drawing): ()
    Drawing._Gui:Destroy()
end

return Draw
