rPin = 7 --PIN12
gPin = 6 --PIN14
bPin = 5 --PIN13

status = 1

pwm.setup(rPin, 1000, 512)
pwm.setup(gPin, 1000, 512)
pwm.setup(bPin, 500, 512)

red = 256
green = 256
blue = 256

function setColor(r,g,b)
    red = r % 1024
    green = g % 1024
    blue = b % 1024
    if status == 1 then
        updateDuty()
    end
    print(r .. " " .. g .. " " .. b)
end

function setRed(r)
    red = (( r * 1023 ) / 100 ) % 1024
    print(r)
    updateDuty()
end

function setGreen(g)
    green = (( g * 1023 ) / 100 ) % 1024
    updateDuty()
end

function setBlue(b)
    blue = (( b * 1023 ) / 100 ) % 1024
    updateDuty()
end

function updateDuty()
    pwm.setduty(rPin,red)
    pwm.setduty(gPin,green)
    pwm.setduty(bPin,blue)
end

function lightOn()
    if status == 0 then
        pwm.start(rPin)
        pwm.start(gPin)
        pwm.start(bPin)
        updateDuty()
        status = 1
    end
end

function lightOff()
    if status == 1 then
        pwm.stop(rPin)
        pwm.stop(gPin)
        pwm.stop(bPin)
        status = 0
    end
end
