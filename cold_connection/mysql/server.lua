mysqlConnection = nil
trys = 1

function MYSQLInitial()
    mysqlConnection = dbConnect("mysql", "dbname="..mysql.dbName..";host="..mysql.dbHost..";charset=utf8", mysql.dbUser, mysql.dbPass)
    if not mysqlConnection then
        if trys >= 5 then
            outputDebugString("Failed to establish connection with MySQL database server")
        else 
            trys = trys + 1
            outputDebugString("Failed to establish connection with MySQL database server. trying again...")
            MYSQLInitial()
        end
    else
        outputDebugString("[Important] Connected to the MySQL database server")
    end
end
addEventHandler("onResourceStart", resourceRoot, MYSQLInitial)

function getMySQL()
    return mysqlConnection
end