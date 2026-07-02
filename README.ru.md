![Header](header.png)

<div align="center">

# ws2812bTest

**Универсальный набор тестов WS2812B для 8 микроконтроллеров**

[![License](https://img.shields.io/badge/license-MIT-2C2C2C?style=for-the-badge&labelColor=1E1E1E)](LICENSE)
[![PlatformIO](https://img.shields.io/badge/PlatformIO-build-2C2C2C?style=for-the-badge&logo=platformio&labelColor=1E1E1E)]()
[![FastLED](https://img.shields.io/badge/FastLED-3.6-2C2C2C?style=for-the-badge&labelColor=1E1E1E)]()
[![GitHub](https://img.shields.io/badge/github-pluttan/ws2812bTest-2C2C2C?style=for-the-badge&logo=github&labelColor=1E1E1E)](https://github.com/pluttan/ws2812bTest)

</div>

Кросс-платформенный набор тестов для проверки светодиодных лент WS2812B / WS2811 / SK6812 на 8 различных микроконтроллерах. Включает интерактивное меню Makefile для выбора платы, настройки пина и 14 цикличных тестовых эффектов. Один проект — любой МК.

## ■ Возможности

- ❖ **Поддержка 8 МК** — ESP32, ESP32-C3, ESP32-S2, ESP8266, Arduino Nano, Uno, Mega, STM32 BluePill
- ❖ **14 тестовых эффектов** — Solid Colors, RGB Sequential, White Balance, Brightness Levels, LED Addressing, Rainbow, Chase, Fade, Sparkle, Comet, Breathing, Gradient, Strobe, Theater Chase
- ❖ **Интерактивное меню** — мастер Makefile для выбора платы, порта, пина и количества светодиодов
- ❖ **Поддержка нескольких типов лент** — совместимость с WS2812B, WS2811, SK6812
- ❖ **Вывод отладки в Serial** — каждый тест логирует результаты в монитор порта
- ❖ **Настраиваемость** — количество светодиодов, пин данных, яркость, длительность теста через `include/config.h`

## ■ Поддерживаемые МК

<div align="center">

| МК | Board | Default Pin | Platform |
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

## ■ Стек

<div align="center">

| Компонент | Технология |
|-----------|------------|
| Библиотека LED | FastLED 3.6 |
| Система сборки | PlatformIO |
| Меню | GNU Make (interactive) |
| Платформы | espressif32, espressif8266, atmelavr, ststm32 |

</div>

## ■ Запуск

```bash
# Интерактивное меню (рекомендуется)
make

# Прямая сборка
make build MCU=esp32c3 PIN=8 LEDS=60

# Загрузка + монитор
make run MCU=esp32 PORT=/dev/ttyUSB0

# Список доступных портов
make ports
```

## ■ License

MIT © [pluttan](https://github.com/pluttan)
