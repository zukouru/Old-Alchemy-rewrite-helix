local PLUGIN = PLUGIN
ix.util.Include("sh_recipes.lua")
ix.util.Include("sh_effects_reset.lua")
NextThink = CurTime() + 1

local flag = true
function PLUGIN:PlayerSpawn(ply)
	ResetAllEffect(ply)
end

-- // CHECK TIMEOUT
function PLUGIN:Think()
	if ( CurTime() > NextThink ) then
		for k , v in pairs ( player.GetAll() ) do
			-- // HALO TIMEOUT
			if ( v:GetNWBool("A_Halo") ) then
				if ( CurTime() > v:GetNWInt("A_Halo_TimeOut") ) then
					v:SetNWBool("A_Halo", false)
					v:SetNWInt("A_Halo_TimeOut", 0)
					print("sprint timeout")
				end
			end
				
			-- // SPEED TIMEOUT
			if ( v:GetNWBool("A_Speed") ) then
				if ( CurTime() > v:GetNWInt("A_Speed_TimeOut") ) then
					v:SetNWBool("A_Speed", false)
					v:SetNWInt("A_Speed_TimeOut", 0)
					v:SetRunSpeed( v.DefaultSpeed )
					print("Sprint timeout")
				end
			end		
				
			-- // FALLDMG TIMEOUT
			if ( v:GetNWBool("A_FallDMG") ) then
				if ( CurTime() > v:GetNWInt("A_FallDMG_TimeOut") ) then
					v:SetNWBool("A_FallDMG", false)
					v:SetNWInt("A_FallDMG_TimeOut", 0)
					print("FallDMG timeout")
				end
			end
				
			-- // STEPSOUND TIMEOUT
			if ( v:GetNWBool("A_StepSound") ) then
				if ( CurTime() > v:GetNWInt("A_StepSound_TimeOut") ) then
					v:SetNWBool("A_StepSound", false)
					v:SetNWInt("A_StepSound_TimeOut", 0)
					print("StepSound timeout")
				end
			end	
				
			-- // JUMP TIMEOUT
			if ( v:GetNWBool("A_Jump") ) then
				if ( CurTime() > v:GetNWInt("A_Jump_TimeOut") ) then
					v:SetNWBool("A_Jump", false)
					v:SetNWInt("A_Jump_Power", 0)
					v:SetNWInt("A_Jump_TimeOut", 0)
					print("Jump timeout")
				end
			end
				
			-- // CLOAK TIMEOUT
			if ( v:GetNWBool("A_Cloak") ) then
				if ( CurTime() > v:GetNWInt("A_Cloak_TimeOut") ) then
					v:SetNWBool("A_Cloak", false)
					v:SetNWInt("A_Cloak_TimeOut", 0)
					local col = v:GetColor()
					v:SetColor( Color(col.r, col.g, col.b, 255) )
					v:SetRenderMode( RENDERMODE_NORMAL )
					print("Cloak timeout")
				end
			end	
				
			-- // GRAVITY TIMEOUT
			if ( v:GetNWBool("A_Gravity") ) then
				if ( CurTime() > v:GetNWInt("A_Gravity_TimeOut") ) then
					v:SetNWBool("A_Gravity", false)
					v:SetNWInt("A_Gravity_TimeOut", 0)
					v:SetGravity(1)
					print("Gravity timeout")
				end
			end		

			-- // REGEN TIMEOUT
			if ( v:GetNWBool("A_Regen") ) then
				if ( CurTime() > v:GetNWInt("A_Regen_TimeOut") ) then
					v:SetNWBool("A_Regen", false)
					v:SetNWInt("A_Regen_TimeOut", 0)
					v:SetNWInt("A_Regen_Power", 0)
					print("Regen timeout")
				else
					if ( v:Health() < 100 ) then
						v:SetHealth( v:Health() + v:GetNWInt("A_Regen_Power") )
					end
				end
			end	

			-- // POISON TIMEOUT
			if ( v:GetNWBool("A_Poison") == true ) then
				v:TakeDamage( v:GetNWBool("A_Poison_Power", v, v ) )
	
			end	

			-- // BOOM TIMEOUT
			if ( v:GetNWBool("A_Boom") ) then
				if ( CurTime() > v:GetNWInt("A_Boom_TimeOut") ) then
					net.Start("A_Boom_Effect")
					net.WriteVector( v:GetPos() )
					net.Broadcast()
					util.BlastDamage(v, v, v:GetPos(), 200, v:GetNWInt("A_Boom_Power") )
					print(v:GetNWInt("A_Boom_Power"))
					v:SetNWBool("A_Boom", false)
					v:SetNWInt("A_Boom_TimeOut", 0)
					v:SetNWInt("A_Boom_Power", 0)
					print("Boom timeout")
				end
			end	
			
		end
		NextThink = CurTime() + 1
	end	
end