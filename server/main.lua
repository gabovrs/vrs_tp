RegisterServerEvent('vrs_tp:server:pay')
AddEventHandler('vrs_tp:server:pay', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeAccountMoney('money', price)
end)

ESX.RegisterServerCallback('vrs_tp:server:checkMoney', function(source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.getAccount('money').money >= price)
end)