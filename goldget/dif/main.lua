local t = {}
for i = 1,#fs.list("/") do
  if fs.isDir(fs.list("/")[i]) then
  else
    local f = fs.open(fs.list("/")[i],"r")
    t[#t+1] = f.readAll()
    f.close()
  end
end
local diff = fs.open("img.dif","w")
diff.write(textutils.serialise(t))
diff.close()
