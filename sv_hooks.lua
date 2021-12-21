local PLUGIN = PLUGIN;

function PLUGIN:SaveData()
	local caldero = {}

	for _, entity in ipairs(ents.FindByClass("ix_caldero")) do

		caldero[#caldero + 1] = {
			pos = entity:GetPos(),
			angles = entity:GetAngles(),
			model = entity:GetModel()
		}
	end

	ix.data.Set("caldero", caldero)
end

function PLUGIN:LoadData()
	for _, v in ipairs(ix.data.Get("caldero") or {}) do
		local caldero = ents.Create("ix_caldero")
		caldero:SetPos(v.pos)
		caldero:SetAngles(v.angles)
		caldero:Spawn()

		caldero:SetModel(v.model)
		caldero:SetSkin(0)
		caldero:SetSolid(SOLID_VPHYSICS)
		caldero:PhysicsInit(SOLID_VPHYSICS)

		local physObj = caldero:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end
end
