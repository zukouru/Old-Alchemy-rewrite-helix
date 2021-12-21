
ITEM.name = "Antidoto para venenos comunes"
ITEM.description = "Es un antidoto para los venenos comunes"
ITEM.model = Model("models/sbs/hogsmeade/hm/hgs_pot_calming.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-0.5, 50, 2),
	ang = Angle(0, 270, 0),
	fov = 25.29,
}

ITEM.functions.Drink = {
	OnRun = function(itemTable)
        local client = itemTable.player

        if(itemTable["data"]["status"] == "Well") then
            client:SetNWBool("A_Poison", false)
        elseif (itemTable["data"]["status"] == "Bad") then
            client:SetNWBool("A_Poison", true)
			client:SetNWInt("A_Poison_Power", 5 )
        end
        
	end
}