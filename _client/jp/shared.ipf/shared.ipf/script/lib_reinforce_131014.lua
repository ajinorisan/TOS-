---- lib_reinforce_131014.lua
function IS_MORU_FREE_PRICE(moruItem)
    if moruItem == nil then
        return false;
    end

    if moruItem.ClassName == "Moru_Silver" 
        or moruItem.ClassName == "Moru_Silver_test" 
        or moruItem.ClassName == "Moru_Silver_NoDay" 
        or moruItem.ClassName == "Moru_Silver_TA" 
        or moruItem.ClassName == "Moru_Silver_TA2" 
        or moruItem.ClassName == "Moru_Silver_Event_1704" 
        or moruItem.ClassName == 'Moru_Silver_TA_Recycle' 
        or moruItem.ClassName == 'Moru_Silver_TA_V2' 
        or moruItem.ClassName == "Moru_Gold_TA"        
		or moruItem.ClassName == "Moru_Gold_TA_NR"
		or moruItem.ClassName == "Moru_Gold_TA_NR_Team_Trade"
        or moruItem.ClassName == "Moru_Gold_EVENT_1710_NEWCHARACTER"
        or moruItem.ClassName == "Moru_Event160609" 
        or moruItem.ClassName == "Moru_Event160929_14d" 
        or moruItem.ClassName == "Moru_Potential" 
        or moruItem.ClassName == "Moru_Potential14d"
        or moruItem.StringArg == 'SILVER'
        or moruItem.ClassName == 'Moru_Silver_Team'
        or moruItem.ClassName == 'Moru_Silver_Team_event1909'
        or moruItem.ClassName == 'Moru_Ruby_noCharge'
        or TryGetProp(moruItem, 'StringArg2', 'None') == 'free_Moru'
        then
        return true;
    end

    return false;
end

function IS_MORU_DISCOUNT_50_PERCENT(moruItem)
    if moruItem == nil then
        return false;
    end

    if moruItem.ClassName == "Moru_Platinum_Premium" 
     or moruItem.StringArg ==  'Reinforce_Discount_50' then
        return true;
    end

    return false;
end

-- 포텐션 0인 장비에만 사용가능한 모루 확인, 뒤에 타입이 추가됨
function IS_MORU_NOT_DESTROY_TARGET_ITEM(moruItem)
    if moruItem == nil then
        return false, 'None';
    end

    if moruItem.ClassName == "Moru_Premium" 
        or moruItem.ClassName == "Moru_Gold" 
        or moruItem.ClassName == "Moru_Gold_14d" 
        or moruItem.ClassName == "Moru_Gold_TA" 
		or moruItem.ClassName == "Moru_Gold_TA_NR" 
		or moruItem.ClassName == "Moru_Gold_TA_NR_Team_Trade" 
        or moruItem.ClassName == "Moru_Gold_Team_Trade" 
        or moruItem.ClassName == "Moru_Gold_14d_Team" 
        or moruItem.ClassName == "Moru_Gold_EVENT_1710_NEWCHARACTER"
        or moruItem.ClassName == "Moru_Gold_14d_Team_event1909" 
        or moruItem.StringArg == 'gold_Moru' 
        or moruItem.StringArg == 'blessed_gold_Moru' then
        return true, 'gold';
    end

    if moruItem.StringArg == 'unique_gold_Moru' or moruItem.StringArg == 'blessed_ruby_Moru' then
        return true, 'ruby'
    end

    -- if moruItem.StringArg == 'Event_LuckyBreak_Moru' then
    --     return true, 'Event_LuckyBreak_Moru'
    -- end
    
    return false, 'None';
end

-- IS_MORU_NOT_DESTROY_TARGET_ITEM 함수에 통합됨
-- function IS_MORU_NOT_DESTROY_TARGET_UNIQUE_ITEM(moruItem)
--     if moruItem == nil then
--         return false;
--     end

--     if moruItem.StringArg == 'unique_gold_Moru' or moruItem.StringArg == 'gold_Moru' then
--         return true;
--     end

--     return false;
-- end

