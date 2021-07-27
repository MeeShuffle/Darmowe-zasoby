local s=Vector2(guiGetScreenSize())
local font=dxCreateFont("font.ttf",(20/1920)*s.x,false,"antialiased")
local font2=dxCreateFont("font.ttf",(15/1920)*s.x,false,"antialiased")
local dgsfont=exports.dgs:dgsCreateFont("font.ttf",(16/1920)*s.x,false,"antialiased")
local dgsfont2=exports.dgs:dgsCreateFont("font.ttf",(13/1920)*s.x,false,"antialiased")
local zones={}
local file=fileOpen("version.txt")
local size=fileGetSize(file)
local ver=fileRead(file,size)
fileClose(file)

for i=1,3 do
    zones[i]=0
end
setPlayerHudComponentVisible("radar",false)
setPlayerHudComponentVisible("area_name",false)

local function skaluj(x,y,w,h)
    x=(x/1920)*s.x
    y=(y/1080)*s.y
    w=(w/1920)*s.x
    h=(h/1080)*s.y
    return x,y,w,h
end

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end



p={
    ["s1"]={skaluj(47, 259, 210, 200)},
    ["s2"]={skaluj(47, 572, 210, 200)},
    ["img1"]={skaluj(103, 296, 99, 99)},
    ["img2"]={skaluj(103, 607, 99, 99)},
    ["txt"]={skaluj(51, 401, 253, 441)},
    ["txt2"]={skaluj(51, 712, 253, 752)},
    ["img3"]={skaluj(591, 317, 1073, 411)},
    ["rec_login"]={skaluj(1067, 418, 402, 24)},
    ["rec_haslo"]={skaluj(694, 635, 532, 32)},
    ["b_zaloguj"]={skaluj(1087, 639, 138, 43)},
    ["b_close"]={skaluj(1311, 639, 138, 43)},
    ["tlo"]={skaluj(0,0,1920,1080)},
    ["line"]={skaluj(206, 928, 1509, 2)},
    ["podpis"]={skaluj(1483, 10, 1910, 53)},
}






addEventHandler("onClientResourceStart",resourceRoot,function()
    triggerServerEvent("open:login",localPlayer)
end)

addEvent("open:login",true)
addEventHandler("open:login",root,function(tabela)
    if source==localPlayer then
        open=false
        alpha=0
        showCursor(true)
        rank=tabela
        addEventHandler("onClientRender",root,render)
        sound=playSound("sound.mp3",true)
    end
end)


login_login = exports.dgs:dgsCreateEdit( (1087/1920)*s.x, (426/1080)*s.y, (362/1920)*s.x, (24/1080)*s.y, "", false,nil,tocolor(0,0,0,255),1,1,false,tocolor(0,0,0,0) )
exports.dgs:dgsEditSetHorizontalAlign(login_login,"center")
exports.dgs:dgsEditSetVerticalAlign(login_login,"center")
exports.dgs:dgsSetVisible(login_login,false)
exports.dgs:dgsSetProperty(login_login,"caretColor",tocolor(0,0,0,255))
exports.dgs:dgsEditSetPlaceHolder(login_login,"Podaj swój login...")
exports.dgs:dgsSetProperty(login_login,"placeHolderColor",tocolor(0,0,0,255))
exports.dgs:dgsSetProperty(login_login,"placeHolderFont",dgsfont2)


login_haslo = exports.dgs:dgsCreateEdit( (1087/1920)*s.x, (540/1080)*s.y, (362/1920)*s.x, (24/1080)*s.y, "", false,nil,tocolor(0,0,0,255),1,1,false,tocolor(0,0,0,0) )
exports.dgs:dgsEditSetHorizontalAlign(login_haslo,"center")
exports.dgs:dgsEditSetVerticalAlign(login_haslo,"center")
exports.dgs:dgsSetVisible(login_haslo,false)
exports.dgs:dgsEditSetMasked(login_haslo,true)
exports.dgs:dgsSetProperty(login_haslo,"caretColor",tocolor(0,0,0,255))
exports.dgs:dgsEditSetPlaceHolder(login_haslo,"Podaj swoje hasło..")
exports.dgs:dgsSetProperty(login_haslo,"placeHolderColor",tocolor(0,0,0,255))
exports.dgs:dgsSetProperty(login_haslo,"placeHolderFont",dgsfont2)

