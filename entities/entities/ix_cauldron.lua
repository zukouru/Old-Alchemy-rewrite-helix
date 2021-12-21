local PLUGIN = PLUGIN

function has_value (tab, val)

    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end




ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Caldero"
ENT.Category = "Potions HP"
ENT.Spawnable = true
ENT.PhysgunDisable = true
ENT.AdminOnly = true
ENT.bNoPersist = true

local ingredientsWhitelist = {
	"Pocion vacia", "Bezoar", "Bulbo rebotador", "Dedalera", "Mariposa revoloteadora", "Puas de puercoespin",
	"Mucosidad de gusarajo", "Gengibre", "Aguamiel", "Babosa cornuda", "Bayas de muerdago", "Hoja de ortiga",
	"Cebolla maloliente", "Sangre de salamandra", "Espinas de shrake", "Colmillos de serpientes", "Espinas de pez leon",
	"Ingrediente estandar", "Mandragora cocida", "Cuerno de unicornio",
}

local recipeWhitelist = {
	["antidote_for_common_poison_recipe"] = "Receta antidoto para venenos comunes",
	["wiggenweld_recipe"] = "Receta pocion herbovitalizante",	["pompion_recipe"] = "Receta pocion pompion",
	["boil_cure_recipe"] = "Receta cura para forunculos",
}



function ENT:Initialize()
	if (SERVER) then

		self:SetModel( "models/sbs/hogsmeade/wu/hmm_snapeminiculd.mdl" )
		self:SetMoveType(MOVETYPE_NONE)
		
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType( SIMPLE_USE )
		self:SetNWInt( "Pocion vacia", 0 )
		
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		
		self:SetBodygroup(1, 0)
	end
end



function ENT:SpawnFunction( ply, tr )

	local angles = (tr.HitPos - ply:GetPos()):Angle()
		angles.r = 0
		angles.p = 0
		angles.y = angles.y + 180

	local ent = ents.Create( 'ix_cauldron' )
	ent:SetPos(tr.HitPos )
	ent:SetAngles(angles)
	
	ent:Spawn()
	ent:DropToFloor()
	PLUGIN:SaveData()
	return ent
end

function ENT:returnIngredients(ply)
	local ingredients = {}
	local recipes = {}

	local character = ply:GetCharacter()
	local inventory = character:GetInventory()




	for k, v in pairs(recipeWhitelist) do

		local label = v
		for k, v in pairs(inventory:GetItemsByUniqueID(k)) do

			recipes[label] = v:GetData("recipe")

		end
	end
	
	for k, v in pairs(ingredientsWhitelist) do

		if(v != "Pocion vacia" && self:GetNWInt(v) > 0) then
			ingredients[v] = self:GetNWInt(v)
		end

	end

	net.Start("ixCheckIngredients")
		net.WriteTable(ingredients)
	net.Send(ply)

	net.Start("ixCheckRecipes")
		net.WriteTable(recipes)
	net.Send(ply)
end

function ENT:Think()

	return true
end



function ENT:Use(ply)



	self:returnIngredients(ply)

	net.Start("ixOpenAlchemyMenu")
		net.WriteEntity(self)
	net.Send(ply)
end

function ENT:StartTouch( entity )

	if (entity:GetClass() == "ix_item") then


		local entityName = entity:GetItemTable().name

		if (has_value(ingredientsWhitelist, entityName)) then
			self:SetNWInt( entityName, self:GetNWInt(entityName) + 1 )
			entity:Remove()
		end
	end
end



function ENT:Draw()
    self:DrawModel()
	local name = "Caldero"
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local rang = ang
	rang:RotateAroundAxis(rang:Up(), 90)
	
	-- cam.Start3D2D( self:GetPos() + ang:Up()*, rang, 0.1 )
	cam.Start3D2D( self:GetPos() + ang:Up()*13, rang, 0.1	 )
		draw.RoundedBox( 5, -160, -198, 320, 100, Color(50,50,50,200) )
		draw.DrawText( name , "Alchemy_Medium", 0, -190, Color( 255,255,255,255), 1 )
		draw.DrawText( "Pocion vacía: " .. self:GetNWInt("Pocion vacia") , "Alchemy_Low", 0, -140, Color( 255,255,255,255), 1 )
	cam.End3D2D()
	
end