function REINFORCE_ABLE_131014(item, moru_item)              
    if item.ItemType ~= 'Equip' then
        return 0;
    end
    
    if item.Reinforce_Type ~= "Moru" or item.LifeTime > 0 then
        return 0;
    end
    
    -- -- Event_LuckyBreak
    -- local moruStrArg = TryGetProp(moru_item, "StringArg", "None");
    -- local itemStrArg = TryGetProp(item, "StringArg", "None");
    -- if moruStrArg == "Event_LuckyBreak_Moru" then
    --     if itemStrArg ~= "Event_LuckyBreak_Equip" then
    --         return 0;
    --     end
    -- else
    --     if itemStrArg == "Event_LuckyBreak_Equip" then
    --         return 0;
    --     end        
    -- end

    local prop = TryGetProp(item, "BasicTooltipProp");    
    if prop == nil then
        return 0;
    end
    
    if prop ~= 'DEF' and prop ~= 'MDEF' and prop ~= 'ADD_FIRE' and prop ~= 'ADD_ICE' and prop ~= 'ADD_LIGHTNING' and prop ~= 'DEF;MDEF' and prop ~= 'ATK;MATK' and prop ~= 'MATK' and prop ~= 'ATK' then    
        return 0;
    end
    
    local reinforceValue = TryGetProp(item, "Reinforce_2");
    if reinforceValue == nil or reinforceValue >= 40 then
        return 0;
    end

    if moru_item ~= nil then
        local str = TryGetProp(moru_item, 'StringArg', 'None')
        local item_str = TryGetProp(item, 'StringArg', 'None')    
        if item_str == 'Moru_goddess' and string.find(str, 'Certificate') == nil then
            return 0
        end

        if string.find(str, 'Certificate') ~= nil then        
            if TryGetProp(moru_item, 'NumberArg1', 0) < TryGetProp(item, 'UseLv', 0) then
                return 0
            end
        end
    end

    return 1;
end

function REINFORCE_ABLE_BY_USE_LEVEL(moru, item)
    if moru == nil or item == nil then
        return false
    end

    if moru.ClassName == 'Moru_Diamond_14d_Team_Lv400' then
        if item.UseLv > 400 then
            return false
        end
    end
    
    if moru.ClassName == 'Moru_Diamond_14d_Team_Lv430' then
        if item.UseLv > 440 then
            return false
        end
    end

    if moru.ClassName == 'Moru_Diamond_30d_Team_Lv440' then
        if item.UseLv > 440 then
            return false
        end
    end
    
    if moru.ClassName == 'Moru_Diamond_30d_Team_Lv450' then
        if item.UseLv > 450 then
            return false
        end
    end
    
    return true
end

function GET_REINFORCE_PRICE(fromItem, moruItem, pc)
    local reinforcecount = TryGetProp(fromItem, "Reinforce_2");
    if reinforcecount == nil then
        return 0;
    end

    -- -- Event_LuckyBreak
    -- local moruStrArg = TryGetProp(moruItem, "StringArg", "None");
    -- if ENABLE_EVENT_LUCKYBREAK_REINFOCE(fromItem, moruStrArg) == true then        
    --     return 0;
    -- end
    
    local reinforcecount_diamond = reinforcecount - 1;

    if reinforcecount_diamond < 0 then
        reinforcecount_diamond = 0;
    end
    
    local slot = TryGetProp(fromItem, "DefaultEqpSlot");
    if slot == nil then
        return 0;
    end
    
    local grade = TryGetProp(fromItem, "ItemGrade");
    if grade == nil then
        return 0;
    end
    
    local gradeRatio = SCR_GET_ITEM_GRADE_RATIO(grade, "ReinforceCostRatio");    
    
    local lv = TryGetProp(fromItem, "UseLv");
    if lv == nil then
        return 0;
    end
    
    if (GetServerNation() == "KOR" and (GetServerGroupID() == 9001 or GetServerGroupID() == 9501)) then
        local kupoleItemLv = SRC_KUPOLE_GROWTH_ITEM(fromItem, 0);
        if kupoleItemLv ==  nil then
            lv = lv;
        elseif kupoleItemLv > 0 then
            lv = kupoleItemLv;
        end
    end
    
    local pcBangItemLevel = CALC_PCBANG_GROWTH_ITEM_LEVEL(fromItem);
    if pcBangItemLevel ~= nil then
        lv = pcBangItemLevel;
    end
    
    local value, value_diamond = 0, 0;

    local priceRatio = 1;

    if slot == 'RH' or slot == 'RH LH' then
        if fromItem.DBLHand == 'YES' then
            priceRatio = 1.2;
        else
            priceRatio = 1;
        end
    elseif slot == 'LH' or slot == 'LH RH' then
        if fromItem.ClassType == 'Shield' then
            priceRatio = 0.8;
        elseif TryGetProp(fromItem, 'ClassType', 'None') == 'Trinket' then
            priceRatio = 0.6    
        else
            priceRatio = 0.8;
        end
    elseif slot == 'SHIRT' or slot == 'PANTS' or slot == 'GLOVES' or slot == 'BOOTS' then
        priceRatio = 0.75;
    elseif slot == 'NECK' or slot == 'RING' then
        priceRatio = 0.5;    
    else
        return 0;
    end

    if is_goddess_moru(moruItem) == true then
        lv = 500
        priceRatio = 1.0
    end
    
    value = math.floor((500 + (lv ^ 1.1 * (5 + (reinforcecount * 2.5)))) * (2 + (math.max(0, reinforcecount - 9) * 0.5))) * priceRatio * gradeRatio;
    value_diamond = math.floor((500 + (lv ^ 1.1 * (5 + (reinforcecount_diamond * 2.5)))) * (2 + (math.max(0, reinforcecount - 9) * 0.5))) * priceRatio * gradeRatio;
    
    if IS_MORU_DISCOUNT_50_PERCENT(moruItem) == true then
        value = value / 2;
    end
    
    if IS_MORU_FREE_PRICE(moruItem) == true then
        value = 0;
    end
    
    if moruItem.StringArg == 'DIAMOND' and reinforcecount > 1 then
        value = value + (value_diamond * 2.1)
    end

    -- 440레벨 장비 부터는 item_IncreaseCost.xml 테이블의 영향을 받아 비용 증가
    local IncreaseRatio = nil
    if lv >= 440 then
        local Cls = GetClassByNumProp("IncreaseCost", "UseLv", lv)
        if Cls ~= nil then
            IncreaseRatio = TryGetProp(Cls, "ReinforcePriceRatio", 1)
        end
    end
    if IncreaseRatio ~= nil then        
        value = value * IncreaseRatio
    end
    ---------------------
    
    -- EVENT_1903_WEEKEND
    --if SCR_EVENT_1903_WEEKEND_CHECK('REINFORCE', isServer) == 'YES' then
    --    value = value/2
    --end
    
    --burning_event
    if IsBuffApplied(pc, "Event_Reinforce_Discount_50") == "YES" then
        value = value/2
    end

    --steam_new_world
    -- if IsBuffApplied(pc, "Event_Steam_New_World_Buff") == "YES" then
    --     value = value/2
	-- end
    -- pvp템의 강화 비용 1/10로
    if TryGetProp(fromItem, 'StringArg', 'None') == 'FreePvP' then
        value = value * 0.1        
    end

    -- 축복받은 루비 모루 가격 30% 인하
    if TryGetProp(moruItem, 'StringArg', 'None') == 'blessed_ruby_Moru' and IsBuffApplied(pc, "Event_Reinforce_Discount_50") == "NO" then
        value = value * 0.7        
    end

    -- 축복받은 황금 모루 가격 50% 인하
    if TryGetProp(moruItem, 'StringArg', 'None') == 'blessed_gold_Moru' and IsBuffApplied(pc, "Event_Reinforce_Discount_50") == "NO" then 
        value = value * 0.5    
    end

    if is_goddess_moru(moruItem) == true then
        value = value * 0.04
    end
    
    return SyncFloor(value);

