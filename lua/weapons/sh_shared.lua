

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

function RemoveEvertything(ply)
	ply:SetNWBool("eye_effect", false)
	timer.Destroy("eye_effect")
	ply:SetNWBool("usingring", false)
end
hook.Add("PlayerDeath", "RemoveEvertything_lotr", RemoveEvertything)

end

if CLIENT then

function one_ring_effect()
	local ply = LocalPlayer()
	if ply:GetNWBool("eye_effect") then return end
	if not ply:GetNWBool("usingring") then return end
	if not ply:Alive() then ply:SetNWBool("usingring", false) return end
		
		draw.RoundedBox(2, 0, 0, ScrW() + 1, ScrH() + 1, Color(255,255,255,100))
		surface.SetMaterial(Material("models/props_combine/tpballglow"))
		surface.DrawTexturedRect( 0, 0, ScrW() + 1, ScrH() + 1 )
		
end
hook.Add("HUDPaint", "one_ring_effect", one_ring_effect)

function one_ring_eye_effect()
	local ply = LocalPlayer()
	if not ply:Alive() then ply:SetNWBool("eye_effect", false) return end
	if not ply:GetNWBool("eye_effect") then return end
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( Material("lotr_sweps/sauron_eye.png") ) -- If you use Material, cache it!
			surface.DrawTexturedRect( 0, 0, ScrW() + 1, ScrH() + 1 )
			
end
hook.Add("HUDPaint", "eye_effect", one_ring_eye_effect)

end