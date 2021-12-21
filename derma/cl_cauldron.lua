local PLUGIN = PLUGIN

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end


surface.CreateFont( "Alchemy_Small", {
	font = "Arial",
	extended = false,
	size = ScrW()*0.01,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "Alchemy_Low", {
	font = "Arial",
	extended = false,
	size = ScrW()*0.02,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "Alchemy_Medium", {
	font = "Arial",
	extended = false,
	size = ScrW()*0.03,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "Alchemy_High", {
	font = "Arial",
	extended = false,
	size = ScrW()*0.06,
	weight = 500,
	antialias = true,
} )

function AddRecipe( ingredient )
	local W, H = ScrW(), ScrH()
	local index = 0
	local y = H*0.01	
	for k, v in pairs(ingredient) do

		local recipeLabel = 'recipe' .. index
		local y2 = 0
		recipeLabel = vgui.Create( "DLabel", AlchemyPanel.RecipeInfo )
		recipeLabel:SetText( "" )
		recipeLabel:SetPos( 0, y )
		recipeLabel:SetSize( W*0.300, H*0.05 )
		recipeLabel.Col = Color(80,200,80,0)
		recipeLabel.Ing = ingredient
		recipeLabel.Paint = function( self )
			draw.RoundedBox( 0, 0, 0, W*1, H*0.05,  Color(80,200,80,0) )
			draw.DrawText(  k.. " (" .. v .. ")" , "Alchemy_Small", W*0.1, H*0.01, Color( 160 + self.Col.r, 160 + self.Col.g, 160 + self.Col.b, 255), 1 )
		end
		recipeLabel.OnCursorEntered = function( self )
			self.Col = Color(150,150,150,100)
			surface.PlaySound("alchemy/hovered.wav")
		end	
		recipeLabel.OnCursorExited = function( self )
			self.Col = Color(80,80,80,0)
		end

		
		y = y + H*0.05 + 3
		index = index + 1
	end
	
	
end


local Ingredient = {}
local Recipes = {}
local Recipe = {}

net.Receive("ixCheckIngredients", function(len, ply)
	local ingredientTable = net.ReadTable()

	Ingredient = ingredientTable
end)

net.Receive("ixCheckRecipes", function(len, ply)
	local recipeTable = net.ReadTable()

	Recipes = recipeTable
end)
 
function OpenAlchemyMenu()
	local W, H = ScrW(), ScrH()
	local NEnt = net.ReadEntity()
	local Depth, Liquid, Step = H*0.9, 0, H*0.07
	local dt = CurTime() - ( LV or CurTime() )
	local ResultCol = Color(0,0,0,255)

	
	
	
	if (AlchemyPanel) then AlchemyPanel:Remove() end

	AlchemyPanel = vgui.Create( "DFrame" )
	AlchemyPanel:SetPos( 0, 0 )
	AlchemyPanel:SetSize( W, H )
	AlchemyPanel:SetTitle( "" )
	AlchemyPanel:SetDraggable( false )
	AlchemyPanel:ShowCloseButton( false )
	AlchemyPanel:MakePopup()
	AlchemyPanel.Col = Color(0,0,0)
	AlchemyPanel.IngredientCount = 0
	AlchemyPanel.ErrA = 0
	AlchemyPanel.Paint = function( self )
		if ( NEnt == NULL ) then AlchemyPanel:Remove() return end
		local dt = CurTime() - ( LV or CurTime() )
		draw.RoundedBox( 0, 0, 0, W, H, Color( 0,0,0,220 ) )

		draw.RoundedBox( 0, 0, H*0.1, W, H*0.9, Color( 80,80,80,50 ) )
		draw.DrawText( "Caldero", "Alchemy_High", ScrW()/2, ScrH() * 0.001, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		if ( self.ErrA > 0 ) then self.ErrA = self.ErrA - ( 180 * dt ) end
		if ( NEnt:GetNWInt("Pocion vacia") <= 0 ) then
			draw.DrawText( "Agrega una pocion vacia", "Alchemy_Low", ScrW()*0.85, ScrH() * 0.15, Color( 255, 50, 50, self.ErrA ), 1 )
		end
		
		draw.RoundedBox( 0, W*0.05, H*0.2, W*0.30, H*0.1, Color( 90,150,150,255 ) )
		draw.RoundedBox( 0, W*0.05, H*0.3, W*0.30, H*0.6, Color( 60,80,100,50 ) )
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.DrawOutlinedRect( W*0.05, H*0.2, W*0.30, H*0.1 )
		surface.DrawOutlinedRect( W*0.05, H*0.3 - 1, W*0.30, H*0.6 )
		draw.DrawText( "Ingredientes", "Alchemy_Medium", ScrW() * 0.200, ScrH() * 0.225, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		
		draw.RoundedBox( 0, W*0.40, H*0.2, W*0.30, H*0.1, Color( 90,80,150,255 ) )
		draw.RoundedBox( 0, W*0.40, H*0.3, W*0.30, H*0.6, Color( 60,80,100,50 ) )
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.DrawOutlinedRect( W*0.40, H*0.2, W*0.30, H*0.1 )
		surface.DrawOutlinedRect( W*0.40, H*0.3 - 1, W*0.30, H*0.6 )
		draw.DrawText( "Recetas", "Alchemy_Medium", ScrW() * 0.550, ScrH() * 0.225, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
			
		draw.RoundedBox( 0, W*0.75, H*0.5, W*0.2, H*0.05, Color( 90,80,150,255 ) )
		draw.RoundedBox( 0, W*0.75, H*0.55, W*0.2, H*0.20, Color( 60,80,100,50 ) )
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.DrawOutlinedRect(  W*0.75, H*0.5, W*0.2, H*0.05 )
		surface.DrawOutlinedRect( W*0.75, H*0.55 -1, W*0.2, H*0.20 )
		draw.DrawText( "Receta", "Alchemy_Small", ScrW() *0.85, ScrH() *0.515, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )

		LV = CurTime()
	end

	
		
	AlchemyPanel.IngredientList = vgui.Create( "DScrollPanel", AlchemyPanel )
	AlchemyPanel.IngredientList:SetSize( W*0.300, H*0.6 )
	AlchemyPanel.IngredientList:SetPos( W*0.05, H*0.3 )
	local sbar = AlchemyPanel.IngredientList:GetVBar()
	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 50 ) )
	end
	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 120 ) )
	end
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 120 ) )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
	end

	AlchemyPanel.RecipeList = vgui.Create( "DScrollPanel", AlchemyPanel )
	AlchemyPanel.RecipeList:SetSize( W*0.300, H*0.6 )
	AlchemyPanel.RecipeList:SetPos( W*0.4, H*0.31 )
	local sbar = AlchemyPanel.RecipeList:GetVBar()
	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 50 ) )
	end
	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 120 ) )
	end
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 120 ) )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
	end

	AlchemyPanel.RecipeInfo = vgui.Create( "DScrollPanel", AlchemyPanel )
	AlchemyPanel.RecipeInfo:SetSize( W*0.2, H*0.20 )
	AlchemyPanel.RecipeInfo:SetPos( W*0.75, H*0.55 )
	local sbar = AlchemyPanel.RecipeInfo:GetVBar()
	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 50 ) )
	end
	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 120 ) )
	end
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 120 ) )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
	end

	

		
	
	local y = H*0.01
	for k , v in pairs (Recipes) do

			local Button = vgui.Create( "DButton", AlchemyPanel.RecipeList )
			Button:SetText( "" )
			Button:SetPos( 1, y )
			Button:SetSize(  W*0.900 - 2, H*0.05 )
			Button.Col = Color(80,80,80,1)
			Button.BgCol = Color( 0, 0, 0, 100 )
			Button.Paint = function( self )
				draw.RoundedBox( 0, 0, 0, W*0.900, H*0.05, Button.BgCol)
				draw.DrawText( k, "Alchemy_Small", W*0.150, H*0.01, Color( 160 + self.Col.r, 160 + self.Col.g, 160 + self.Col.b, 255 ), 1 )
			end

			Button.DoClick = function()
				
				Button.BgCol = Color( 0, 0, 0, 50 )

				if (tablelength(Recipe) > 0) then
					Recipe = {	}
					Ingredient["Receta"] = nil
					AlchemyPanel:Remove()
				else
					Ingredient["Receta"] = v
					Recipe = v.ingredients
					AddRecipe(Recipe)
				end
	
			end

			Button.OnCursorEntered = function()
				Button.Col = Color(150,150,150,100)
				Button.BgCol = Color( 0, 0, 0, 50 )
				surface.PlaySound("alchemy/hovered.wav")
			end	
			Button.OnCursorExited = function()
				
				Button.BgCol = Color( 0, 0, 0, 100 )
				Button.Col = Color(80,80,80,0)
			
			end

			if(tablelength(Recipe) > 0)then
				AddRecipe(Recipe)
			end

			y = y + H*0.05 + 3
	
	end



	local y = H*0.01
	for k , v in pairs (Ingredient) do

			local Button = vgui.Create( "DButton", AlchemyPanel.IngredientList )
			
			Button:SetPos( 1, y )
			Button:SetSize( W*0.900 - 2, H*0.05 )
			Button.Col = Color(80,80,80,0)
			Button.Paint = function( self )
				draw.RoundedBox( 0, 0, 0, W*0.900, H*0.05, Color( 0, 0, 0, 100 ))
				draw.DrawText( k.. " (" .. v .. ")", "Alchemy_Low", W*0.150, H*0.01, Color( 160 + self.Col.r, 160 + self.Col.g, 160 + self.Col.b, 255 ), 1 )
			end
			Button.OnCursorEntered = function()
				Button.Col = Color(150,150,150,100)
				surface.PlaySound("alchemy/hovered.wav")
			end	
			Button.OnCursorExited = function()
				Button.Col = Color(80,80,80,0)
			end
	
			y = y + H*0.05 + 3
	
	end
	
	local Create = vgui.Create( "DButton", AlchemyPanel )
	Create:SetText( "" )
	Create:SetPos( W*0.75, H*0.2 )
	Create:SetSize( W*0.2, H*0.1 )
	Create.Col = Color(20,80,20,150)
	Create.Paint = function( self )
		draw.RoundedBox( 0, 0, 0, W*0.2, H*0.1, self.Col )
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.DrawOutlinedRect( 0, 0, W*0.2, H*0.1 )
		draw.DrawText( "Agitar varita", "Alchemy_Medium", ScrW() * 0.1, ScrH() * 0.025, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
	Create.OnCursorEntered = function( self )
		self.Col = Color(50,180,50,150)
		surface.PlaySound("alchemy/hovered.wav")
	end	
	Create.OnCursorExited = function( self )
		self.Col = Color(20,80,20,150)
	end
	Create.DoClick = function()
		if ( NEnt:GetNWInt("Pocion vacia") > 0 ) then
						
			surface.PlaySound("alchemy/add_" .. math.random(1,2) .. ".wav")
			net.Start("ixSpawnPotion")
				net.WriteEntity(NEnt)
				net.WriteTable(Ingredient)
			net.SendToServer()
			Recipe = {	}
			Ingredient = {}
			AlchemyPanel:Remove()
		else
			AlchemyPanel.ErrA = 255
			surface.PlaySound("buttons/blip1.wav")
		end
	end
	
	local Cancel = vgui.Create( "DButton", AlchemyPanel )
	Cancel:SetText( "" )
	Cancel:SetPos( W*0.75, H*0.35 )
	Cancel:SetSize( W*0.2, H*0.1 )
	Cancel.Col = Color(80,20,20,150)
	Cancel.Paint = function( self )
		draw.RoundedBox( 0, 0, 0, W*0.2, H*0.1, self.Col )
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.DrawOutlinedRect( 0, 0, W*0.2, H*0.1 )
		draw.DrawText( "Volver", "Alchemy_Medium", ScrW() * 0.1, ScrH() * 0.025, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
	Cancel.OnCursorEntered = function( self )
		self.Col = Color(180,50,50,150)
		surface.PlaySound("alchemy/hovered.wav")
	end	
	Cancel.OnCursorExited = function( self )
		self.Col = Color(80,20,20,150)
	end
	Cancel.DoClick = function()
		Recipe = {	}
		AlchemyPanel:Remove()
	end

	local Pick = vgui.Create( "DButton", AlchemyPanel )
	Pick:SetText( "" )
	Pick:SetPos( W*0.75, H*0.800 )
	Pick:SetSize( W*0.2, H*0.1 )
	Pick.Col = Color(125, 21, 255, 150)
	Pick.Paint = function( self )
		draw.RoundedBox( 0, 0, 0, W*0.2, H*0.1, self.Col )
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.DrawOutlinedRect( 0, 0, W*0.2, H*0.1 )
		draw.DrawText( "Vaciar caldero", "Alchemy_Medium", ScrW() * 0.1, ScrH() * 0.025, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
	Pick.OnCursorEntered = function( self )
		self.Col = Color(85, 50, 255, 150)
		surface.PlaySound("alchemy/hovered.wav")
	end	
	Pick.OnCursorExited = function( self )
		self.Col = Color(125, 21, 255, 150)
	end
	Pick.DoClick = function()
		Recipe = {	}
		AlchemyPanel:Remove()
		net.Start("ixPickUp")
				net.WriteEntity(NEnt)
		net.SendToServer()
	end
	
end


net.Receive("ixOpenAlchemyMenu", OpenAlchemyMenu)

