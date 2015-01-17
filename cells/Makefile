LIB_NAME  = sxlib
LIB_FILE  = $(LIB_NAME)-obj93.cf
VHDL_SRCS = $(wildcard *.vhd)
VHDL_OBJS = $(VHDL_SRCS:.vhd=.o)
VHDLFLAGS = --work=$(LIB_NAME)

all: $(VHDL_OBJS)

%.o: %.vhd
	ghdl -a $(VHDLFLAGS) -o $@ $^

clean:
	rm -f $(VHDL_OBJS) $(LIB_FILE)
