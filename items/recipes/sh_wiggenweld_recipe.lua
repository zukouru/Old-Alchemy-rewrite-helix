
ITEM.name = "Receta pocion herbovitalizante"
ITEM.description = 'Receta para la pocion herbovitalizante'
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
    ingredients["Sangre de salamandra"] = 5
    ingredients["Espinas de pez leon"] = 2
    ingredients["Mandragora cocida"] = 3
    ingredients["Aguamiel"] = 1
    ingredients["Mucosidad de gusarajo"] = 1

    data["label"] = "Receta pocion herbovitalizante"
    data["type"] = "Receta"
    data["name"] = "wiggenweld"
    data["ingredients"] = ingredients
    self:SetData("recipe", data)
end
