# WS2812B Test - Интерактивный Makefile
# Использование: make (интерактивный режим) или make build MCU=esp32 PIN=5 PORT=/dev/ttyUSB0

.PHONY: all build upload monitor clean menu help ports

# Цвета для вывода
YELLOW := \033[1;33m
GREEN := \033[1;32m
CYAN := \033[1;36m
RED := \033[1;31m
MAGENTA := \033[1;35m
NC := \033[0m

# Список доступных МК
MCUS := esp32 esp32c3 esp32s2 esp8266 nano uno mega bluepill

# Пины по умолчанию для каждого МК
DEFAULT_PIN_esp32 := 5
DEFAULT_PIN_esp32c3 := 8
DEFAULT_PIN_esp32s2 := 18
DEFAULT_PIN_esp8266 := 5
DEFAULT_PIN_nano := 6
DEFAULT_PIN_uno := 6
DEFAULT_PIN_mega := 6
DEFAULT_PIN_bluepill := 7

# Количество LED по умолчанию
NUM_LEDS ?= 30

# Автоопределение порта
ifeq ($(OS),Windows_NT)
	PORT_CMD := powershell -Command "Get-WMIObject Win32_SerialPort | Select-Object DeviceID, Description"
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		PORT_LIST := $(shell ls /dev/cu.* 2>/dev/null | grep -v Bluetooth || echo "")
	else
		PORT_LIST := $(shell ls /dev/ttyUSB* /dev/ttyACM* 2>/dev/null || echo "")
	endif
endif

# Интерактивное меню
all: menu

menu:
	@echo ""
	@echo "$(CYAN)╔══════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(CYAN)║         WS2812B Universal Test Suite                     ║$(NC)"
	@echo "$(CYAN)╚══════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(YELLOW)Выберите микроконтроллер:$(NC)"
	@echo ""
	@echo "  $(GREEN)1)$(NC) ESP32         (GPIO 5 по умолчанию)"
	@echo "  $(GREEN)2)$(NC) ESP32-C3      (GPIO 8 по умолчанию)"
	@echo "  $(GREEN)3)$(NC) ESP32-S2      (GPIO 18 по умолчанию)"
	@echo "  $(GREEN)4)$(NC) ESP8266       (GPIO 5/D1 по умолчанию)"
	@echo "  $(GREEN)5)$(NC) Arduino Nano  (Pin 6 по умолчанию)"
	@echo "  $(GREEN)6)$(NC) Arduino Uno   (Pin 6 по умолчанию)"
	@echo "  $(GREEN)7)$(NC) Arduino Mega  (Pin 6 по умолчанию)"
	@echo "  $(GREEN)8)$(NC) STM32 BluePill (PA7 по умолчанию)"
	@echo ""
	@read -p "Введите номер [1-8]: " mcu_choice; \
	case $$mcu_choice in \
		1) selected_mcu="esp32"; default_pin=5;; \
		2) selected_mcu="esp32c3"; default_pin=8;; \
		3) selected_mcu="esp32s2"; default_pin=18;; \
		4) selected_mcu="esp8266"; default_pin=5;; \
		5) selected_mcu="nano"; default_pin=6;; \
		6) selected_mcu="uno"; default_pin=6;; \
		7) selected_mcu="mega"; default_pin=6;; \
		8) selected_mcu="bluepill"; default_pin=7;; \
		*) echo "$(RED)Неверный выбор!$(NC)"; exit 1;; \
	esac; \
	echo ""; \
	echo "$(MAGENTA)Доступные порты:$(NC)"; \
	if [ "$(UNAME_S)" = "Darwin" ]; then \
		ports=$$(ls /dev/cu.* 2>/dev/null | grep -v Bluetooth || echo ""); \
	else \
		ports=$$(ls /dev/ttyUSB* /dev/ttyACM* 2>/dev/null || echo ""); \
	fi; \
	if [ -z "$$ports" ]; then \
		echo "  $(RED)Порты не найдены$(NC)"; \
		echo "  Подключите устройство или введите порт вручную"; \
		default_port="auto"; \
	else \
		i=1; \
		for p in $$ports; do \
			echo "  $(GREEN)$$i)$(NC) $$p"; \
			eval "port_$$i=$$p"; \
			i=$$((i+1)); \
		done; \
		default_port=$$port_1; \
	fi; \
	echo ""; \
	read -p "Выберите порт (номер/путь/auto) [по умолчанию: auto]: " port_input; \
	if [ -z "$$port_input" ] || [ "$$port_input" = "auto" ]; then \
		selected_port="auto"; \
	elif echo "$$port_input" | grep -qE '^[0-9]+$$'; then \
		eval "selected_port=\$$port_$$port_input"; \
		if [ -z "$$selected_port" ]; then \
			echo "$(RED)Неверный номер порта!$(NC)"; exit 1; \
		fi; \
	else \
		selected_port="$$port_input"; \
	fi; \
	echo ""; \
	read -p "Введите пин данных [по умолчанию: $$default_pin]: " pin_input; \
	if [ -z "$$pin_input" ]; then pin_input=$$default_pin; fi; \
	echo ""; \
	read -p "Количество светодиодов [по умолчанию: $(NUM_LEDS)]: " leds_input; \
	if [ -z "$$leds_input" ]; then leds_input=$(NUM_LEDS); fi; \
	echo ""; \
	echo "$(CYAN)════════════════════════════════════════$(NC)"; \
	echo "$(GREEN)МК:$(NC) $$selected_mcu"; \
	echo "$(GREEN)Порт:$(NC) $$selected_port"; \
	echo "$(GREEN)Пин данных:$(NC) $$pin_input"; \
	echo "$(GREEN)Кол-во LED:$(NC) $$leds_input"; \
	echo "$(CYAN)════════════════════════════════════════$(NC)"; \
	echo ""; \
	echo "$(YELLOW)Выберите действие:$(NC)"; \
	echo "  $(GREEN)1)$(NC) Собрать (build)"; \
	echo "  $(GREEN)2)$(NC) Собрать и загрузить (upload)"; \
	echo "  $(GREEN)3)$(NC) Загрузить и мониторить (upload + monitor)"; \
	echo ""; \
	read -p "Введите номер [1-3]: " action; \
	case $$action in \
		1) $(MAKE) build MCU=$$selected_mcu PIN=$$pin_input LEDS=$$leds_input;; \
		2) $(MAKE) upload MCU=$$selected_mcu PIN=$$pin_input LEDS=$$leds_input PORT=$$selected_port;; \
		3) $(MAKE) run MCU=$$selected_mcu PIN=$$pin_input LEDS=$$leds_input PORT=$$selected_port;; \
		*) echo "$(RED)Неверный выбор!$(NC)"; exit 1;; \
	esac

