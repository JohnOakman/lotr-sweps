if SERVER then



function IsPoisoned(ply)
if not ply:IsPlayer() then error("IsPoisoned need to be with a Player") return end
	if ply:GetNWBool("poisoned") 
		then return true
	else return false
	end
end

function SetPoison(ply)
if not ply:IsPlayer() then error("SetPoison need to be with a Player") return end
	if IsPoisoned(ply) then return 
		
	else 
		ply:SetNWBool("poisoned", true)
		timer.Create("poisoned", 5,0, function() if ply:Health() <= 5 then ply:Kill() else ply:SetHealth(ply:Health() - 5) end end)
	
	end
end

function RemovePoison(ply)
	if not ply:IsPlayer() then error("RemovePoison need to be with a Player") return end
		if not IsPoisoned(ply) then return end
			ply:SetNWBool("poisoned",false)
			timer.Destroy("poisoned")
end
hook.Add("PlayerDeath", "RemovePoison", RemovePoison)
end