end

function GET_REINFORCE_HITCOUNT(fromItem, moru)
    -- -- Event_LuckyBreak
    -- local moruStrArg = TryGetProp(moru, "StringArg", "None");
    -- if ENABLE_EVENT_LUCKYBREAK_REINFOCE(fromItem, moruStrArg) == true then        
    --     return 5;
    -- end

    return 3;
end

function ENABLE_EVENT_LUCKYBREAK_REINFOCE(invItem, moruType)
	-- if moruType == "Event_LuckyBreak_Moru" and TryGetProp(invItem, "StringArg", "None") == "Event_LuckyBreak_Equip" then
	-- 	return true;
	-- end

	return false;
end

function GET_REINFORCE_131014_SUCCESS_RATE(fromItem, moru)
	local curReinf = TryGetProp(fromItem, 'Reinforce_2', 0)
	local successRatio = 0;
	local classType = TryGetProp(fromItem , "ClassType", 'None')

    if TryGetProp(fromItem, 'StringArg', 'None') == 'Moru_goddess' then
        if curReinf < 5 then
    		return 100;
    	else
    	    successRatio = 100 - (curReinf - 4) * 4;
    	    successRatio = (successRatio / 100) ^ 3;
    	    successRatio = successRatio * 100;
    	    
    	    if successRatio < 51.2 then
    	        return 51.2;
    	    else
    	        return successRatio;
    	    end
    	end
    end

	if fromItem.GroupName == 'Weapon' or (fromItem.GroupName == 'SubWeapon' and  classType ~='Shield') then
    	if curReinf < 5 then
    		return 100;
    	else
    	    successRatio = 100 - (curReinf - 4) * 4;
    	    successRatio = (successRatio / 100) ^ 3;
    	    successRatio = successRatio * 100;
    	    
    	    if successRatio < 51.2 then
    	        return 51.2;
    	    else
    	        return successRatio;
    	    end
    	end
	else
		if curReinf < 5 then
    		return 100;
    	else
    	    successRatio = 100 - (curReinf - 2) * 4;
    	    successRatio = (successRatio / 100) ^ 3;
    	    successRatio = successRatio * 100;
    	    
    	    if successRatio < 51.2 then
    	        return 51.2;
    	    else
    	        return successRatio;
    	    end
		end
	end

	return 51.2;
end