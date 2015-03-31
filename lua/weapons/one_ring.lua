AddCSLuaFile("one_ring.lua")
AddCSLuaFile("sh_shared.lua")
include("sh_shared.lua")




if (SERVER) then

	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if ( CLIENT ) then
	SWEP.PrintName			= "The One Ring"	
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= false
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= true
	
	SWEP.Slot				= 0
	SWEP.SlotPos			= 3
	SWEP.IconLetter			= "j"
	
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false


end


SWEP.Category				= "Lord Of The Rings"

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.ViewModel = "models/weapons/v_hands.mdl"
SWEP.WorldModel 			= ""

SWEP.DrawWeaponInfoBox  	= false

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.Primary.ClipSize			= -1
SWEP.Primary.Damage				= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic			= true
SWEP.Primary.Ammo				= "none"


SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Damage			= -1
SWEP.Secondary.Automatic		= true
SWEP.Secondary.Ammo				= "none"



function SWEP:Initialize()
		self.HoldType = "normal"
end



	function cloak(ply,bool)
		ply:SetNoDraw(bool)
			for k, v in pairs(ply:GetWeapons()) do
				v:SetNoDraw(bool)
			end

			for k,v in pairs(ents.FindByClass("physgun_beam")) do
				if v:GetParent() == ply then
					v:SetNoDraw(bool)
				end
			end
		end	



	function SWEP:PrimaryAttack()
		self:SetNextPrimaryFire( CurTime() + 1 )
	local ply = self.Owner
		 
		if ply:GetNWBool("usingring") then
			 
			 self:EmitSound("lotr_sweps/one_ring/one_ring_put.wav")
			 timer.Simple(1, function() ply:SetNWBool("usingring", false)
			 cloak(self.Owner, false) ply:ConCommand("stopsound") end)
			 timer.Destroy("eye_effect")
			 
		else 
			
			self:EmitSound("lotr_sweps/one_ring/one_ring_put.wav")
			timer.Simple(1, function() ply:SetNWBool("usingring", true)
			 cloak(self.Owner, true) ply:ConCommand("play lotr_sweps/one_ring/one_ring_loop.wav") end)
			 
			 
			 timer.Create("eye_effect",1,0, function()
			 local random = math.random(0,100)
			 if random != 0 then return end
			 timer.Destroy("eye_effect")
			 ply:SetNWBool("eye_effect", true)
			 ply:ConCommand("play lotr_sweps/one_ring/sauron_speech.wav")
			 ply:Freeze(true)
			 ply:StripWeapons()
			 timer.Simple(20, function() ply:Kill() ply:Freeze(false)  end)
			 timer.Simple(22, function() ply:ConCommand("stopsound") end)
			 end)
		
		
		end
	end
	
	function SWEP:Holster()
		self.Owner:SetNWBool("usingring", false)
		self.Owner:ConCommand("stopsound")
		timer.Destroy("eye_effect")
		cloak(self.Owner, false)
		return true
	end

	function SWEP:SecondaryAttack()
	return false
end


function SWEP:Reload()
	return false
	
end

 

