rej_login = exports.dgs:dgsCreateEdit( (1087/1920)*s.x, (426/1080)*s.y, (362/1920)*s.x, (24/1080)*s.y, "", false,nil,tocolor(0,0,0,255),1,1,false,tocolor(0,0,0,0) )
exports.dgs:dgsEditSetHorizontalAlign(rej_login,"center")
exports.dgs:dgsEditSetVerticalAlign(rej_login,"center")
exports.dgs:dgsSetVisible(rej_login,false)
exports.dgs:dgsSetProperty(rej_login,"caretColor",tocolor(0,0,0,255))
exports.dgs:dgsEditSetPlaceHolder(rej_login,"Podaj swój nowy login..")
exports.dgs:dgsSetProperty(rej_login,"placeHolderColor",tocolor(0,0,0,255))
exports.dgs:dgsSetProperty(rej_login,"placeHolderFont",dgsfont2)

rej_haslo = exports.dgs:dgsCreateEdit( (1087/1920)*s.x, (497/1080)*s.y, (362/1920)*s.x, (24/1080)*s.y, "", false,nil,tocolor(0,0,0,255),1,1,false,tocolor(0,0,0,0) )
exports.dgs:dgsEditSetHorizontalAlign(rej_haslo,"center")
exports.dgs:dgsEditSetVerticalAlign(rej_haslo,"center")
exports.dgs:dgsSetVisible(rej_haslo,false)
exports.dgs:dgsEditSetMasked(rej_haslo,true)
exports.dgs:dgsSetProperty(rej_haslo,"caretColor",tocolor(0,0,0,255))
exports.dgs:dgsEditSetPlaceHolder(rej_haslo,"Podaj swoje nowe hasło..")
exports.dgs:dgsSetProperty(rej_haslo,"placeHolderColor",tocolor(0,0,0,255))
exports.dgs:dgsSetProperty(rej_haslo,"placeHolderFont",dgsfont2)

rej_haslo2 = exports.dgs:dgsCreateEdit( (1087/1920)*s.x, (566/1080)*s.y, (362/1920)*s.x, (24/1080)*s.y, "", false,nil,tocolor(0,0,0,255),1,1,false,tocolor(0,0,0,0) )
exports.dgs:dgsEditSetHorizontalAlign(rej_haslo2,"center")
exports.dgs:dgsEditSetVerticalAlign(rej_haslo2,"center")
exports.dgs:dgsSetVisible(rej_haslo2,false)
exports.dgs:dgsEditSetMasked(rej_haslo2,true)
exports.dgs:dgsSetProperty(rej_haslo2,"caretColor",tocolor(0,0,0,255))
exports.dgs:dgsEditSetPlaceHolder(rej_haslo2,"Powtórz swoje nowe hasło..")
exports.dgs:dgsSetProperty(rej_haslo2,"placeHolderColor",tocolor(0,0,0,255))
exports.dgs:dgsSetProperty(rej_haslo2,"placeHolderFont",dgsfont2)

exports.dgs:dgsSetFont(login_login,dgsfont)
exports.dgs:dgsSetFont(login_haslo,dgsfont)
exports.dgs:dgsSetFont(rej_login,dgsfont)
exports.dgs:dgsSetFont(rej_haslo,dgsfont)
exports.dgs:dgsSetFont(rej_haslo2,dgsfont)



local anims, builtins = {}, {"Linear", "InQuad", "OutQuad", "InOutQuad", "OutInQuad", "InElastic", "OutElastic", "InOutElastic", "OutInElastic", "InBack", "OutBack", "InOutBack", "OutInBack", "InBounce", "OutBounce", "InOutBounce", "OutInBounce", "SineCurve", "CosineCurve"}

function table.find(t, v)
	for k, a in ipairs(t) do
		if a == v then
			return k
		end
	end
	return false
end

