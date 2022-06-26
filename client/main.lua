Citizen.CreateThread(function()
    local wait = 1000
    while true do
        local inRange = false
        local pedCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.Locations) do
            if #(pedCoords - v.coords1) < v.distance then
                inRange = true
                if v.price == nil then
                    DrawText3Ds(v.coords1, _U('tp_text_1'))
                else
                    DrawText3Ds(v.coords1, _U('tp_text_2', v.price))
                end
                DrawMarker(2, v.coords1.x, v.coords1.y, v.coords1.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if IsControlJustPressed(0, 38) then
                    ESX.TriggerServerCallback('vrs_tp:server:checkMoney', function(hasMoney) 
                        if hasMoney then
                            TriggerServerEvent('vrs_tp:server:pay', v.price)
                            DoScreenFadeOut(1000)
                            Citizen.Wait(1000)
                            SetEntityCoords(PlayerPedId(), v.coords2.x, v.coords2.y, v.coords2.z - 1)
                            DoScreenFadeIn(1000)
                            Citizen.Wait(1000)
                        else
                            exports['t-notify']:Custom({
                                style  =  'error',
                                duration = 3000,
                                message  =  _U('not_enough_money'),
                            })
                        end
                    end, v.price or 0)
                end
            end

            if #(pedCoords - v.coords2) < v.distance then
                inRange = true
                DrawText3Ds(v.coords2, _U('tp_text_1'))
                DrawMarker(2, v.coords2.x, v.coords2.y, v.coords2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if IsControlJustPressed(0, 38) then
                    DoScreenFadeOut(1000)
                    Citizen.Wait(1000)
                    SetEntityCoords(PlayerPedId(), v.coords1.x, v.coords1.y, v.coords1.z - 1)
                    DoScreenFadeIn(1000)
                    Citizen.Wait(1000) 
                end
            end
        end

        if inRange then
            wait = 3
        else
            wait = 1000
        end
        Citizen.Wait(wait)
    end
end)

function DrawText3Ds(coords, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(coords.x, coords.y, coords.z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end