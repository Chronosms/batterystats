import time
import pyotherside

battery = {}
last_show_stat = 0
last_show_current_now = 0

def show_stat():
    uevent = open('/sys/class/power_supply/battery/uevent').read()
    for line in uevent.split('\n'):
        if line == '':
            continue
        i = line.split('=')
        battery[i[0]] = i[1]
    if '-' in battery['POWER_SUPPLY_CURRENT_NOW']:
        battery['POWER_SUPPLY_CURRENT_NOW'] = int(int(battery['POWER_SUPPLY_CURRENT_NOW'][1:])/1000)
    else:
        battery['POWER_SUPPLY_CURRENT_NOW'] = int(int('-{}'.format(battery['POWER_SUPPLY_CURRENT_NOW']))/1000)
    print('send: stat')
    pyotherside.send('stat', battery)

def show_current_now():
    current_now = open('/sys/class/power_supply/battery/current_now').read()
    if '-' in current_now:
        current_now = int(int(current_now[1:])/1000)
    else:
        current_now = int(int('-{}'.format(current_now))/1000)
    print('send: current_now')
    pyotherside.send('current_now', current_now)

while True:
    now = int(time.time())
    print(now)
    # if 11:00 >= 11:05 - 00:05
    if last_show_stat < now-5:
        show_stat()
        last_show_stat = now
    if last_show_current_now < now-1:
        show_current_now()
        last_show_current_now = now
    time.sleep(1)
