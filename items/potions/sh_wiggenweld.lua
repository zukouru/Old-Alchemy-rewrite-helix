
ITEM.name = "Pocion herbovitalizante"
ITEM.description = "Es una pocion curativa con el poder de curar heridas y funciona como antidoto de algunas pociones."
ITEM.model = Model("models/sbs/hogsmeade/hm/hgs_pot_wiggenweld.mdl")
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

        if(itemTable["data"]["status"] == "Well") then
            client:SetHealth( client:Health() + math.random(10,30) )
            if ( client:Health() > 100 ) then
                client:SetHealth(100)
            end	
        elseif (itemTable["data"]["status"] == "Bad") then
            client:SetNWBool("A_Poison", true)
			client:SetNWInt("A_Poison_Power", 1 )
        end
        
	end

    
}
