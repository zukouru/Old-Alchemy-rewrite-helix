
ITEM.name = "Pocion extraña"
ITEM.description = "Pocion de dudosa procedencia"
ITEM.model = Model("models/sbs/hogsmeade/hm/hgs_pot_calming.mdl")
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-0.5, 50, 2),
	ang = Angle(0, 270, 0),
	fov = 25.29,
}

ITEM.functions.Drink = {
	OnRun = function(itemTable)

        local client = itemTable.player
		
		client:SetNWBool("A_Poison", true)
		client:SetNWInt("A_Poison_Power", 20 )
	end
}