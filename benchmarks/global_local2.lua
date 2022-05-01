local start = os.clock()
for i = 1, 1000000 do
    local x = math.sin(i)
end
print("Global")
print(string.format("%1.10f s", os.clock() - start))
start = os.clock()
local sin = math.sin
for i = 1, 1000000 do
    local x = sin(i)
end
print("Local")
print(string.format("%1.10f s", os.clock() - start))
