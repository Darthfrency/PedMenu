ESX = exports.es_extended:getSharedObject()
RegisterCommand("savePed", function (source,args,rawcommand)
    if args[1] then
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerServerEvent(GetCurrentResourceName()..":AddValue", args[1],skin)
	end)
end
end)
RegisterCommand("removePed", function (source,args,rawcommand)
    if args[1] then
		TriggerServerEvent(GetCurrentResourceName()..":RemoveValue", args[1])
end
end)RegisterCommand("removeAllPed", function (source,args,rawcommand)
		TriggerServerEvent(GetCurrentResourceName()..":RemoveAllValue")
end)
local function OpenMenu()
    ESX.TriggerServerCallback(GetCurrentResourceName()..":HasPermission",function ()
        
        ESX.TriggerServerCallback(GetCurrentResourceName()..":GetValues",function(result)
            table.insert(result,SaveElement)
            ESX.UI.Menu.CloseAll();
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MENUSKIN', {
                title = 'Skin',
                align = 'top-left',
                elements =result
            }, function (data,menu)
                TriggerEvent("skinchanger:loadSkin",data.current.value, function()
                end)
                TriggerServerEvent('esx_skin:save', data.current.value)
                
            end,function (data,menu)
                menu.close()
            end)
        end)
    end)
end
RegisterCommand("pedMenu", function(source, args, raw)OpenMenu()end)
