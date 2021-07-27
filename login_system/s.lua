local db = dbConnect( "sqlite", "baza.db" )

addEvent("open:login",true)
addEventHandler("open:login",root,function()
    local q=dbQuery(db,"SELECT * FROM Konta")
    local w=dbPoll(q,-1)
    local tabela={}
    for _,v in ipairs(w)do
        table.insert(tabela,v)
    end
    table.sort(tabela, function(a, b) return a.Czas > b.Czas end )
    triggerClientEvent("open:login",source,tabela)
    tabela=nil
end)


addEvent("logowanie:login",true)
addEventHandler("logowanie:login",root,function(login,haslo)
    if login and haslo then
        local q=dbQuery(db,"SELECT * FROM Konta WHERE Login=?",login)
        local w=dbPoll(q,-1)
        if #w==0 then
            outputChatBox("Nie znaleziono takiego konta w bazie danych",source)
            return
        elseif w[1].Haslo~=haslo then
            outputChatBox("Wpisałeś niepoprawne dane logowania",source)
            return
        end
        triggerClientEvent("close:panel",source)
    end
end)


addEvent("logowanie:rejestracja",true)
addEventHandler("logowanie:rejestracja",root,function(login,haslo)
    if login and haslo then
        local q=dbQuery(db,"SELECT * FROM Konta WHERE Login=?",login)
        local w=dbPoll(q,-1)
        if #w>0 then
            outputChatBox("Takie konto istnieje już w bazie danych",source)
            return
        end
        dbExec(db,"INSERT INTO Konta (Login,Haslo,Czas) VALUES (?,?,?)",login,haslo,0)
        outputChatBox("Konto utworzone, możesz przejść do logowania",source)
        triggerClientEvent("close:rejestracja",source)
    end
end)




