
ITEM.name = "Caldero portable"
ITEM.description = "Es un caldero pequeño que puedes llevar contigo"
ITEM.model = Model("models/sbs/hogsmeade/wu/hmm_snapeminiculd.mdl")
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-0.5, 50, 2),
	ang = Angle(0, 270, 0),
	fov = 25.29
}

ITEM.functions.Place = {
	OnRun = function(itemTable)

		local client = itemTable.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
            
        

		local lock = scripted_ents.Get("ix_cauldron"):SpawnFunction(client, util.TraceLine(data))
        
	end
}