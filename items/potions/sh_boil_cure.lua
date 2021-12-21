
ITEM.name = "Cura para forunculos"
ITEM.description = "Cura los forunculos"
ITEM.model = Model("models/sbs/hogsmeade/hm/hgs_pot_polyjuice.mdl")
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

            local childrenEnt = client:GetChildren()
            local boilEnt = 0
            for k , v in pairs ( childrenEnt ) do
                if(v:GetModel() == 'models/weapons/w_bugbait.mdl') then
                    boilEnt = k
                end
            end
            SafeRemoveEntity(childrenEnt[boilEnt])


		elseif (itemTable["data"]["status"] == "Bad") then
 
            local model = Model("models/weapons/w_bugbait.mdl")
            local a1 = ents.Create("base_anim")
                a1:SetPos(client:GetPos())
                a1:SetModel(model)
                a1:SetNWString('boil', true)
                a1:SetModelScale(2, 0)
                a1:SetAngles(Angle(90,120,0))
                a1:Spawn()
                a1:Activate()
    
            local bone = client:LookupBone("ValveBiped.Bip01_Head1")
            if bone then a1:FollowBone(client, bone) end
    
        end
	end
}