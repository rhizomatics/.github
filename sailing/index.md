# Sailing

Rhizomatics builds open source tools for [SignalK](<https://signalk.org/>), the open marine data standard, intended for low power servers on small boats, alongside a curated directory of boat technology.

## Projects

- **[signalk-cli](<https://signalk-cli.rhizomatics.org.uk>)**

  ---

  Command line access to SignalK APIs. Generate CSV or Apache Arrow dataframes from the History API, or use the exploration and analysis tools to investigate the preserved boat data.
- **[signalk-datalab-plugin](<https://signalk-datalab.rhizomatics.org.uk>)** *BETA*

  ---

  Interactive data analysis notebooks for SignalK, using [Marimo](<https://marimo.io>) running as WebAssembly in the browser. API and streaming access using a choice of Polars, Ibis Framework and signalk-cli.
- **[Boat Tech Directory](<https://boat-tech-directory.rhizomatics.org.uk/>)**

  ---

  A curated list of boat tech: NMEA and Seatalk, marine internet, open source projects, hardware vendors and educational resources.

  Also available as in 'awesome list' format as [awesome-boat-tech](<https://github.com/SY-Sea-Jade/awesome-boat-tech>)) and as a webapp plugin for SignalK
- **[signalk-bluetti-plugin](<https://github.com/rhizomatics/signalk-bluetti-plugin>)**

  ---

  Reads Bluetti power station sensor data for battery level, solar input, inverter and more, with configuration for dozens of models. Some newer models using encrypted data will need a vendor-supplied key.
- **[signalk-delta-squelch-plugin](<https://github.com/rhizomatics/signalk-delta-squelch-plugin>)**

  ---

  Minimizes noisy SignalK deltas and unnecessary database space/query time for analytics. Applies configurable rounding, skips updates within a tolerance of the last value (with a heartbeat to keep the stream alive), and rejects implausible position changes from GPS spikes.
- **[signalk-einklabel-plugin](<https://signalk-einklabel.rhizomatics.org.uk>)**

  ---

  Publishes SignalK data to cheap eInk electronic shelf labels over BLE, with simple SVG templating, access to data paths plus the Resources API, and scheduling based on time or change to a SignalK path. Handles ZhunyCo BLE labels and is extensible for other vendors.

  Also available as [signalk-einklabel-genai-plugin](<https://github.com/rhizomatics/signalk-einklabel-genai-plugin>) to generate ESL labels from a configurable LLM prompt.
- **[signalk-teltonika-sms-plugin](<https://github.com/rhizomatics/signalk-teltonika-sms-plugin>)**

  ---

  Notifications API implementation for text messaging. Sends SMS via the Web API on modern Teltonika RutOS modems/routers (minimum v7.6 of RutOS), with throttling and retry.
