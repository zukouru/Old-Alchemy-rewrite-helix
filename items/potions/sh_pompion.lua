
ITEM.name = "Pompion"
ITEM.description = "Esta pocion convierte tu cabeza en calabaza temporalmente"
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
        local tNameWell = "alchemy_old_rewrite_pompion_well_handler" .. client:EntIndex()
        

        if(true) then
            
            if not timer.Exists(tNameWell) then
                
                local model = Model("models/props_outland/pumpkin01.mdl")
                local bone = client:LookupBone("ValveBiped.Bip01_Head1")
                print(client:GetBonePosition(bone))
                
                client:ManipulateBoneAngles(bone, Angle(-75.428,90, 89.637))
                local a1 = ents.Create("base_anim")
                    a1:SetPos(client:GetPos())
                    a1:SetModel(model)
                    a1:SetModelScale(1.05, 0)
                    a1:Spawn()
                    a1:Activate()
                    
                if bone then a1:FollowBone(client, bone) end
           
                timer.Create(tNameWell, 10, 1, function()
                    SafeRemoveEntity(a1)
                    client:ManipulateBoneAngles(bone, Angle(0, 0, 0))
                end)
            end

		elseif (itemTable["data"]["status"] == "Bad") then
            
            local rng = math.random(0, 100)
            if (rng > 20) then
                client:SetNWBool("A_Poison", true)
                client:SetNWInt("A_Poison_Power", 1 )
            else
                local bone = client:LookupBone("ValveBiped.Bip01_Head1")

                if bone then
                    local scale = 1
                    local tNameBad = "alchemy_old_rewrite_pompion_bad_handler" .. client:EntIndex()
                    

                    if not timer.Exists(tNameBad) then
                        timer.Create(tNameBad, 0.1, 5, function()
                            if IsValid(client) then
                                scale = scale + 0.2
                                client:ManipulateBoneScale(bone, Vector(scale, scale, scale))
                                client:SetViewOffset(client:GetViewOffset() * 1.01)
                                client:SetViewOffsetDucked(client:GetViewOffsetDucked() * 1.01)
                                if scale >= 1.9 then 
                                    timer.Simple(60, function()
                                        timer.Create(tNameBad, 0.1, 5, function()
                                            if IsValid(client) then
                                                scale = scale - 0.2
                                                client:SetViewOffset(Vector(0, 0, 64))
                                                client:SetViewOffsetDucked(Vector(0, 0, 28))
                                                client:ManipulateBoneScale(bone, Vector(scale, scale, scale))
                                            end
                                        end)
                                    end)
                                end
                            end
                        end)
                    else
                        client:SetNWBool("A_Poison", true)
                        client:SetNWInt("A_Poison_Power", 6 )
                    end
                end
            end

		end

	end
}

