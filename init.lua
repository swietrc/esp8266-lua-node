SSID=""
PASSWD=""
fStatus = file.open("config", "r")

if fStatus ~= nil then
    SSID=string.sub(file.readline(), 0, -2)
    PASSWD=string.sub(file.readline(), 0, -2)

    file.close()

    wifi.setmode(wifi.STATION)
    wifi.sta.config(SSID, PASSWD)
    wifi.sta.connect()
    tmr.alarm(0, 5000, 0, function()
        local status = wifi.sta.status()
        if status == 2 or status == 3 or station == 4 then
            print("unable to connect to wifi " .. SSID)
        end
    end)
end


dofile("ledstrip.lua")

BROKER = "192.168.1.66"
BRPORT = 1883
CLIENTID = "node1"
function sub()
    m:subscribe("node1/strip/#", 0, function(con) print("subscribed to node1/strip") end)
end

m = mqtt.Client("node1", 120, "node1", "123")
m:on("connect", function(con) print("connected") end)
m:on("offline", function(con)
  print("reconnecting...")
  tmr.alarm(1, 10000, 0, function() m:connect(BROKER, BRPORT, 0) end)
end)

m:on("message", function(con, topic, data)
  print(topic .. ":")
  print(data)
  if data ~= nil then
     readmsg(con, topic, data)
  end
end)

tmr.alarm(1, 10000, 0, function() m:connect(BROKER, BRPORT, 0, function(conn)
        print("Connected to MQTT:" .. BROKER .. ":" .. BRPORT .." as " .. CLIENTID )
        sub()
    end)
end)


function readmsg(conn, topic, data)
    if topic == "node1/strip/red" then setRed(data)
    elseif topic == "node1/strip/green" then setGreen(data)
    elseif topic == "node1/strip/blue" then setBlue(data)
    end
end