# Сборка проекта
build:
ifndef MCU
	@echo "$(RED)Ошибка: не указан МК$(NC)"
	@echo "Использование: make build MCU=<mcu> [PIN=<pin>] [LEDS=<num>]"
	@echo "Доступные МК: $(MCUS)"
	@exit 1
endif
	@echo ""
	@echo "$(CYAN)Сборка для $(MCU)...$(NC)"
	@PIN_VAL=$(if $(PIN),$(PIN),$(DEFAULT_PIN_$(MCU))); \
	LEDS_VAL=$(if $(LEDS),$(LEDS),$(NUM_LEDS)); \
	echo "$(GREEN)Пин:$(NC) $$PIN_VAL  $(GREEN)LED:$(NC) $$LEDS_VAL"; \
	BUILD_FLAGS="-DCUSTOM_DATA_PIN=$$PIN_VAL -DCUSTOM_NUM_LEDS=$$LEDS_VAL" \
	pio run -e $(MCU)

# Загрузка на устройство
upload:
ifndef MCU
	@echo "$(RED)Ошибка: не указан МК$(NC)"
	@echo "Использование: make upload MCU=<mcu> [PIN=<pin>] [LEDS=<num>] [PORT=<port>]"
	@exit 1
endif
	@echo ""
	@echo "$(CYAN)Загрузка на $(MCU)...$(NC)"
	@PIN_VAL=$(if $(PIN),$(PIN),$(DEFAULT_PIN_$(MCU))); \
	LEDS_VAL=$(if $(LEDS),$(LEDS),$(NUM_LEDS)); \
	PORT_OPT=""; \
	if [ -n "$(PORT)" ] && [ "$(PORT)" != "auto" ]; then \
		PORT_OPT="--upload-port $(PORT)"; \
		echo "$(GREEN)Порт:$(NC) $(PORT)"; \
	else \
		echo "$(GREEN)Порт:$(NC) auto"; \
	fi; \
	echo "$(GREEN)Пин:$(NC) $$PIN_VAL  $(GREEN)LED:$(NC) $$LEDS_VAL"; \
	BUILD_FLAGS="-DCUSTOM_DATA_PIN=$$PIN_VAL -DCUSTOM_NUM_LEDS=$$LEDS_VAL" \
	pio run -e $(MCU) -t upload $$PORT_OPT

