
ITEM.name = "Receta de pocion pompion"
ITEM.description = 'Una receta para una pocion pompion'
ITEM.model = Model("models/items/magic/scrolls/scroll_l01_open.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
    pos = Vector(0, 0, 60),
    ang = Angle(90, 0, 0),
    fov = 25
}

function ITEM:OnInstanced()
    local ingredients = {}
    local data = {}
    ingredients["Mariposa revoloteadora"] = 1
    ingredients["Dedalera"] = 1
    ingredients["Bulbo rebotador"] = 1


    data["label"] = "Receta pocion pompion"
    data["name"] = "pompion"
    data["type"] = "Receta"
    data["ingredients"] = ingredients
    self:SetData("recipe", data)
end
