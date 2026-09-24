export type Drawing = {
    _Gui: ScreenGui,
    _Circle: Frame,
    _Corner: UICorner,
    _Outline: UIStroke,
    _Inline: UIStroke,
    _InlineGradient: UIGradient,
    _FillGradient: UIGradient,
}

export type Config = {
    Radius: number?,

    Color1: Color3?,
    Color2: Color3?,

    FillColor1: Color3?,
    FillColor2: Color3?,

    Transparency: number?,
    FillTransparency: number?,

    Thickness: number?,

    FillRotation: number?,
    Rotation: number?,

    Position: Vector2?,

    Visible: boolean?,
    Independent: boolean?,
}

export type FOVCircle = {
    _Drawing: Drawing,

    _Radius: number,

    _Color1: Color3,
    _Color2: Color3,

    _FillColor1: Color3,
    _FillColor2: Color3,

    _Transparency: number,
    _FillTransparency: number,

    _Thickness: number,

    _FillRotation: number,
    _Rotation: number,

    _Position: Vector2,

    _Visible: boolean,
    _Independent: boolean,

    _InputConnection: RBXScriptConnection?,
    _Unloaded: boolean,

    SetCircle: (
        self: FOVCircle,
        Property: string,
        Value1: any,
        Value2: any?
    ) -> (),

    SetRadius: (self: FOVCircle, Value: number) -> (),

    SetColor: (
        self: FOVCircle,
        Color1: Color3,
        Color2: Color3?
    ) -> (),

    SetFillColor: (
        self: FOVCircle,
        Color1: Color3,
        Color2: Color3?
    ) -> (),

    SetFillRotation: (
        self: FOVCircle,
        Rotation: number
    ) -> (),

    SetFillTransparency: (
        self: FOVCircle,
        Transparency: number
    ) -> (),

    SetRotation: (
        self: FOVCircle,
        Rotation: number
    ) -> (),

    SetTransparency: (
        self: FOVCircle,
        Value: number
    ) -> (),

    SetThickness: (
        self: FOVCircle,
        Value: number
    ) -> (),

    SetPosition: (
        self: FOVCircle,
        Value: Vector2
    ) -> (),

    SetVisible: (
        self: FOVCircle,
        Value: boolean
    ) -> (),

    SetIndependent: (
        self: FOVCircle,
        Value: boolean
    ) -> (),

    Unload: (self: FOVCircle) -> (),
}

return {}
