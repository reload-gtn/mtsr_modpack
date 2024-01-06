--additions for techage mod
dofile(minetest.get_modpath("tech_additions") .. "/techage.lua")

--additions for multidecor package
if minetest.get_modpath("craft_ingredients") then
dofile(minetest.get_modpath("tech_additions") .. "/multidecor.lua")
end

--additions for basic_materials mod
dofile(minetest.get_modpath("tech_additions") .. "/basic_materials.lua")

--add air block
dofile(minetest.get_modpath("tech_additions") .. "/airblock.lua")

--additions for moreores
if minetest.get_modpath("moreores") then
dofile(minetest.get_modpath("tech_additions") .. "/moreores.lua")
end

--add extra cobble
dofile(minetest.get_modpath("tech_additions") .. "/extra_cobble.lua")

--additions for moreores
if minetest.get_modpath("jonez") then
    dofile(minetest.get_modpath("tech_additions") .. "/jonez.lua")
end