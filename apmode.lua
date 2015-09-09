-- Functions to execute simple http server to allow the user
-- to enter their wifi credentials

-- Start WiFi access point
function startAccessPoint() {
    wifi.setmode(wifi.SOFTAP)
    wifi.ap.config({ssid="Node1", pwd="1234"})
    srv = net.createServer(net.TCP)
    srv:listen(80, function(conn)
        conn:on("receive",function(conn, payload)
          conn:send("Hello!")
        end)
    end)
}
