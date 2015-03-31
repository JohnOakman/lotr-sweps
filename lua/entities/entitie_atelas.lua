ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Atelas"
ENT.Author			= "John Oakman"
ENT.Contact			= "John Oakman"
AddCSLuaFile( "entitie_atelas.lua" ) 
include("sh_shared.lua") 

ENT.Purpose			= "Atelas, to remove poison."
ENT.Instructions	= "Spawn it and click E."
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "Lord Of The Rings"


if SERVER then 


 
function ENT:Initialize()
	
	self:SetModel( "models/props/de_inferno/largebush01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end
 local delay = 1
function ENT:Use( activator, caller )
if delay == 0 then return end
delay = 0
    if IsPoisoned(activator) then
		RemovePoison(activator)
		self:EmitSound("items/smallmedkit1.wav")
		self:Remove()
	else 
	activator:PrintMessage(3, "You are not Poisoned")
	end
timer.Simple(3, function() delay = 1 end)
end



end

