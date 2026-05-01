CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -MMD -MP -Iinc
BUILD_DIR = build
SRCS = $(wildcard src/*.c)
OBJS = $(patsubst src/%.c,$(BUILD_DIR)/%.o,$(SRCS))
DEPS = $(OBJS:.o=.d)
TARGET = program

ifeq ($(OS), Windows_NT)
    CFLAGS += -I./PDCurses
    LIBS = -L./PDCurses/wincon -lcurses
    TARGET := $(TARGET).exe
else
    LIBS = -lncurses
endif

# Cross-platform handlind.

$(TARGET): $(OBJS) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LIBS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: src/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

-include $(DEPS)

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(TARGET)

.PHONY: clean