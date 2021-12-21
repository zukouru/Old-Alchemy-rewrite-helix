
ITEM.name = "Receta cura de forunculos"
ITEM.description = 'Receta para la cura de forunculos'
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

	self:SetData("label", "Cura para forunculos")
    local rng = math.random(0, 100)
    if (rng > 30) then
        ingredients["Colmillos de serpientes"] = 10
        ingredients["Babosa cornuda"] = 4
        ingredients["Puas de puercoespin"] = 2
        data["name"] = "boilCure1"
    else
        ingredients["Colmillos de serpientes"] = 1
        ingredients["Babosa cornuda"] = 1
        ingredients["Puas de puercoespin"] = 1
        ingredients["Cebolla maloliente"] = 1
        ingredients["Hoja de ortiga"] = 1
        ingredients["Mucosidad de gusarajo"] = 1
        ingredients["Gengibre"] = 1
        ingredients["Espinas de shrake"] = 1
        data["name"] = "boilCure2"
    end

    data["label"] = "Receta cura para forunculos"
    data["type"] = "Receta"
    data["ingredients"] = ingredients

    self:SetData("recipe", data)
end
