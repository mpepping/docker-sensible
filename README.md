# sensible-docker for Home Assistant

Run this sensible-docker image on Linux hosts for which you want to see some basic OS information in Home Assistant in an easy way.

Requires Home Assistant with an MQTT broker. Preferably a MQTT broker that supports auto-discovery, like Mosquitto.

This container images uses <https://github.com/TheTinkerDad/sensible>.

## Installation

Copy the `settings.example.yaml` to `settings.yaml` and adjust the settings to your needs:

```yaml
general:
    logfile: /var/log/sensible/sensible.log
    loglevel: info
    scriptlocation: /etc/sensible/scripts/
mqtt:
    hostname: 127.0.0.1
    port: "1883"
    username: ""
    password: ""
    clientid: sensible_mqtt_client
discovery:
    devicename: sensible-demo
    prefix: homeassistant
plugins:
    - name: Heartbeat
      kind: internal
      sensorid: heartbeat
      script: ""
      unitofmeasurement: ""
      icon: mdi:wrench-check
    - name: Boot Time
      kind: internal
      sensorid: boot_time
      script: ""
      unitofmeasurement: ""
      icon: mdi:clock
    - name: System Time
      kind: internal
      sensorid: system_time
      script: ""
      unitofmeasurement: ""
      icon: mdi:clock
    - name: Root Disk Free
      kind: script
      sensorid: root_free
      script: root_free.sh
      unitofmeasurement: GB
      icon: mdi:harddisk
    - name: Host IP Address
      kind: script
      sensorid: ip_address
      script: ip_address.sh
      unitofmeasurement: ""
      icon: mdi:check-network
    - name: Hostname
      kind: script
      sensorid: hostname
      script: hostname.sh
      unitofmeasurement: ""
      icon: mdi:network
    - name: Platform
      kind: script
      sensorid: platform
      script: platform.sh
      unitofmeasurement: ""
      icon: mdi:wrench-check
```

Start the container with the `settings.yaml` mounted to `/etc/sensible/settings.yaml`. on easy way to do this is by using docker-compose:

```yaml
services:
  sensible:
    restart: always
    image: ghcr.io/mpepping/docker-sensible:latest
    network_mode: host
    volumes:
      - ./settings.yaml:/etc/sensible/settings.yaml
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
```
