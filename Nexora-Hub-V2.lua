
-- LOADER NEXORA CERTINHO - Carrega o arquivo grande em partes (fix Delta limite)
-- Coloque o arquivo NexoraHub_CERTINHO_FINAL.lua na pasta workspace do Delta

local path = "NexoraHub_CERTINHO_FINAL.lua"
if not isfile(path) then warn("Arquivo "..path.." nao encontrado!") return end
local content = readfile(path)
print("Carregando Nexora Certinho: "..#content.." bytes")
local ok, err = pcall(function() loadstring(content)() end)
if not ok then
    warn("ERRO: "..tostring(err))
    if setclipboard then setclipboard(tostring(err)) end
    writefile("Nexora_ERRO_CERTINHO.txt", tostring(err))
else
    print("NEXORA CARREGADO COM SUCESSO!")
end
