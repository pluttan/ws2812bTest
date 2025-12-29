# WS2812B Universal Test Suite

[![PlatformIO](https://img.shields.io/badge/PlatformIO-Compatible-orange)](https://platformio.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![FastLED](https://img.shields.io/badge/FastLED-3.6.0-green)](https://github.com/FastLED/FastLED)

Универсальный тестовый набор для проверки светодиодных лент WS2812B с поддержкой множества микроконтроллеров.

![WS2812B](https://img.shields.io/badge/LED-WS2812B-brightgreen)
![WS2811](https://img.shields.io/badge/LED-WS2811-brightgreen)
![SK6812](https://img.shields.io/badge/LED-SK6812-brightgreen)

## 📋 Возможности

- ✅ **8 поддерживаемых микроконтроллеров** — ESP32, ESP8266, Arduino, STM32
- ✅ **14 тестовых эффектов** — от базовых цветов до анимаций
- ✅ **Интерактивное меню** — простой выбор МК, пина и порта
- ✅ **Гибкая конфигурация** — количество LED, пин данных, яркость
- ✅ **Serial Monitor** — отладочный вывод всех тестов

## 🎮 Поддерживаемые микроконтроллеры

| МК | Плата | Пин по умолчанию | Платформа |
|:---|:------|:-----------------|:----------|
| ESP32 | esp32dev | GPIO 5 | espressif32 |
| ESP32-C3 | esp32-c3-devkitm-1 | GPIO 8 | espressif32 |
| ESP32-S2 | esp32-s2-saola-1 | GPIO 18 | espressif32 |
| ESP8266 | nodemcuv2 | GPIO 5 (D1) | espressif8266 |
| Arduino Nano | nanoatmega328 | Pin 6 | atmelavr |
| Arduino Uno | uno | Pin 6 | atmelavr |
| Arduino Mega | megaatmega2560 | Pin 6 | atmelavr |
| STM32 BluePill | bluepill_f103c8 | PA7 | ststm32 |

## 📦 Зависимости

### Обязательные

| Зависимость | Версия | Описание |
|:------------|:-------|:---------|
| [PlatformIO](https://platformio.org/) | Latest | Система сборки и менеджер пакетов |
| [Python](https://python.org/) | 3.6+ | Для работы PlatformIO |
| GNU Make | Any | Для работы интерактивного меню |

### Библиотеки (устанавливаются автоматически)

| Библиотека | Версия | Описание |
|:-----------|:-------|:---------|
| [FastLED](https://github.com/FastLED/FastLED) | ^3.6.0 | Управление адресными светодиодами |

### Платформы PlatformIO (устанавливаются автоматически)

- `espressif32` — ESP32, ESP32-C3, ESP32-S2
- `espressif8266` — ESP8266, NodeMCU
- `atmelavr` — Arduino Nano, Uno, Mega
- `ststm32` — STM32 BluePill

## 🚀 Быстрый старт

### 1. Установка PlatformIO

```bash
# Через pip
pip install platformio

# Или через Homebrew (macOS)
brew install platformio
```

### 2. Клонирование репозитория

```bash
git clone https://github.com/pluttan/ws2812bTest.git
cd ws2812bTest
```

### 3. Запуск интерактивного меню

```bash
make
```

Меню проведёт вас через:
1. Выбор микроконтроллера
2. Выбор порта (автоопределение доступных)
3. Настройка пина данных
4. Настройка количества LED
5. Действие (сборка / загрузка / загрузка + монитор)

## 📖 Использование

### Интерактивный режим

```bash
make              # Запустить меню
make ports        # Показать доступные порты
make help         # Справка
```

### Прямые команды

```bash
# Только сборка
make build MCU=esp32

# Сборка с параметрами
make build MCU=esp32c3 PIN=8 LEDS=60

# Загрузка на устройство
make upload MCU=nano PORT=/dev/ttyUSB0

# Загрузка + Serial Monitor
make run MCU=esp32 PORT=/dev/cu.usbserial-0001

# Только монитор
make monitor PORT=/dev/ttyUSB0
```

### Параметры

| Параметр | Описание | Пример |
|:---------|:---------|:-------|
| `MCU` | Микроконтроллер | `esp32`, `nano`, `bluepill` |
| `PIN` | Пин данных | `5`, `8`, `PA7` |
| `LEDS` | Количество LED | `30`, `60`, `144` |
| `PORT` | COM-порт | `/dev/ttyUSB0`, `COM3` |

## 🌈 Тестовые эффекты

Тесты выполняются циклически:

### Базовые тесты
1. **Solid Colors** — заливка красным, зелёным, синим
2. **RGB Sequential** — последовательная смена R→G→B
3. **White Balance** — холодный и тёплый белый

### Проверка оборудования
4. **Brightness Levels** — плавное изменение яркости
5. **LED Addressing** — проверка каждого LED индивидуально

### Анимационные эффекты
6. **Rainbow** — радуга по всей ленте
7. **Chase** — бегущие огни
8. **Fade** — плавное угасание цветов
9. **Sparkle** — случайные искры
10. **Comet** — комета с хвостом
11. **Breathing** — эффект дыхания
12. **Gradient** — движущийся градиент
13. **Strobe** — стробоскоп
14. **Theater Chase** — театральная погоня

## ⚙️ Конфигурация

Файл [`include/config.h`](include/config.h):

```cpp
// Количество светодиодов (переопределяется через Makefile)
#define NUM_LEDS 30

// Пин данных (автоопределение по МК)
#define DATA_PIN 5

// Тип ленты
#define LED_TYPE WS2812B

// Порядок цветов
#define COLOR_ORDER GRB

// Максимальная яркость (0-255)
#define MAX_BRIGHTNESS 128

// Время показа каждого теста (мс)
#define TEST_DURATION 5000

// Задержка анимации (мс)
#define ANIMATION_DELAY 50
```

## 🔌 Подключение

```
Лента WS2812B      Микроконтроллер
─────────────      ───────────────
     VCC  ────────►  5V / 3.3V
     GND  ────────►  GND
     DIN  ────────►  DATA_PIN
```

> ⚠️ **Важно:** Для ESP32/ESP8266 используйте логический преобразователь уровней 3.3V → 5V для надёжной работы.

## 📁 Структура проекта

```
ws2812bTest/
├── include/
│   └── config.h          # Настройки
├── src/
│   └── main.cpp          # Основной код с тестами
├── Makefile              # Интерактивное меню
├── platformio.ini        # Конфигурация PlatformIO
├── LICENSE               # MIT License
└── README.md             # Документация
```

## 🛠️ Устранение неполадок

### Порт не найден

```bash
make ports                # Проверить доступные порты
```

На macOS может потребоваться установить драйверы:
- CH340/CH341: [Драйвер](https://github.com/WCHSoftware/ch34xser_macos)
- CP210x: [Драйвер](https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers)

### Сборка не работает

```bash
make clean               # Очистить кэш
pio pkg update           # Обновить библиотеки
```

### LED не светятся

1. Проверьте питание (5V, достаточный ток)
2. Проверьте правильность пина данных
3. Убедитесь в правильном порядке цветов (`GRB` для WS2812B)

## 📄 Лицензия

MIT License — см. [LICENSE](LICENSE)

## 🤝 Вклад в проект

Pull requests приветствуются! Для крупных изменений сначала откройте issue.

---

**Автор:** [pluttan](https://github.com/pluttan)
