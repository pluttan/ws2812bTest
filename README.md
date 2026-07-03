<div align="center">

# ws2812bTest

**Universal WS2812B test suite for 8 microcontrollers**


</div>

Cross-platform test suite for verifying WS2812B / WS2811 / SK6812 LED strips across 8 different microcontrollers. Ships with an interactive Makefile menu for board selection, pin configuration, and 14 cyclic test effects. One project, any MCU.

## ■ Features

- ❖ **8 MCUs supported** — ESP32, ESP32-C3, ESP32-S2, ESP8266, Arduino Nano, Uno, Mega, STM32 BluePill
- ❖ **14 test effects** — Solid Colors, RGB Sequential, White Balance, Brightness Levels, LED Addressing, Rainbow, Chase, Fade, Sparkle, Comet, Breathing, Gradient, Strobe, Theater Chase
- ❖ **Interactive menu** — Makefile wizard for board, port, pin, and LED count selection
- ❖ **Multi-LED support** — WS2812B, WS2811, SK6812 compatible
- ❖ **Serial debug output** — each test logs results to serial monitor
- ❖ **Configurable** — LED count, data pin, brightness, test duration via `include/config.h`

## ■ Stack

<div align="center">

| Component | Technology |
|-----------|------------|
| LED library | FastLED 3.6 |
| Build system | PlatformIO |
| Menu | GNU Make (interactive) |
| Platforms | espressif32, espressif8266, atmelavr, ststm32 |

</div>

## ■ How It Works

```
1. Run `make` to launch the interactive Makefile wizard.
2. Select the target board, serial port, data pin, and LED count when prompted.
3. PlatformIO builds the firmware for the chosen MCU platform (espressif32, atmelavr, ststm32, etc.).
4. FastLED drives the LED strip through 14 cyclic test effects in sequence.
5. Each test logs its results to the serial monitor for debug verification.
```

## ■ Usage

```bash
# Interactive menu (recommended)
make

# Direct build
make build MCU=esp32c3 PIN=8 LEDS=60

# Upload + monitor
make run MCU=esp32 PORT=/dev/ttyUSB0

# List available ports
make ports
```

## ■ Supported MCUs

<div align="center">

| MCU | Board | Default Pin | Platform |
|-----|-------|-------------|----------|
| ESP32 | esp32dev | GPIO 5 | espressif32 |
| ESP32-C3 | esp32-c3-devkitm-1 | GPIO 8 | espressif32 |
| ESP32-S2 | esp32-s2-saola-1 | GPIO 18 | espressif32 |
| ESP8266 | nodemcuv2 | GPIO 5 (D1) | espressif8266 |
| Arduino Nano | nanoatmega328 | Pin 6 | atmelavr |
| Arduino Uno | uno | Pin 6 | atmelavr |
| Arduino Mega | megaatmega2560 | Pin 6 | atmelavr |
| STM32 BluePill | bluepill_f103c8 | PA7 | ststm32 |

</div>

## ■ License

MIT © [pluttan](https://github.com/pluttan)
