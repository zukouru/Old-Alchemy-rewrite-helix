function tablelength(T)
	local count = 0
	for k,v in pairs(T) do if(k != 'Receta') then count = count + 1 end end
	return count
end


function pompion(NTab, cauldronPos)
    if
    (
        (NTab["Mariposa revoloteadora"] != nil && NTab["Mariposa revoloteadora"] == 1) 
        && (NTab["Dedalera"] != nil && NTab["Dedalera"] == 1) 
        && (NTab["Bulbo rebotador"] != nil && NTab["Bulbo rebotador"] == 1)
        && (tablelength(NTab) == 3) 
    )
    then 
        local table = {}
        table["status"] = "Well"
        ix.item.Spawn('pompion', cauldronPos, nil, angle_zero, table)
        return true
    
    else 
        if (
           ((NTab["Mariposa revoloteadora"] != nil && NTab["Mariposa revoloteadora"] > 0) 
           || (NTab["Dedalera"] != nil && NTab["Dedalera"] > 0) 
           || (NTab["Bulbo rebotador"] != nil && NTab["Bulbo rebotador"] > 0))
           && (tablelength(NTab) == 3)
        ) 
        then
            local table2 = {}
            table2["status"] = "Bad"
            ix.item.Spawn('pompion', cauldronPos, nil, angle_zero, table2)
            return true
        else
            if(NTab["Receta"] != nil) then
                local table3 = {}
                table3["status"] = "Bad"
                ix.item.Spawn('pompion', cauldronPos, nil, angle_zero, table3)
                return true
            else
                return false
            end
        end
    end
end

function antidoteCommonPoison(NTab, cauldronPos)
    if
    (
        (NTab["Bezoar"] != nil && NTab["Bezoar"] == 4) 
        && (NTab["Ingrediente estandar"] != nil && NTab["Ingrediente estandar"] == 2) 
        && (NTab["Cuerno de unicornio"] != nil && NTab["Cuerno de unicornio"] == 1)
        && (NTab["Bayas de muerdago"] != nil && NTab["Bayas de muerdago"] == 2)
        && (tablelength(NTab) == 4) 
    )
    then 
        local table = {}
        table["status"] = "Well"
        ix.item.Spawn('antidote_for_common_poison', cauldronPos, nil, angle_zero, table)
        return true
    
    else 
        if (
           ((NTab["Bezoar"] != nil && NTab["Bezoar"] > 0) 
           || (NTab["Ingrediente estandar"] != nil && NTab["Ingrediente estandar"] > 0) 
           || (NTab["Cuerno de unicornio"] != nil && NTab["Cuerno de unicornio"] > 0)
           || (NTab["Bayas de muerdago"] != nil && NTab["Bayas de muerdago"] > 0))
           && (tablelength(NTab) == 4)
        ) 
        then
            local table2 = {}
            table2["status"] = "Bad"
            ix.item.Spawn('antidote_for_common_poison', cauldronPos, nil, angle_zero, table2)
            return true
        else
            if(NTab["Receta"] != nil) then
                local table3 = {}
                table3["status"] = "Bad"
                ix.item.Spawn('antidote_for_common_poison', cauldronPos, nil, angle_zero, table3)
                return true
            else
                return false
            end
        end
    end
end

function wiggenweld(NTab, cauldronPos)
    if
    (
        (NTab["Sangre de salamandra"] != nil && NTab["Sangre de salamandra"] == 5) 
        && (NTab["Espinas de pez leon"] != nil && NTab["Espinas de pez leon"] == 2) 
        && (NTab["Mandragora cocida"] != nil && NTab["Mandragora cocida"] == 3)
        && (NTab["Aguamiel"] != nil && NTab["Aguamiel"] == 1)
        && (NTab["Mucosidad de gusarajo"] != nil && NTab["Mucosidad de gusarajo"] == 1)
        && (tablelength(NTab) == 5) 
    )
    then 
        local table = {}
        table["status"] = "Well"
        ix.item.Spawn('wiggenweld', cauldronPos, nil, angle_zero, table)
        return true
    
    else 
        if (
           ((NTab["Sangre de salamandra"] != nil && NTab["Sangre de salamandra"] > 0) 
           || (NTab["Espinas de pez leon"] != nil && NTab["Espinas de pez leon"] > 0) 
           || (NTab["Mucosidad de gusarajo"] != nil && NTab["Mucosidad de gusarajo"] > 0)
           || (NTab["Aguamiel"] != nil && NTab["Aguamiel"] > 0)
           || (NTab["Mandragora cocida"] != nil && NTab["Mandragora cocida"] > 0))
           && (tablelength(NTab) == 5)
        ) 
        then
            local table2 = {}
            table2["status"] = "Bad"
            ix.item.Spawn('wiggenweld', cauldronPos, nil, angle_zero, table2)
            return true
        else
            if(NTab["Receta"] != nil) then
                local table3 = {}
                table3["status"] = "Bad"
                ix.item.Spawn('wiggenweld', cauldronPos, nil, angle_zero, table3)
                return true
            else
                return false
            end
        end
    end
