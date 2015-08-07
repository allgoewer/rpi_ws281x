CC = gcc
AR = ar

CCFLAGS = -O3 -Wall -Werror

DEPENDFILE = .depend

SRCLIB = ws2811.c pwm.c dma.c board_info.c mailbox.c
OBJLIB = $(SRCLIB:%.c=%.o)
TARGETLIB = libws2811.a

SRCTEST = main.c
OBJTEST = $(SRCTEST:%.c=%.o)
TARGETTEST = test

all: $(TARGETTEST)

$(TARGETTEST): $(OBJTEST) $(TARGETLIB)
	$(CC) $(CCFLAGS) -static $(OBJTEST) -L. -lws2811 -o $@

%.a: $(OBJLIB)
	$(AR) rcs $@ $+

%.o: %.c
	$(CC) $(CCFLAGS) -c $<

dep: $(SRCLIB)
	$(CC) -MM $^ > $(DEPENDFILE)

clean:
	rm -rf *.o

realclean: clean
	rm -rf $(TARGETTEST) $(TARGETLIB)

.PHONY: clean realclean

-include $(DEPENDFILE)
