local ReplicatedStorage: ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage")) :: ReplicatedStorage
local UserInputService: UserInputService = cloneref(game:GetService("UserInputService")) :: UserInputService
local GuiService: GuiService = cloneref(game:GetService("GuiService")) :: GuiService

local Draw = require(Path.To.Draw)
local Types = require(Path.To.Types)

local FOV = {}
local FOVCircle = {}

FOVCircle.__index = FOVCircle

local GetMouseLocation: (UserInputService) -> Vector2 = UserInputService.GetMouseLocation
local GetGuiInset: (GuiService) -> (Vector2, Vector2) = GuiService.GetGuiInset

local Vector2New: (number, number) -> Vector2 = Vector2.new
local Color3FromRGB: (number, number, number) -> Color3 = Color3.fromRGB

local MathMax: (number, number) -> number = math.max
local MathClamp: (number, number, number) -> number = math.clamp
local TypeOf: (any) -> string = typeof

function FOV:New(Config: Types.Config?): Types.FOVCircle
    Config = Config or {} :: Types.Config

    local Color1: Color3 = Config.Color1 or Color3FromRGB(255, 255, 255) :: Color3
    local Color2: Color3 = Config.Color2 or Color1 :: Color3
    local FillColor1: Color3 = Config.FillColor1 or Color3FromRGB(255, 255, 255) :: Color3
    local FillColor2: Color3 = Config.FillColor2 or FillColor1 :: Color3

    local self: Types.FOVCircle = setmetatable({
        _Drawing = Draw.New() :: Types.Drawing,

        _Radius = Config.Radius or 100 :: number,

        _Color1 = Color1,
        _Color2 = Color2,

        _FillColor1 = FillColor1,
        _FillColor2 = FillColor2,

        _Transparency = Config.Transparency or 0 :: number,
        _FillTransparency = Config.FillTransparency or 1 :: number,

        _Thickness = Config.Thickness or 1 :: number,

        _FillRotation = Config.FillRotation or 0 :: number,
        _Rotation = Config.Rotation or 0 :: number,

        _Position = Config.Position or Vector2New(0, 0) :: Vector2,

        _Visible = Config.Visible or true :: boolean,
        _Independent = Config.Independent or true :: boolean,

        _InputConnection = nil :: RBXScriptConnection?,
        _Unloaded = false :: boolean,
    }, FOVCircle) :: Types.FOVCircle

    self:SetCircle("Radius" :: string, self._Radius)
    self:SetCircle("Color" :: string, self._Color1, self._Color2)
    self:SetCircle("FillColor" :: string, self._FillColor1, self._FillColor2)
    self:SetCircle("Transparency" :: string, self._Transparency)
    self:SetCircle("FillTransparency" :: string, self._FillTransparency)
    self:SetCircle("Thickness" :: string, self._Thickness)
    self:SetCircle("FillRotation" :: string, self._FillRotation)
    self:SetCircle("Rotation" :: string, self._Rotation)
    self:SetCircle("Position" :: string, self._Position)
    self:SetCircle("Visible" :: string, self._Visible)

    if self._Independent then
        self:_ConnectInput()
    end

    return self
end

function FOVCircle._UpdateMousePosition(self: Types.FOVCircle): ()
    local MousePosition: Vector2 = GetMouseLocation(UserInputService)
    local GuiInset: Vector2 = GetGuiInset(GuiService)

    self:SetPosition(
        Vector2New(
            MousePosition.X - GuiInset.X,
            MousePosition.Y - GuiInset.Y
        ) :: Vector2
    )
end

function FOVCircle._ConnectInput(self: Types.FOVCircle): ()
    if self._InputConnection then
        return
    end

    self:_UpdateMousePosition()

    self._InputConnection = UserInputService.InputChanged:Connect(
        function(Input: InputObject): ()
            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                self:_UpdateMousePosition()
            end
        end
    ) :: RBXScriptConnection
end

function FOVCircle._DisconnectInput(self: Types.FOVCircle): ()
    if not self._InputConnection then
        return
    end

    self._InputConnection:Disconnect()
    self._InputConnection = nil :: RBXScriptConnection?
end

function FOVCircle.SetCircle(
    self: Types.FOVCircle,
    Property: string,
    Value1: any,
    Value2: any?
): ()
    if self._Unloaded then
        return
    end

    local Method: any = FOVCircle["Set" .. Property]

    if TypeOf(Method) ~= "function" then
        return
    end

    Method(self, Value1, Value2)
end

function FOVCircle.SetRadius(self: Types.FOVCircle, Value: number): ()
    self._Radius = MathMax(Value, 0) :: number
    Draw.SetRadius(self._Drawing, self._Radius)
end

function FOVCircle.SetColor(
    self: Types.FOVCircle,
    Color1: Color3,
    Color2: Color3?
): ()
    self._Color1 = Color1 :: Color3
    self._Color2 = Color2 or Color1 :: Color3

    Draw.SetColor(
        self._Drawing,
        self._Color1,
        self._Color2
    )
end

function FOVCircle.SetFillColor(
    self: Types.FOVCircle,
    Color1: Color3,
    Color2: Color3?
): ()
    self._FillColor1 = Color1 :: Color3
    self._FillColor2 = Color2 or Color1 :: Color3

    Draw.SetFillColor(
        self._Drawing,
        self._FillColor1,
        self._FillColor2
    )
end

function FOVCircle.SetFillRotation(
    self: Types.FOVCircle,
    Rotation: number
): ()
    self._FillRotation = Rotation :: number
    Draw.SetFillRotation(self._Drawing, self._FillRotation)
end

function FOVCircle.SetFillTransparency(
    self: Types.FOVCircle,
    Transparency: number
): ()
    self._FillTransparency = MathClamp(Transparency, 0, 1) :: number
    Draw.SetFillTransparency(self._Drawing, self._FillTransparency)
end

function FOVCircle.SetRotation(
    self: Types.FOVCircle,
    Rotation: number
): ()
    self._Rotation = Rotation :: number
    Draw.SetRotation(self._Drawing, self._Rotation)
end

function FOVCircle.SetTransparency(
    self: Types.FOVCircle,
    Value: number
): ()
    self._Transparency = MathClamp(Value, 0, 1) :: number
    Draw.SetTransparency(self._Drawing, self._Transparency)
end

function FOVCircle.SetThickness(
    self: Types.FOVCircle,
    Value: number
): ()
    self._Thickness = MathMax(Value, 0) :: number
    Draw.SetThickness(self._Drawing, self._Thickness)
end

function FOVCircle.SetPosition(
    self: Types.FOVCircle,
    Value: Vector2
): ()
    self._Position = Value :: Vector2
    Draw.SetPosition(self._Drawing, self._Position)
end

function FOVCircle.SetVisible(
    self: Types.FOVCircle,
    Value: boolean
): ()
    self._Visible = Value :: boolean
    Draw.SetVisible(self._Drawing, self._Visible)
end

function FOVCircle.SetIndependent(
    self: Types.FOVCircle,
    Value: boolean
): ()
    if self._Independent == Value then
        return
    end

    self._Independent = Value :: boolean

    if Value then
        self:_ConnectInput()
    else
        self:_DisconnectInput()
    end
end

function FOVCircle.Unload(self: Types.FOVCircle): ()
    if self._Unloaded then
        return
    end

    self._Unloaded = true :: boolean

    self:_DisconnectInput()
    Draw.Destroy(self._Drawing)
end

return FOV
