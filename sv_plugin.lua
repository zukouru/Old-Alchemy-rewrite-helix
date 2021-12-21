
util.AddNetworkString("ixOpenAlchemyMenu")
util.AddNetworkString("ixSpawnPotion")
util.AddNetworkString("ixPickUp")
util.AddNetworkString("ixCheckIngredients")
util.AddNetworkString("ixCheckRecipes")

ix.util.Include("sh_recipes.lua")

net.Receive("ixSpawnPotion", function(len, ply)
	local NEnt = net.ReadEntity()
	local NTab = net.ReadTable()


	for k , v in pairs ( NTab ) do
		NEnt:SetNWInt( k, 0 )
	end


	if ( NEnt:GetNWInt("Pocion vacia") > 0 ) then
		NEnt:SetNWInt( "Pocion vacia", NEnt:GetNWInt("Pocion vacia") - 1 )
	end

    spawnPotion(NTab,NEnt)
	hook.Run("spawnPotionAlchemy", NTab, NEnt )
end)

net.Receive("ixPickUp", function(len, ply)
	local NEnt = net.ReadEntity()

	NEnt:Remove()
	local posTest = NEnt:GetPos() + Vector(0,0,50)
	ix.item.Spawn('cauldron', posTest)
end)