# Загрузка + монитор
run:
ifndef MCU
	@echo "$(RED)Ошибка: не указан МК$(NC)"
	@exit 1
endif
	@$(MAKE) upload MCU=$(MCU) PIN=$(PIN) LEDS=$(LEDS) PORT=$(PORT)
	@echo ""
	@echo "$(CYAN)Запуск монитора...$(NC)"
	@if [ -n "$(PORT)" ] && [ "$(PORT)" != "auto" ]; then \
		pio device monitor --port $(PORT); \
	else \
		pio device monitor; \
	fi

# Только монитор
monitor:
	@if [ -n "$(PORT)" ] && [ "$(PORT)" != "auto" ]; then \
		pio device monitor --port $(PORT); \
	else \
		pio device monitor; \
	fi

# Очистка
clean:
	@echo "$(YELLOW)Очистка...$(NC)"
	@pio run -t clean
	@rm -rf .pio
	@echo "$(GREEN)Готово!$(NC)"

# Список портов
ports:
	@echo ""
	@echo "$(CYAN)Доступные порты:$(NC)"
	@echo ""
	@pio device list

# Справка
help:
	@echo ""
	@echo "$(CYAN)WS2812B Test Suite - Справка$(NC)"
	@echo ""
	@echo "$(YELLOW)Интерактивный режим:$(NC)"
	@echo "  make              - запустить интерактивное меню"
	@echo ""
	@echo "$(YELLOW)Прямые команды:$(NC)"
	@echo "  make build MCU=<mcu> [PIN=<n>] [LEDS=<n>]"
	@echo "  make upload MCU=<mcu> [PIN=<n>] [LEDS=<n>] [PORT=<port>]"
	@echo "  make run MCU=<mcu> [PIN=<n>] [LEDS=<n>] [PORT=<port>]"
	@echo "  make monitor [PORT=<port>]"
	@echo "  make clean"
	@echo "  make ports"
	@echo ""
	@echo "$(YELLOW)Доступные МК:$(NC)"
	@echo "  esp32, esp32c3, esp32s2, esp8266"
	@echo "  nano, uno, mega, bluepill"
	@echo ""
	@echo "$(YELLOW)Примеры:$(NC)"
	@echo "  make build MCU=esp32c3 PIN=8 LEDS=60"
	@echo "  make upload MCU=nano PIN=3 PORT=/dev/ttyUSB0"
	@echo "  make run MCU=esp32 PORT=/dev/cu.usbserial-0001"
	@echo ""
