## Rhizomatics
### Helpful Open Source Software

Website: [rhizomatics.org.uk](https://www.rhizomatics.org.uk)

Current usable projects, focused on Home Assistant, MQTT, SignalK and self-hosting:

#### Homes and Home Assistant
* [AutoArm](https://autoarm.rhizomatics.org.uk)
    * Automatically arm and disarm Home Assistant Alarm Control Panels using calendars, mobile actions, physical buttons, sun state, occupancy and conditions
    * Available via public [HACS](https://hacs.xyz) catalog.
* [Supernotify](https://supernotify.rhizomatics.org.uk)
    * Builds on top of Home Assistant's notify platform to make complex needs easy to
    implement, including integrating chimes and voice announcements, multi-channel
    notifications, camera snapshots with PTZ movements, and more
    * Available via public [HACS](https://hacs.xyz) catalog.
* [Updates2MQTT](https://updates2mqtt.rhizomatics.org.uk)
    * Integrate self-hosted Docker containers into Home Assistant's Updates dialog to be notified of new images, and pull/restart the containers
* [anpr2mqtt](https://anpr2mqtt.rhizomatics.org.uk)
    * Watch for images added to a file server, analyze and create Home Assistant Image and Sensor entities for content, with optional UK DVLA lookup and Frigate subscription over MQTT
* [remote_logger](http://remote-logger.rhizomatics.org.uk/)
    * OTEL and Syslog native remote structured logging for Home Assistant
    * Available via public [HACS](https://hacs.xyz) catalog.
* [Awesome MQTT](https://github.com/rhizomatics/awesome-mqtt/tree/main)
    * Latest and greatest list of all things MQTT

#### Boats and SignalK

* [SignalK CLI](https://github.com/rhizomatics/signalk-cli)
  * Query SignalK History API from command line
  * Output to console, CSV or Apache Arrow Feather dataframe
  * Automatic discovery of local SignalK server
  * Auto aggregation for min/avg/max of any path value

* [Boat Tech Directory](https://github.com/rhizomatics/boat-tech-directory)
  * Curated list of boat tech projects, products, standards, blogs, news and more
  * Available as [Boat Tech Directory](http://boat-tech-directory.rhizomatics.org.uk/) web site and in `awesome list` as [Awesome Boat Tech](https://github.com/SY-Sea-Jade/awesome-boat-tech#awesome-boat-tech--)

* [signalk-datalab-plugin](https://github.com/rhizomatics/signalk-datalab-plugin) *ALPHA*
  * Python data notebooks using Marimo and WASM for easy (and advanced ) data analysis on SignalK data
  * Example notebook that pulls aggregate data out of the SignalK History API
 
* [signalk-bluetti-plugin](https://github.com/rhizomatics/signalk-bluetti-plugin)
  * Read Bluetti power station sensor data for battery level, solar input, inverter etc
  * Configuration for dozens of models
  * Some newer models using encrypted data will need a vendor-supplied key
 
* [signalk-delta-squelch-plugin](https://github.com/rhizomatics/signalk-delta-squelch-plugin)
  * Minimize noisy SignalK deltas and unnecessary database space/query time for analytics
  * Apply configurable rounding factor where SignalK precision exceeds the device resolution, e.g. GPS position
  * Skip updates within a configurable tolerance from last value, with heartbeat to maintain minimal stream
  * Reject implausible position changes from GPS spikes
 
* [signalk-einklabel-plugin](https://github.com/rhizomatics/signalk-einklabel-plugin)
  * Publish SignalK data to cheap eInk electronic shelf labels over BLE
  * Simple SVG templating, access to data paths plus Resources API
  * Scheduled based on time or change to a SignalK path
  * Handles ZhunyCo BLE labels and extensible for other vendors
  * Also available [signalk-einklabel-genai-plugin](https://github.com/rhizomatics/signalk-einklabel-genai-plugin) to generate ESL labels from a configurable LLM prompt

* [signalk-teltonika-sms-plugin](https://github.com/rhizomatics/signalk-teltonika-sms-plugin)
  * Notifications API implementation for text messaging
  * Sends SMS via the Web API on modern Teltonika RutOS modems/routers (minimum v7.6 of RutOS)
  * Throttling and retry 
  
