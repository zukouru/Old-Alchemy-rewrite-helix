local PLUGIN = PLUGIN
function ResetAllEffect(ply)
	-- // RESET THE COLOR
	if ( ply:GetNWBool("A_Color" ) ) then
		if not ( ply.DefaultColor ) then ply:SetColor( ply.DefaultColor ) return end
		ply:SetColor( ply.DefaultColor )
		ply:SetNWBool("A_Color", false )
		ply.DefaultColor = nil
	end
		
	-- // RESET HALO
	if ( ply:GetNWBool("A_Halo" ) ) then
		ply:SetNWBool("A_Halo", false )
		ply:SetNWInt("A_Halo_TimeOut", 0)
	end
	
	-- // RESET SPEED
	if ( ply:GetNWBool("A_Speed" ) ) then
		ply:SetNWBool("A_Speed", false )
		ply:SetNWInt("A_Speed_TimeOut", 0)
		ply:SetRunSpeed( ply.DefaultSpeed )
		ply.DefaultSpeed = nil
	end

	-- // RESET SPEED
	if ( ply:GetNWBool("A_FallDMG" ) ) then
		ply:SetNWBool("A_FallDMG", false )
		ply:SetNWInt("A_FallDMG_TimeOut", 0 )
	end
		
	-- // RESET SOUND
	if ( ply:GetNWBool("A_StepSound" ) ) then
		ply:SetNWBool("A_StepSound", false )
		ply:SetNWInt("A_StepSound_TimeOut", 0 )
	end

	-- // RESET JUMP
	if ( ply:GetNWBool("A_Jump" ) ) then
		ply:SetNWBool("A_Jump", false )
		ply:SetNWInt("A_Jump_Power", 0 )
		ply:SetNWInt("A_Jump_TimeOut", 0 )
	end	
		
	-- // RESET CLOAK
	if ( ply:GetNWBool("A_Cloak" ) ) then
		ply:SetNWBool("A_Cloak", false )
		ply:SetNWInt("A_Cloak_TimeOut", 0 )
		local col = ply:GetColor()
		ply:SetColor( Color(col.r, col.g, col.b, 255) )
		ply:SetRenderMode( RENDERMODE_NORMAL )
	end		
	
	-- // RESET GRAVITY
	if ( ply:GetNWBool("A_Gravity" ) ) then
		ply:SetNWBool("A_Gravity", false )
		ply:SetNWInt("A_Gravity_TimeOut", 0 )
		ply:SetGravity(1)
	end

	-- // RESET REGEN
	if ( ply:GetNWBool("A_Regen" ) ) then
		ply:SetNWBool("A_Regen", false)
		ply:SetNWInt("A_Regen_TimeOut", 0)
		ply:SetNWInt("A_Regen_Power", 0)
	end

	-- // RESET POISON
	if ( ply:GetNWBool("A_Poison" ) ) then
		ply:SetNWBool("A_Poison", false)
		ply:SetNWInt("A_Poison_TimeOut", 0)
		ply:SetNWInt("A_Poison_Power", 0)
	end

	-- // RESET BOOM
	if ( ply:GetNWBool("A_Boom" ) ) then
		ply:SetNWBool("A_Boom", false )
		ply:SetNWInt("A_Boom_TimeOut", 0 )
		ply:SetNWInt("A_Boom_Power", 0 )
	end
	
end