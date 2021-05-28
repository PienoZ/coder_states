ESX = nil

Currentstates = {

	[1] = { ["text"] = "Kanlı Eller", ["status"] = false, ["timer"] = 0 },

	[2] = { ["text"] = "Dilate Gözler", ["status"] = false, ["timer"] = 0 },

	[3] = { ["text"] = "Kırmızı Gözler", ["status"] = false, ["timer"] = 0 },

	[4] = { ["text"] = "Esrar Gibi Kokuyor", ["status"] = false, ["timer"] = 0 },

	[5] = { ["text"] = "Taze Sargı", ["status"] = false, ["timer"] = 0 },

	[6] = { ["text"] = "Tedirgin", ["status"] = false, ["timer"] = 0 },

	[7] = { ["text"] = "Kordinasyonsuz", ["status"] = false, ["timer"] = 0 },

	[8] = { ["text"] = "Alkollü Gibi Kokuyor", ["status"] = false, ["timer"] = 0 },

	[9] = { ["text"] = "Benzin Gibi Kokuyor", ["status"] = false, ["timer"] = 0 },

	[10] = { ["text"] = "Kırmızı Barut Kalıntısı", ["status"] = false, ["timer"] = 0 },

	[11] = { ["text"] = "Kimyasal Kokular", ["status"] = false, ["timer"] = 0 },

	[12] = { ["text"] = "Petrol / Metal İşleri Kokusu", ["status"] = false, ["timer"] = 0 },

	[13] = { ["text"] = "Mürekkepli Eller", ["status"] = false, ["timer"] = 0 },

	[14] = { ["text"] = "Duman Gibi Kokuyor", ["status"] = false, ["timer"] = 0 },

	[15] = { ["text"] = "Kamp ekipmanları var", ["status"] = false, ["timer"] = 0 },

	[16] = { ["text"] = "Yanmış alüminyum ve demir gibi kokuyor", ["status"] = false, ["timer"] = 0 },

	[17] = { ["text"] = "Giyim üzerine metal özelliklere sahiptir", ["status"] = false, ["timer"] = 0 },

	[18] = { ["text"] = "Sigara Dumanı Gibi Kokuyor", ["status"] = false, ["timer"] = 0 },

	[19] = { ["text"] = "Zor Nefes Alıyorum", ["status"] = false, ["timer"] = 0 },

	[20] = { ["text"] = "Vücudun Terledi", ["status"] = false, ["timer"] = 0 },

	[21] = { ["text"] = "Kıyafeti Ter Kokuyor", ["status"] = false, ["timer"] = 0 },	

    [22] = { ["text"] = "Tel Kesikleri", ["status"] = false, ["timer"] = 0 },

	[23] = { ["text"] = "Kıyafetlerim Sırımsıklak", ["status"] = false, ["timer"] = 0 },		

    [24] = { ["text"] = "Dazed Görünüyor", ["status"] = false, ["timer"] = 0 },

    [25] = { ["text"] = "İyi Beslenmiş Görünüyor", ["status"] = false, ["timer"] = 0 },

    [26] = { ["text"] = "Ellerinde Çizikler Var.", ["status"] = false, ["timer"] = 0 }, 

    [27] = { ["text"] = "Uyarıyı Görüyor", ["status"] = false, ["timer"] = 0 }, 

}







RegisterNetEvent("fuge-state:stateSet")

AddEventHandler("fuge-state:stateSet",function(stateId,stateLength)

	if Currentstates[stateId]["timer"] < 10 and stateLength ~= 0 then

		TriggerEvent('chat:addMessage', {template = '<div class="chat-message state"><r> {0}</r> {1}</div>', args = { "[Durum] ",  Currentstates[stateId]["text"] } })

	end

	Currentstates[stateId]["timer"] = stateLength

end)





local lastTarget

local target

local targetLastHealth

local bodySweat = 0

local sweatTriggered = false

