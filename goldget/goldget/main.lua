local tArgs = {...}
local pklf = fs.open(".pk","w")
if not fs.exists(".pk") then
	pkl = {}
	pklf.write(textutils.serialize(pkl))
end
local resp = http.get("https://raw.githubusercontent.com/EverythingEli/goldcore/master/goldget/list.lua",nil,true)
function table.contains(table, element)   for _, value in pairs(table) do     if value == element then       return true     end   end   return false end
local lstf = fs.open("list.lua","w")
lstf.write(resp.readAll())
resp.close()
lstf.close()
local lst = dofile("list.lua")
fs.delete("list.lua")
if not table.contains(lst,tArgs[1]) then
	print("Could not find package!")
	pklf.close()
else
	print("Package exists!")
	pklf.close()
	--local pklfr = fs.open(".pk","r")
	--local pkl = textutils.unserialize(pklfr.readAll())
	--pklfr.close()
	print("Installing "..tArgs[1].."...")
	--if not table.contains(pkl,tArgs[1]) then
	--	pkl[#pkl+1] = tArgs[1]
	--	local pklfw = fs.open(".pk","w")
	--	pklfw.write(textutils.serialize(pkl))
	--	print("Installed "..tArgs[1])
	--else
	--	print("Package already installed!")
	--end
	local pkgget = http.get("https://raw.githubusercontent.com/EverythingEli/goldcore/master/goldget/"..tArgs[1].."/main.lua")
	if not fs.exists("/pkg") then
		fs.makeDir("/pkg")
	end
	if not fs.exists("/pkg/"..tArgs[1]) then
		fs.makeDir("/pkg/"..tArgs[1])
	end
	local f = fs.open("pkg/"..tArgs[1].."/main.lua","w")
	f.write(pkgget.readAll())
	pkgget.close()
	f.close()
	print("Package updated/installed!")
end
