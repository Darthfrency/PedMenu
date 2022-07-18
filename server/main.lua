ESX = exports.es_extended:getSharedObject()
local function EncodeName(name) 
    return json.encode({name=name})
end 
local function DecodeName(name)
    print(name)
    return json.decode(name).name
end 
local function CheckPermission(id)
    local xPlayer = ESX.GetPlayerFromId(id)
    local group = xPlayer.getGroup()
    if group == "admin" or group == "superadmin"then return true end return false
end
ESX.RegisterServerCallback(GetCurrentResourceName()..":HasPermission",function (source, cb)
    if CheckPermission(source) then cb() end
end)
ESX.RegisterServerCallback(GetCurrentResourceName()..":GetValues", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
    if not CheckPermission(source) then
        cb(nil)
    end 
    MySQL.Async.fetchAll('SELECT * FROM changeskinmenu WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        local element = {}
        for index, value in ipairs(result) do
            table.insert(element,{label = DecodeName(value.name), value = json.decode(value.data)})
        end
        cb(element)
	end)
end)


RegisterNetEvent(GetCurrentResourceName()..":AddValue")
AddEventHandler(GetCurrentResourceName()..":AddValue", function (name, skin)
	local xPlayer = ESX.GetPlayerFromId(source)
    if not CheckPermission(source) then
        return
    end
    MySQL.Async.execute('INSERT INTO changeskinmenu(identifier, name, data) VALUES (@identifier,@name,@data)', {
		['identifier'] = xPlayer.identifier, ['name']= EncodeName(name),["data"]= json.encode(skin)
	}, function(result)

	end)
end)
RegisterNetEvent(GetCurrentResourceName()..":RemoveValue")
AddEventHandler(GetCurrentResourceName()..":RemoveValue", function (name)
	local xPlayer = ESX.GetPlayerFromId(source)
    if not CheckPermission(source) then
        return
    end
    MySQL.Async.execute('DELETE FROM changeskinmenu WHERE identifier = @identifier AND name = @name', {
		['@identifier'] = xPlayer.identifier, ['@name']= EncodeName(name),
	}, function(result)

	end)
end)
RegisterNetEvent(GetCurrentResourceName()..":RemoveAllValue")
AddEventHandler(GetCurrentResourceName()..":RemoveAllValue", function ()
	local xPlayer = ESX.GetPlayerFromId(source)
    if not CheckPermission(source) then
        return
    end
    MySQL.Async.execute('DELETE FROM changeskinmenu WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	}, function(result)

	end)
end)