Citizen.CreateThread(function()



    while true do

        Wait(300)



        if IsPedInAnyVehicle(PlayerPedId(), false) then

        	local vehicle = GetVehiclePedIsUsing(PlayerPedId())

        	local bicycle = IsThisModelABicycle( GetEntityModel(vehicle) )

        	local speed = GetEntitySpeed(vehicle)

        	if bicycle and speed > 0 then

        		sweatTriggered = true

        		if bodySweat < 180 then

        			bodySweat = bodySweat + (150 + math.ceil(speed * 20))

        		else

        			bodySweat = bodySweat + (150 + math.ceil(speed * 10))

        		end



        		if bodySweat > 300 then

	        		bodySweat = 300

	        	end

        	end

        end
		
		if IsPedOnAnyBike(PlayerPedId(), false) then

        	local vehicle = GetVehiclePedIsUsing(PlayerPedId())

        	local bicycle = IsThisModelABicycle( GetEntityModel(vehicle) )

        	local speed = GetEntitySpeed(vehicle)

        	if bicycle and speed > 0 then

        		sweatTriggered = true

        		if bodySweat < 180 then

        			bodySweat = bodySweat + (150 + math.ceil(speed * 20))

        		else

        			bodySweat = bodySweat + (150 + math.ceil(speed * 10))

        		end



        		if bodySweat > 300 then

	        		bodySweat = 300

	        	end

        	end

        end



        if IsPedInMeleeCombat(PlayerPedId()) then

        	bodySweat = bodySweat + 300

        	sweatTriggered = true

			target = GetMeleeTargetForPed(PlayerPedId())

        	if target == lastTarget or lastTarget == nil then

				if IsPedAPlayer(target) then

					TriggerEvent("fuge-state:stateSet",1,300)

        			lastTarget = target

        		end

        	else

				if IsPedAPlayer(target) then

					TriggerEvent("fuge-state:stateSet",1,300)

	        		targetLastHealth = GetEntityHealth(target)

	        		lastTarget = target

	        	end

        	end

        end
		
		
		if IsPedInCombat(PlayerPedId()) then

        	bodySweat = bodySweat + 300

        	sweatTriggered = true

			target = GetCombatTargetForPed(PlayerPedId())

        	if target == lastTarget or lastTarget == nil then

				if IsPedAPlayer(target) then

					TriggerEvent("fuge-state:stateSet",1,300)

        			lastTarget = target

        		end

        	else

				if IsPedAPlayer(target) then

					TriggerEvent("fuge-state:stateSet",1,300)

	        		targetLastHealth = GetEntityHealth(target)

	        		lastTarget = target

	        	end

        	end

        end



        if IsPedSwimming(PlayerPedId()) then

        	local speed = GetEntitySpeed(PlayerPedId())

        	if speed > 0 then

        		sweatTriggered = true

        		TriggerEvent("fuge-state:stateSet",20,0)

        		TriggerEvent("fuge-state:stateSet",21,0)

        		TriggerEvent("fuge-state:stateSet",23,600)

        		if bodySweat < 180 then

        			bodySweat = bodySweat + (100 + math.ceil(speed * 10))

        		else

        			bodySweat = bodySweat + (100 + math.ceil(speed * 11))

        		end

        		



        		if bodySweat > 210 then

        			TriggerEvent("fuge-state:stateSet",19,600)

	        		bodySweat = 210

	        	end

        	end

        end



        if IsPedRunning(PlayerPedId()) then

        	bodySweat = bodySweat + 30

        	if bodySweat > 800then

        		bodySweat = 800

        	end

        elseif bodySweat > 0.0 then

        	if not sweatTriggered then

        		bodySweat = 0.0

        	end

        	if bodySweat < 1200 then

        		bodySweat = bodySweat - 1000

        	end

        	bodySweat = bodySweat - 100

        	if bodySweat == 0.0 then

        		sweatTriggered = false

        	end

        end

        if bodySweat > 200 and not IsPedSwimming(PlayerPedId()) then

			TriggerEvent("fuge-state:stateSet",19,300)

        end  



        if bodySweat > 300 and not IsPedSwimming(PlayerPedId()) and Currentstates[22]["timer"] < 50 then

			TriggerEvent("fuge-state:stateSet",20,450)

        end 

        if bodySweat > 800 and not IsPedSwimming(PlayerPedId()) and Currentstates[22]["timer"] < 50 then

        	sweatTriggered = true

			TriggerEvent("fuge-state:stateSet",21,600)

        end



    end

end)