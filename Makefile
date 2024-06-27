# Compiler and flags
CC:=gcc
CFLAGS:=-Wall -Wextra -Werror -O2 -fPIE -fstack-protector-strong \
		-D_FORTIFY_SOURCE=2 -g
#CFLAGS:=-Wall -Wextra -Werror -O2 -fPIE -fstack-protector-strong \
#		 -D_FORTIFY_SOURCE=2
SANITIZE_FLAGS:= -fsanitize=address -fsanitize=undefined

# Directories
BUILD_DIR := ./build
SRC_DIR := ./src
INC_DIR := ./include
LIB_DIR := ./lib

# Source files
SRCS := $(shell find $(SRC_DIR) -name '*.c')

# Object files
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

# Header files
INCS := $(shell find $(INC_DIR) -name '*.h')

# Shared library
LIB_NAME:=libft_malloc.so
ifeq ($(HOSTTYPE),)
	HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif
TARGET := libft_malloc_$(HOSTTYPE).so
LIB_PATH:=$(LIB_DIR)/$(TARGET)
SYMLINK_PATH:=./$(LIB_NAME)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(INCS)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(SANITIZE_FLAGS) -I$(INC_DIR) -c $< -o $@

test:

all: $(LIB_PATH) $(SYMLINK_PATH)

$(LIB_PATH): $(OBJS) 
	@mkdir -p $(LIB_DIR)
	$(CC) -shared -o $@ $^

$(SYMLINK_PATH): $(LIB_PATH)
	ln -sf $(LIB_PATH) $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

.PHONY: fclean
fclean: clean
	rm -f $(TARGET)

.PHONY: re
re: fclean all
