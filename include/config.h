#ifndef CONFIG_H
#define CONFIG_H

// ============================================
// НАСТРОЙКИ ЛЕНТЫ WS2812B
// ============================================

// Количество светодиодов в ленте
// Может быть переопределено через Makefile: LEDS=60
#ifdef CUSTOM_NUM_LEDS
    #define NUM_LEDS CUSTOM_NUM_LEDS
#else
    #define NUM_LEDS 30
#endif

// Пин данных
// Может быть переопределен через Makefile: PIN=8
#ifdef CUSTOM_DATA_PIN
    #define DATA_PIN CUSTOM_DATA_PIN
#elif defined(ESP32) && defined(CONFIG_IDF_TARGET_ESP32C3)
    #define DATA_PIN 8   // ESP32-C3
#elif defined(ESP32) && defined(CONFIG_IDF_TARGET_ESP32S2)
    #define DATA_PIN 18  // ESP32-S2
#elif defined(ESP32)
    #define DATA_PIN 5   // ESP32 обычный
#elif defined(ESP8266)
    #define DATA_PIN 5   // D1
#elif defined(STM32F1)
    #define DATA_PIN PA7
#else
    // Arduino AVR (Uno, Nano, Mega)
    #define DATA_PIN 6
#endif

// Тип светодиодной ленты (WS2812B, WS2811, SK6812, и др.)
#define LED_TYPE WS2812B

// Порядок цветов (GRB для большинства WS2812B)
#define COLOR_ORDER GRB

// Максимальная яркость (0-255)
#define MAX_BRIGHTNESS 128

// ============================================
// НАСТРОЙКИ ТЕСТОВ
// ============================================

// Время задержки между кадрами (мс)
#define ANIMATION_DELAY 50

// Время показа каждого теста (мс)
#define TEST_DURATION 5000

// Включить вывод в Serial Monitor
#define SERIAL_DEBUG 1

#endif // CONFIG_H
