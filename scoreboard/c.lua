score = {
	pos = {},
	players = {},
	s = Vector2(guiGetScreenSize()),
	font = dxCreateFont("font.ttf",scale(14,false)*2,false,"antialiased"),
	font2 = dxCreateFont("font.ttf",scale(13,false)*2,false,"antialiased"),
	font3 = dxCreateFont("font.ttf",scale(50,false)*2,false,"antialiased"),
	font4 = dxCreateFont("font.ttf",scale(20,false)*2,false,"antialiased"),
	tex = {
		[1] = dxCreateTexture("img/1.png","dxt5",true,"clamp"),
		[2] = dxCreateTexture("img/2.png","dxt5",true,"clamp"),
		[3] = dxCreateTexture("img/3.png","dxt5",true,"clamp"),
		[4] = dxCreateTexture("img/4.png","dxt5",true,"clamp"),
	},
	key = 0,
	open = false,
	alpha = 0,
	max = 32,
}

function wordWrap(text, maxwidth, scale, font, colorcoded)
    local lines = {}
    local words = split(text, " ")
    local line = 1
    local word = 1
    local endlinecolor
    while (words[word]) do
        repeat
            if colorcoded and (not lines[line]) and endlinecolor and (not string.find(words[word], "^#%x%x%x%x%x%x")) then
                lines[line] = endlinecolor
            end
            lines[line] = lines[line] or ""
            if colorcoded then
                local rw = string.reverse(words[word])
                local x, y = string.find(rw, "%x%x%x%x%x%x#")
                if x and y then
                    endlinecolor = string.reverse(string.sub(rw, x, y))
                end
            end
            lines[line] = lines[line]..words[word]
            lines[line] = lines[line]
            word = word + 1
        until ((not words[word]) or dxGetTextWidth(lines[line].." "..words[word], scale, font, colorcoded) > maxwidth)
    
        lines[line] = string.sub(lines[line], 1, -2)
        if colorcoded then
            lines[line] = string.gsub(lines[line], "#%x%x%x%x%x%x$", "")
        end
        line = line + 1
    end
    return lines
end

score["pos"]["bg"] = {(score["s"]["x"]/2)-scale(760)/2,score["s"]["y"]*0.10,scale(760,true),scale(175,true)}
score["pos"]["bar"] = {score["pos"]["bg"][1]+scale(11),score["pos"]["bg"][2]+score["pos"]["bg"][4]+scale(6),scale(738,true),scale(40,true)}
score["pos"]["tid"] = {score["pos"]["bar"][1]+scale(9),score["pos"]["bar"][2]+scale(10),scale(63,true),scale(21,true)}
score["pos"]["tnick"] = {score["pos"]["bar"][1]+scale(87),score["pos"]["bar"][2]+scale(10),scale(138,true),scale(21,true)}
score["pos"]["ping"] = {score["pos"]["bar"][1]+scale(238),score["pos"]["bar"][2]+scale(8),scale(22,true),scale(22,true)}
score["pos"]["torg"] = {score["pos"]["bar"][1]+scale(296),score["pos"]["bar"][2]+scale(10),scale(266,true),scale(21,true)}
score["pos"]["tfra"] = {score["pos"]["bar"][1]+score["pos"]["bar"][3]-scale(150),score["pos"]["bar"][2]+scale(10),scale(141,true),scale(21,true)}
score["pos"]["search"] = {score["pos"]["bg"][1]+score["pos"]["bg"][3]-scale(254),score["pos"]["bg"][2]+scale(47),scale(218,true),scale(27,true)}
score["pos"]["arrow"] = {score["pos"]["bar"][1]+score["pos"]["bar"][3]-scale(43),score["pos"]["bar"][2]+scale(433),scale(36,true),scale(36,true)}
score["pos"]["count"] = {score["pos"]["bg"][1]+scale(132),score["pos"]["bg"][2]+scale(32),scale(44,true),scale(65,true)}
score["pos"]["max"] = {score["pos"]["bg"][1]+scale(132),score["pos"]["bg"][2]+scale(38),scale(44,true),scale(65,true)}
score["pos"]["logo"] = {(score["s"]["x"]/2)-scale(185)/2,score["pos"]["bg"][2],scale(185),scale(175)}


