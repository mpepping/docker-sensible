# docker-sensible for Home Assistant

Run this docker-sensible image on Linux hosts for which you want to see some basic OS information in Home Assistant in an easy way.

Requires Home Assistant with an MQTT broker. Preferably a MQTT broker that supports auto-discovery, like Mosquitto.

This container images uses <https://github.com/TheTinkerDad/sensible>.

## Installation

Copy the `settings.example.yaml` to `settings.yaml` and adjust the settings to your needs. At minimunt set the `mqtt.hostname` to the IP address of your MQTT broker and the `discovery.devicename` to a unique name for this device.

```yaml
[..]
mqtt:
    hostname: 127.0.0.1
    port: "1883"
    username: ""
    password: ""
    clientid: sensible_mqtt_client
discovery:
    devicename: sensible-demo
    prefix: homeassistant
[..]
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

See the [docker-compose.yaml](docker-compose.yaml) for a full example.
