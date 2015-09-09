-- Functions to execute simple http server to allow the user
-- to enter their wifi credentials

-- Start WiFi access point
function startAccessPoint() {
    wifi.setmode(wifi.SOFTAP)
    wifi.ap.config({ssid="Node1", pwd="1234"})
}

-- Start the web interface to allow users to type in their Wifi SSID and password
function startHTTPServer() {
    srv = net.createServer(net.TCP)
    srv:listen(80, function(connection)
        connection:on("receive",function(connection, payload)
            connection:send("Hello!")
        end)
    end)
}

function serveInterface(connection) {
    connection:send("<!DOCTYPE html> ")
    connection:send("<html> ")
    connection:send("<body> ")
    connection:send("<h1>ESP8266 Wireless control setup</h1>")
    mac_mess1 = "The module MAC address is: " .. ap_mac
    mac_mess2 = "You will need this MAC address to find the IP address of the module, please take note of it."
    connection:send("<h2>" .. mac_mess1 .. "</h2>")
    connection:send("<h2>" .. mac_mess2 .. "</h2>")
    connection:send("<h2>Enter SSID and Password for your WIFI router</h2>")
    connection:send("<form action='send' method='post'>")
    connection:send("SSID:")
    connection:send("<input type='text' name='SSID' value='' maxlength='100'/>")
    connection:send("<br/>")
    connection:send("Password:")
    connection:send("<input type='text' name='Password' value='' maxlength='100'/>")
    connection:send("<input type='submit' value='Submit' />")
    connection:send("</form> </html>")
}