score.render = function()
	if score["alpha"]<255 then
		score["alpha"]=score["alpha"]+4
		if score["alpha"]>255 then
			score["alpha"]=255
		end
	end
	local width = dxGetTextWidth(#score["players"],0.5,score["font3"],false)
	dxDrawImage(score["pos"]["bg"][1],score["pos"]["bg"][2],score["pos"]["bg"][3],score["pos"]["bg"][4], "img/bg.png", 0, 0, 0, tocolor(255, 255, 255, score["alpha"]), false)
	dxDrawImage(score["pos"]["logo"][1],score["pos"]["logo"][2],score["pos"]["logo"][3],score["pos"]["logo"][4], "img/logo.png", 0, 0, 0, tocolor(255, 255, 255, score["alpha"]), false)
	dxDrawText(#score["players"], score["pos"]["count"][1],score["pos"]["count"][2],score["pos"]["count"][3]+score["pos"]["count"][1],score["pos"]["count"][4]+score["pos"]["count"][2], tocolor(255, 255, 255, score["alpha"]), 0.5, score["font3"], "left", "center", false, false, false, false, false)
	dxDrawText("/"..score["max"], score["pos"]["max"][1]+width,score["pos"]["max"][2],(score["pos"]["max"][3]+score["pos"]["max"][1])+width,score["pos"]["max"][4]+score["pos"]["max"][2], tocolor(150, 150, 150, score["alpha"]), 0.5, score["font4"], "right", "center", false, false, false, false, false)
	score["offset"] = 0
	count = 0
	for i=1,#score["players"] do
		if i<=10 then
			i=i+score["key"]
			if score["players"][i] then
				if #exports["th_edit"]:editGetText(score["search"])>0 then
                	score["find"]=exports["th_edit"]:editGetText(score["search"])
	            else
	                score["find"]=""
	            end
	            if string.find(string.upper(score["players"][i]["name"]),string.upper(score["find"])) then
					dxDrawImage(score["pos"]["bar"][1],score["pos"]["bar"][2]+score["offset"],score["pos"]["bar"][3],score["pos"]["bar"][4], "img/bar.png", 0, 0, 0, tocolor(255, 255, 255, score["alpha"]), false)
					dxDrawText(score["players"][i]["id"], score["pos"]["tid"][1],score["pos"]["tid"][2]+score["offset"],score["pos"]["tid"][3]+score["pos"]["tid"][1],score["pos"]["tid"][4]+score["pos"]["tid"][2]+score["offset"], tocolor(255, 255, 255, score["alpha"]), 0.5, score["font"], "center", "center", false, false, false, false, false)
					if #wordWrap(score["players"][i]["name"],score["pos"]["tnick"][3],0.5,score["font"],false)>1 then
						dxDrawText(score["players"][i]["name"], score["pos"]["tnick"][1],score["pos"]["tnick"][2]+score["offset"],score["pos"]["tnick"][3]+score["pos"]["tnick"][1],score["pos"]["tnick"][4]+score["pos"]["tnick"][2]+score["offset"], tocolor(255, 255, 255, score["alpha"]), 0.5, score["font2"], "left", "center", false, true, false, false, false)
					else
						dxDrawText(score["players"][i]["name"], score["pos"]["tnick"][1],score["pos"]["tnick"][2]+score["offset"],score["pos"]["tnick"][3]+score["pos"]["tnick"][1],score["pos"]["tnick"][4]+score["pos"]["tnick"][2]+score["offset"], tocolor(255, 255, 255, score["alpha"]), 0.5, score["font"], "left", "center", false, true, false, false, false)
					end
					if getPlayerPing(score["players"][i]["element"])>=1000 then
		                ping=score["tex"][1]
		            elseif getPlayerPing(score["players"][i]["element"])>=500 then
		                ping=score["tex"][2]
		            elseif getPlayerPing(score["players"][i]["element"])>=100 then
		                ping=score["tex"][3]
		            elseif getPlayerPing(score["players"][i]["element"])>=1 then
		                ping=score["tex"][4]
		            end
					dxDrawImage(score["pos"]["ping"][1],score["pos"]["ping"][2]+score["offset"],score["pos"]["ping"][3],score["pos"]["ping"][4], ping, 0, 0, 0, tocolor(255, 255, 255, score["alpha"]), false)
					if #wordWrap(score["players"][i]["org"],score["pos"]["torg"][3],0.5,score["font"],false)>1 then
						dxDrawText(score["players"][i]["org"], score["pos"]["torg"][1],score["pos"]["torg"][2]+score["offset"],score["pos"]["torg"][3]+score["pos"]["torg"][1],score["pos"]["torg"][4]+score["pos"]["torg"][2]+score["offset"], tocolor(255, 255, 255, score["alpha"]), 0.5, score["font2"], "right", "center", false, true, false, false, false)
					else
						dxDrawText(score["players"][i]["org"], score["pos"]["torg"][1],score["pos"]["torg"][2]+score["offset"],score["pos"]["torg"][3]+score["pos"]["torg"][1],score["pos"]["torg"][4]+score["pos"]["torg"][2]+score["offset"], tocolor(255, 255, 255, score["alpha"]), 0.5, score["font"], "right", "center", false, true, false, false, false)
					end
					dxDrawText(score["players"][i]["fra"], score["pos"]["tfra"][1],score["pos"]["tfra"][2]+score["offset"],score["pos"]["tfra"][3]+score["pos"]["tfra"][1],score["pos"]["tfra"][4]+score["pos"]["tfra"][2]+score["offset"], tocolor(255, 255, 255, score["alpha"]), 0.5, score["font"], "center", "center", false, false, false, false, false)
					score["offset"]=score["offset"]+scale(42)
				end
			end
		end
	end
	--[[if #score["players"]>10 then
		if #exports["th_edit"]:editGetText(score["search"])>0 then
			for k,v in ipairs(score["players"])do
				if string.find(string.upper(score["players"][k]["name"]),string.upper(score["find"])) then
					count=count+1
				end
			end
			if count>10 then
				if score["key"]<#score["players"]-10 then
					dxDrawImage(score["pos"]["arrow"][1],score["pos"]["arrow"][2],score["pos"]["arrow"][3],score["pos"]["arrow"][4], "img/arrow.png", 0, 0, 0, tocolor(1, 0, 0, 121), false)
				end
			end
		else
			if score["key"]<#score["players"]-10 then
				dxDrawImage(score["pos"]["arrow"][1],score["pos"]["arrow"][2],score["pos"]["arrow"][3],score["pos"]["arrow"][4], "img/arrow.png", 0, 0, 0, tocolor(1, 0, 0, 121), false)
			end
		end
	end]]--
end





addEventHandler("onClientKey",root,function(key,state)
	if key=="tab" and state then
		if not score["open"] then
			for _,v in ipairs(getElementsByType("player"))do
				local id=getElementData(v,"id") or math.random(100,999)
				local org=getElementData(v,"org") or "---"
				local frakcja=getElementData(v,"frakcja") or "---"
				table.insert(score["players"],{id=id,name=getPlayerName(v),element=v,org=org,fra=frakcja})
			end
			table.sort(score["players"], function(a, b) return a.id < b.id end )
			setElementData(localPlayer,"blur",true)
			addEventHandler("onClientRender",root,score.render)
			score["open"]=true
			score["search"]=exports["th_edit"]:createCustomEdit("",score["pos"]["search"][1],score["pos"]["search"][2],score["pos"]["search"][3],score["pos"]["search"][4],true,"Znajdź gracza...",false,"font2",{105, 98, 239,255},{255,255,255,255},{0,0,0,40},{255,255,255,255},true,20,15)
            showCursor(true)
		else
			if not exports["th_edit"]:isActive(score["search"]) then
				removeEventHandler("onClientRender",root,score.render)
				setElementData(localPlayer,"blur",false)
				score["open"]=false
				score["players"] = {}
				exports["th_edit"]:destroyCustomEdit(score["search"])
				showCursor(false)
				score["alpha"]=0
			end
		end
	elseif key=="mouse_wheel_down" and state then
        if #score["players"]>10 then
            if score["key"]<#score["players"]-10 then
                score["key"]=score["key"]+1
            end
        end
    elseif key=="mouse_wheel_up" and state then
        if score["key"]>0 then
            score["key"]=score["key"]-1
        end 
	end
end)