end

function boilCure1(NTab, cauldronPos)
    if(
        (NTab["Colmillos de serpientes"] != nil && NTab["Colmillos de serpientes"] == 10) 
        && ( NTab["Babosa cornuda"] && NTab["Babosa cornuda"] == 4) 
        && ( NTab["Puas de puercoespin"] != nil && NTab["Puas de puercoespin"] == 2) 
        && tablelength(NTab) == 3 
    ) then 
        local table = {}
        table["status"] = "Well"
        ix.item.Spawn('boil_cure', cauldronPos, nil, angle_zero, table)
        return true
    else
        if (
            ((NTab["Colmillos de serpientes"] != nil && NTab["Colmillos de serpientes"] > 0) 
            ||(NTab["Babosa cornuda"] != nil && NTab["Babosa cornuda"] > 0) 
            ||(NTab["Puas de puercoespin"] != nil && NTab["Puas de puercoespin"] > 0)) 
            && tablelength(NTab) == 3
        ) then
            local table2 = {}
            table2["status"] = "Bad"
            ix.item.Spawn('boil_cure', cauldronPos, nil, angle_zero, table2)
            return true
        else
            if(NTab["Receta"] != nil) then
                local table3 = {}
                table3["status"] = "Bad"
                ix.item.Spawn('boil_cure', cauldronPos, nil, angle_zero, table3)
                return true
            else
                return false
            end
        end
    end
end

function boilCure2(NTab, cauldronPos)
    if(
        ( NTab["Colmillos de serpientes"] != nil && NTab["Colmillos de serpientes"] == 1) 
        && (NTab["Babosa cornuda"] != nil && NTab["Babosa cornuda"] == 1) 
        && (NTab["Puas de puercoespin"] != nil && NTab["Puas de puercoespin"] == 1) 
        && (NTab["Cebolla maloliente"] != nil && NTab["Cebolla maloliente"] == 1) 
        && (NTab["Hoja de ortiga"] != nil && NTab["Hoja de ortiga"] == 1) 
        && (NTab["Mucosidad de gusarajo"] != nil && NTab["Mucosidad de gusarajo"] == 1) 
        && (NTab["Gengibre"] != nil && NTab["Gengibre"] == 1) 
        && (NTab["Espinas de shrake"] != nil && NTab["Espinas de shrake"] == 1) 
        && tablelength(NTab) == 8 
     ) then 
        local table = {}
        table["status"] = "Well"
        ix.item.Spawn('boil_cure', cauldronPos, nil, angle_zero, table)
        return true
    else
        if (
            (( NTab["Colmillos de serpientes"] != nil && NTab["Colmillos de serpientes"] > 0) 
            ||  (NTab["Babosa cornuda"] != nil && NTab["Babosa cornuda"] > 0) 
            || (NTab["Puas de puercoespin"] != nil && NTab["Puas de puercoespin"] > 0)
            || (NTab["Cebolla maloliente"] != nil && NTab["Cebolla maloliente"] > 0) 
            || (NTab["Hoja de ortiga"] != nil && NTab["Hoja de ortiga"] > 0) 
            || (NTab["Mucosidad de gusarajo"] != nil && NTab["Mucosidad de gusarajo"] > 0) 
            || (NTab["Gengibre"] != nil && NTab["Gengibre"] > 0) 
            || (NTab["Espinas de shrake"] != nil && NTab["Espinas de shrake"] > 1))
            && tablelength(NTab) == 8 
        ) then
            local table2 = {}
            table2["status"] = "Bad"
            ix.item.Spawn('boil_cure', cauldronPos, nil, angle_zero, table2)
            return true
        else
            if(NTab["Receta"] != nil) then
                local table3 = {}
                table3["status"] = "Bad"
                ix.item.Spawn('boil_cure', cauldronPos, nil, angle_zero, table3)
                return true
            else
                return false
            end
            
        end
    end
end

function potion(NTab, cauldronPos)
   
    ix.item.Spawn('potion', cauldronPos)
    return true
end


function spawnPotion(NTab, NEnt)
    local cauldronPos = NEnt:GetPos() + Vector(0,0,50)

    if(NTab["Receta"] != nil) then
        local case = {
            ["pompion"] = pompion,
            ["boilCure1"] = boilCure1,
            ["boilCure2"] = boilCure2,
            ["wiggenweld"] = wiggenweld,
            ["antidoteCommonPoison"] = antidoteCommonPoison,
        }
        local recipe = case[NTab["Receta"].name]
        if(recipe) then
           return recipe(NTab,cauldronPos)
        end
    else
        

        if (boilCure1(NTab, cauldronPos)) then return end
        if (pompion(NTab, cauldronPos)) then return end
        if (boilCure2(NTab, cauldronPos)) then return end
        if (wiggenweld(NTab, cauldronPos)) then return end
        if (antidoteCommonPoison(NTab, cauldronPos)) then return end

        
        if(potion(NTab, cauldronPos)) then return end
    end
end
