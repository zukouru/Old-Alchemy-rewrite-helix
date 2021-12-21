
ITEM.name = "Receta antidoto venenos comunes"
ITEM.description = 'La receta diria "10 colmillos de serpiente, 4 babosas cornudas y 2 puas de puercoespin"'
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
    ingredients["Bezoar"] = 4
    ingredients["Ingrediente estandar"] = 2
    ingredients["Bayas de muerdago"] = 2
    ingredients["Cuerno de unicornio"] = 1

    local data = {}
    data["label"] = "Receta antidoto para venenos comunes"
    data["name"] = "antidoteCommonPoison"
    data["type"] = "Receta"
    data["ingredients"] = ingredients


    self:SetData("recipe", data)
end

