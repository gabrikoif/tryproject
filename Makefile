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
    MKDIR = mkdir $(BUILD_DIR)
else
    LIBS = -lncurses
    MKDIR = mkdir -p $(BUILD_DIR)
endif

$(TARGET): $(OBJS) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) $(LIBS)

$(BUILD_DIR):
	$(MKDIR)

$(BUILD_DIR)/%.o: src/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

-include $(DEPS)

clean:
ifeq ($(OS), Windows_NT)
	rmdir /s /q $(BUILD_DIR)
	del $(TARGET)
else
	rm -rf $(BUILD_DIR)
	rm -f $(TARGET)
endif

.PHONY: clean