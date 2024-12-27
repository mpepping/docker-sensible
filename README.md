# docker-sensible for Home Assistant

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/mpepping/docker-sensible)

Run this [docker-sensible container image](https://github.com/mpepping/docker-sensible) on Linux hosts for which you want to see some basic OS information and metrics in [Home Assistant](https://www.home-assistant.io) in an easy way. Requires Home Assistant with an MQTT broker integration or add-on. Preferably a MQTT broker that supports auto-discovery, like the official [Mosquitto add-on](https://www.home-assistant.io/integrations/mqtt/#setting-up-a-broker) for Home Assistant.

## Installation

Running the container image requires setting up the `settings.yaml` configuration file. Start by copying the `settings.example.yaml` to `settings.yaml` and adjust the settings to your needs. At minimum set the `mqtt.hostname` to the IP address of your MQTT broker, a unique `mqtt.clientid` and the `discovery.devicename` to a unique name for this device.

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
      - /etc:/host/etc:ro
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
```

Run `docker-compose up` to start the container. See the [docker-compose.yaml](docker-compose.yaml) for a full example.

If you're not using `docker-compose` and want to use a `docker` compatible runtime directly, run the following command:

```bash
docker run -d --name sensible \
  --restart always \
  --network host \
  -v $(pwd)/settings.yaml:/etc/sensible/settings.yaml \
  -v /etc:/host/etc:ro \
  -v /proc:/host/proc:ro \
  -v /sys:/host/sys:ro \
  ghcr.io/mpepping/docker-sensible:latest
```

From here, the container will start publishing the metrics to the MQTT broker. Setup and use the published values in Home Assistant as regular sensors in any automation or dashboard.

## References

This container image uses <https://github.com/TheTinkerDad/sensible>.
