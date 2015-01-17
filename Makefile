SRC_DIR   = src
TEST_DIR  = tests
BUILD_DIR = build
INC_DIR   = $(TEST_DIR)/include
OBJ_DIR	  = $(BUILD_DIR)/obj

TARGET   = slice_tb#amd_tb
MAIN_BIN = $(BUILD_DIR)/$(TARGET)

ARCH = $(shell uname -m)

# Alliance tools

ifeq (x$(MBK_TARGET_LIB),x)
define errmsg
MBK_TARGET_LIB is not defined. Make sure the Alliance tools are properly setup.
You probably have to run something like source /path/to/alliance/etc/alc_env.sh
endef
$(error $(errmsg))
endif

VASY ?= vasy
BOOM ?= boom
BOOG ?= boog

BOOM_OPT_LEVEL ?= 3
BOOM_FLAGS = -l $(BOOM_OPT_LEVEL)

export MBK_WORK_LIB = $(shell pwd)/$(BUILD_DIR)

# Coriolis tools

ifeq (x$(CORIOLIS_TOP),x)
define errmsg
CORIOLIS_TOP is not defined. Make sure the Coriolis tools are properly setup.
You probably have to run something like eval `/path/to/coriolis/etc/coriolis2/coriolisEnv.py`
endef
$(error $(errmsg))
endif

# sxlib and pxlib cells library

CELLS_LIBDIR = cells
CELLS_SRCS = $(wildcard $(CELLS_LIBDIR)/*.vhd)
CELLS_OBJS = $(CELLS_SRCS:$(CELLS_LIBDIR)/%.vhd=$(OBJ_DIR)/%.o)

# VHDL variables

VHDL_WORKLIB  = amd2901
VHDL_WORKDIR  = $(OBJ_DIR)
VHDL_WORKFILE = $(VHDL_WORKDIR)/$(VHDL_WORKLIB)-obj93.cf
VHDL_SRCDIR   = $(SRC_DIR)

VHDL_SRCS 	   = accu alu mux_in mux_out ram core amd2901 slice
VHDL_TEST_SRCS = amd_iss slice_tb#amd_tb
VHDL_ALL_SRCS  = $(VHDL_SRCS) $(VHDL_TEST_SRCS)

VHDL_OBJS += $(VHDL_ALL_SRCS:%=$(VHDL_WORKDIR)/%.o)
VHDLFLAGS += --work=$(VHDL_WORKLIB) --workdir=$(VHDL_WORKDIR)

# Native code

ASM_SRCS += $(wildcard $(TEST_DIR)/$(ARCH)/*.s)
ASM_OBJS += $(ASM_SRCS:$(TEST_DIR)/$(ARCH)/%.s=$(OBJ_DIR)/%.o)

C_SRCS += $(wildcard $(TEST_DIR)/*.c)
C_OBJS += $(C_SRCS:$(TEST_DIR)/%.c=$(OBJ_DIR)/%.o)
CFLAGS += -Wall -I$(INC_DIR)

NATIVE_OBJS = $(C_OBJS) $(ASM_OBJS)
NATIVE_OBJS_LINKFLAGS = $(NATIVE_OBJS:%=-Wl,%)

ALL_OBJS = $(NATIVE_OBJS) $(VHDL_OBJS) $(CELLS_OBJS)

# GHDL needs the sources at link-time. Since those are
# part of a chain of artifacts, we must explicitly tell
# to make to keep them...

VHDL_GENFILES = $(VHDL_SRCS:%=$(BUILD_DIR)/%.vhd)
VHDL_VSTFILES = $(VHDL_SRCS:%=$(BUILD_DIR)/%.vst)
.PRECIOUS: $(VHDL_GENFILES) $(VHDL_VSTFILES)

all: simul
	
simul: $(OBJ_DIR) $(MAIN_BIN)

$(OBJ_DIR):
	mkdir -pv $@

$(MAIN_BIN): $(ALL_OBJS)
	ghdl -m $(VHDLFLAGS) $(NATIVE_OBJS_LINKFLAGS) -o $(MAIN_BIN) $(TARGET)

# don't produce .o, only create the obj93.cf file for
# the GHDL make command that will create them, but use
# this dependency anyway since if the .o exist it's
# unlikely that this will have to be redone...

$(VHDL_WORKDIR)/%.o: $(BUILD_DIR)/%.vhd
	ghdl -i $(VHDLFLAGS) $^

$(VHDL_WORKDIR)/%.o: $(CELLS_LIBDIR)/%.vhd
	ghdl -i $(VHDLFLAGS) $^

$(VHDL_WORKDIR)/%.o: $(TEST_DIR)/%.vhdl
	ghdl -i $(VHDLFLAGS) $^

# rules for native code

$(OBJ_DIR)/%.o: $(TEST_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $^

$(OBJ_DIR)/%.o: $(TEST_DIR)/$(ARCH)/%.s
	$(CC) $(CFLAGS) -c -o $@ $^

# logical synthesis

# step 1: convert from VHDL to Alliance VBE subset
$(BUILD_DIR)/%.vbe: $(VHDL_SRCDIR)/%.vhdl
	cd $(VHDL_SRCDIR) ; $(VASY) -I vhdl -a -p -o $* $*

# step 2: apply boolean minimizations
$(BUILD_DIR)/%_opt.vbe: $(BUILD_DIR)/%.vbe
	$(BOOM) $(BOOM_FLAGS) $* $*_opt

# step 3: logical synthesis itself
$(BUILD_DIR)/%.vst: $(BUILD_DIR)/%_opt.vbe
	$(BOOG) $*_opt $*

# FIXME: generate dynamically
build/core.vst: build/accu.vst build/ram.vst build/alu.vst build/mux_in.vst build/mux_out.vst
build/amd2901.vst: build/core.vst

# other netlists are generated by stratus
$(BUILD_DIR)/%.vst: $(VHDL_SRCDIR)/%.py
	cd $(BUILD_DIR) ; python ../$^

# step 4: convert the result from Alliance VST back to standard VHDL
# add a directive to link them against our cells library
$(BUILD_DIR)/%.vhd: $(BUILD_DIR)/%.vst
	$(VASY) -I vst -s -S -o $* $*

run: all
	cd $(BUILD_DIR) ; ghdl -r $(TARGET) --vcd=../$(TARGET).vcd

clean:
	rm -f  $(ALL_OBJS) $(VHDL_WORKDIR)/e~$(TARGET).o
	rm -f  $(VHDL_GENFILES) $(VHDL_GENFILES:.vhd=.xsc) $(VHDL_VSTFILES)
	rm -f  $(VHDL_WORKFILE)
	rm -f  $(TARGET).vcd
	rm -f  $(MAIN_BIN)
	rm -rf $(BUILD_DIR)