function animate(f, t, easing, duration, onChange, onEnd)
	assert(type(f) == "number", "Bad argument @ 'animate' [expected number at argument 1, got "..type(f).."]")
	assert(type(t) == "number", "Bad argument @ 'animate' [expected number at argument 2, got "..type(t).."]")
	assert(type(easing) == "string" or (type(easing) == "number" and (easing >= 1 or easing <= #builtins)), "Bad argument @ 'animate' [Invalid easing at argument 3]")
	assert(type(duration) == "number", "Bad argument @ 'animate' [expected number at argument 4, got "..type(duration).."]")
	assert(type(onChange) == "function", "Bad argument @ 'animate' [expected function at argument 5, got "..type(onChange).."]")
	table.insert(anims, {from = f, to = t, easing = table.find(builtins, easing) and easing or builtins[easing], duration = duration, start = getTickCount( ), onChange = onChange, onEnd = onEnd})
	return #anims
end

function destroyAnimation(a)
	if anims[a] then
		table.remove(anims, a)
	end
end



render=function()
    local now = getTickCount( )
    
    setCameraMatrix(2222,877,149,2065+math.sin(getTickCount()/4000)*80,1076+math.sin(getTickCount()/2000)*130,9)
	for k,v in ipairs(anims) do
		v.onChange(interpolateBetween(v.from, 0, 0, v.to, 0, 0, (now - v.start) / v.duration, v.easing))
		if now >= v.start+v.duration then
			if type(v.onEnd) == "function" then
				v.onEnd( )
			end
			table.remove(anims, k)
           
		end
	end
    --if open then
        if smooth then
            animate(smooth[1],smooth[2],1,800,function(al)
                alpha=al
                smooth=false
            end)
        end
        dxDrawRectangle(p["tlo"][1],p["tlo"][2],p["tlo"][3],p["tlo"][4],tocolor(0,0,0,150),false)
        dxDrawText("Stworzone przez Shuffle - wersja demo v"..(ver or "").."\nDiscord - Shuffle#1234", p["podpis"][1],p["podpis"][2],p["podpis"][3],p["podpis"][4], tocolor(255, 255, 255, 255), 1.00, font2, "right", "center", false, false, false, false, false)
        dxDrawImage(p["line"][1],p["line"][2],p["line"][3],p["line"][4], "line.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(p["s1"][1],p["s1"][2],p["s1"][3],p["s1"][4], "select.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
        dxDrawImage(p["s2"][1],p["s2"][2],p["s2"][3],p["s2"][4], "select.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
        local offset=0
        if #rank>0 then
            for i=1,5 do
                if rank[i] then
                    dxDrawText(i.."# "..rank[i].Login.." - "..rank[i].Czas.."h", ((64/1920)*s.x)+offset, (958/1080)*s.y, ((379/1920)*s.x)+offset, (1052/1080)*s.y, tocolor(255, 255, 255, 150), 1.00, font2, "center", "center", false, true, false, false, false)
                    offset=offset+(370/1920)*s.x
                end
            end
        else
            dxDrawText("Brak graczy spełniających warunki rankingu", (0/1920)*s.x, (940/1080)*s.y, (1920/1920)*s.x, (1076/1080)*s.y, tocolor(255, 255, 255, 150), 1.00, font2, "center", "center", false, false, false, false, false)
        end
        if isMouseInPosition(p["s1"][1],p["s1"][2],p["s1"][3],p["s1"][4]) or selected=="login" then
            dxDrawImage(p["img1"][1],p["img1"][2],p["img1"][3],p["img1"][4], "userc.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(p["img1"][1],p["img1"][2],p["img1"][3],p["img1"][4], "user.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        dxDrawText("Logowanie", p["txt"][1],p["txt"][2],p["txt"][3],p["txt"][4], tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        if isMouseInPosition(p["s2"][1],p["s2"][2],p["s2"][3],p["s2"][4]) or selected=="rejestracja" then
            dxDrawImage(p["img2"][1],p["img2"][2],p["img2"][3],p["img2"][4], "addc.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        else
            dxDrawImage(p["img2"][1],p["img2"][2],p["img2"][3],p["img2"][4], "add.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        end
        dxDrawText("Rejestracja", p["txt2"][1],p["txt2"][2],p["txt2"][3],p["txt2"][4], tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        if selected then
            if selected=="login" then
                dxDrawImage(p["img3"][1],p["img3"][2],p["img3"][3],p["img3"][4],"tlo.png",0,0,0,tocolor(255,255,255,alpha),false)
                if isMouseInPosition(p["b_zaloguj"][1],p["b_zaloguj"][2],p["b_zaloguj"][3],p["b_zaloguj"][4]) and alpha==255 then
                    if zones[1]<p["b_zaloguj"][3] then
                        zones[1]=zones[1]+5
                    end
                else
                    if zones[1]>0 then
                        zones[1]=zones[1]-5
                    end
                end
                if zones[1]>0 then
                    dxDrawImageSection(p["b_zaloguj"][1],p["b_zaloguj"][2],zones[1]-2,p["b_zaloguj"][4],0,0,zones[1]-2,p["b_zaloguj"][4],"button_mouse.png",0,0,0,tocolor(98,95,140,alpha),false)
                end
                if zones[3]>0 then
                    dxDrawImageSection(p["b_close"][1],p["b_close"][2],zones[3]-2,p["b_close"][4],0,0,zones[3]-2,p["b_close"][4],"button_mouse.png",0,0,0,tocolor(98,95,140,alpha),false)
                end
                dxDrawImage(p["b_zaloguj"][1],p["b_zaloguj"][2],p["b_zaloguj"][3],p["b_zaloguj"][4], "button_z.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)
                dxDrawImage(p["b_close"][1],p["b_close"][2],p["b_close"][3],p["b_close"][4], "button_c.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)
                if isMouseInPosition(p["b_close"][1],p["b_close"][2],p["b_close"][3],p["b_close"][4]) and alpha==255 then
                    if zones[3]<p["b_close"][3] then
                        zones[3]=zones[3]+5
                    end
                else
                    if zones[3]>0 then
                        zones[3]=zones[3]-5
                    end
                end
                
            elseif selected=="rejestracja" then
                dxDrawImage(p["img3"][1],p["img3"][2],p["img3"][3],p["img3"][4],"tlor.png",0,0,0,tocolor(255,255,255,alpha),false)
                if zones[1]>0 then
                    dxDrawImageSection(p["b_zaloguj"][1],p["b_zaloguj"][2]+(10/1080)*s.y,zones[1]-2,p["b_zaloguj"][4],0,0,zones[1]-2,p["b_zaloguj"][4],"button_mouse.png",0,0,0,tocolor(98,95,140,alpha),false)
                end
                dxDrawImage(p["b_zaloguj"][1],p["b_zaloguj"][2]+(10/1080)*s.y,p["b_zaloguj"][3],p["b_zaloguj"][4], "button_r.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)
                dxDrawImage(p["b_close"][1],p["b_close"][2]+(10/1080)*s.y,p["b_close"][3],p["b_close"][4], "button_c.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)
                
                if isMouseInPosition(p["b_zaloguj"][1],p["b_zaloguj"][2]+(10/1080)*s.y,p["b_zaloguj"][3],p["b_zaloguj"][4]) and alpha==255 then
                    if zones[1]<p["b_zaloguj"][3] then
                        zones[1]=zones[1]+5
                    end
                else
                    if zones[1]>0 then
                        zones[1]=zones[1]-5
                    end
                end
                if zones[3]>0 then
                    dxDrawImageSection(p["b_close"][1],p["b_close"][2]+(10/1080)*s.y,zones[3]-2,p["b_close"][4],0,0,zones[3]-2,p["b_close"][4],"button_mouse.png",0,0,0,tocolor(98,95,140,alpha),false)
                end
                dxDrawImage(p["b_close"][1],p["b_close"][2]+(10/1080)*s.y,p["b_close"][3],p["b_close"][4], "button_c.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)
                if isMouseInPosition(p["b_close"][1],p["b_close"][2],p["b_close"][3],p["b_close"][4]) and alpha==255 then
                    if zones[3]<p["b_close"][3] then
                        zones[3]=zones[3]+5
                    end
                else
                    if zones[3]>0 then
                        zones[3]=zones[3]-5
                    end
                end
            end
        end
    --end
end


addEventHandler("onClientClick",root,function(key,state)
    if key=="left" and state=="down" then
        if isMouseInPosition((47/1920)*s.x, (259/1080)*s.y, (210/1920)*s.x, (200/1080)*s.y) and selected~="login" and alpha==255 or alpha==0 then
            if selected=="rejestracja" then
                smooth={255,0}
                setTimer(function()
                    selected="login"
                    exports.dgs:dgsSetVisible(login_login,true)
                    exports.dgs:dgsSetVisible(login_haslo,true)
                    exports.dgs:dgsSetVisible(rej_login,false)
                    exports.dgs:dgsSetVisible(rej_haslo,false)
                    exports.dgs:dgsSetVisible(rej_haslo2,false)
                    smooth={0,255}
                end,900,1)
            else
                selected="login"
                exports.dgs:dgsSetVisible(login_login,true)
                exports.dgs:dgsSetVisible(login_haslo,true)
                smooth={0,255}
                open=true
            end
        elseif isMouseInPosition((47/1920)*s.x, (572/1080)*s.y, (210/1920)*s.x, (200/1080)*s.y) and selected~="rejestracja" and alpha==255 or alpha==0 then
            if selected=="login" then
                 smooth={255,0}
                setTimer(function()
                    selected="rejestracja"
                    exports.dgs:dgsSetVisible(login_login,false)
                    exports.dgs:dgsSetVisible(login_haslo,false)
                    exports.dgs:dgsSetVisible(rej_login,true)
                    exports.dgs:dgsSetVisible(rej_haslo,true)
                    exports.dgs:dgsSetVisible(rej_haslo2,true)
                    smooth={0,255}
                end,900,1)
            else
                selected="rejestracja"
                exports.dgs:dgsSetVisible(rej_login,true)
                exports.dgs:dgsSetVisible(rej_haslo,true)
                exports.dgs:dgsSetVisible(rej_haslo2,true)
                smooth={0,255}
                open=true
            end
        elseif isMouseInPosition(p["b_close"][1],p["b_close"][2],p["b_close"][3],p["b_close"][4]) and alpha==255 and selected=="login" then
            smooth={255,0}
            setTimer(function()
                selected=false
                exports.dgs:dgsSetVisible(login_login,false)
                exports.dgs:dgsSetVisible(login_haslo,false)
                open=false
            end,800,1)
        elseif isMouseInPosition(p["b_close"][1],p["b_close"][2]+(10/1080)*s.y,p["b_close"][3],p["b_close"][4]) and alpha==255 and selected=="rejestracja"then
            smooth={255,0}
            setTimer(function()
                selected=false
                exports.dgs:dgsSetVisible(rej_login,false)
                exports.dgs:dgsSetVisible(rej_haslo,false)
                exports.dgs:dgsSetVisible(rej_haslo2,false)
                open=false
            end,800,1)
        elseif isMouseInPosition(p["b_zaloguj"][1],p["b_zaloguj"][2],p["b_zaloguj"][3],p["b_zaloguj"][4]) and selected=="login" and alpha==255 then
            local login=exports.dgs:dgsGetText(login_login)
            local haslo=exports.dgs:dgsGetText(login_haslo)
            if string.len(login)==0 then
                outputChatBox("Wpisz login")
                return
            elseif string.len(haslo)==0 then
                outputChatBox("Wpisz hasło")
                return
            elseif string.len(login)>25 then
                outputChatBox("Login : max 25 znaków")
                return
            elseif string.len(haslo)>30 then
                outputChatBox("Hasło : max 30 znaków")
                return
            end
            triggerServerEvent("logowanie:login",localPlayer,login,haslo)
        elseif isMouseInPosition(p["b_zaloguj"][1],p["b_zaloguj"][2]+(10/1080)*s.y,p["b_zaloguj"][3],p["b_zaloguj"][4]) and selected=="rejestracja" and alpha==255 then
            local login=exports.dgs:dgsGetText(rej_login)
            local haslo=exports.dgs:dgsGetText(rej_haslo)
            local haslo2=exports.dgs:dgsGetText(rej_haslo2)
            if string.len(login)==0 then
                outputChatBox("Wpisz login")
                return
            elseif string.len(haslo)==0 then
                outputChatBox("Wpisz hasło")
                return
            elseif string.len(haslo2)==0 then
                outputChatBox("Wpisz ponownie hasło")
                return
            elseif string.len(login)>25 then
                outputChatBox("Login : max 25 znaków")
                return
            elseif string.len(haslo)>30 then
                outputChatBox("Hasło : max 30 znaków")
                return
            elseif string.len(haslo2)>30 then
                outputChatBox("Hasło drugie : max 30 znaków")
                return
            elseif haslo~=haslo2 then
                outputChatBox("Hasła nie są takie same")
                return
            end
            triggerServerEvent("logowanie:rejestracja",localPlayer,login,haslo)
        end
    end
end)



addEvent("close:panel",true)
addEventHandler("close:panel",root,function()
    if source==localPlayer then
        smooth={255,0}
        exports.dgs:dgsSetVisible(login_login,false)
        exports.dgs:dgsSetVisible(login_haslo,false)
        setTimer(function()
            removeEventHandler("onClientRender",root,render)
            showCursor(false)
            open=false
            setCameraTarget(localPlayer)
            setPlayerHudComponentVisible("radar",true)
            setPlayerHudComponentVisible("area_name",true)
            stopSound(sound)
        end,900,1)
    end
end)

addEvent("close:rejestracja",true)
addEventHandler("close:rejestracja",root,function()
    if source==localPlayer then
        smooth={255,0}
        setTimer(function()
            selected="login"
            exports.dgs:dgsSetVisible(login_login,true)
            exports.dgs:dgsSetVisible(login_haslo,true)
            exports.dgs:dgsSetVisible(rej_login,false)
            exports.dgs:dgsSetVisible(rej_haslo,false)
            exports.dgs:dgsSetVisible(rej_haslo2,false)
            smooth={0,255}
        end,900,1)
    end
end)