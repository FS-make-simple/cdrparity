CC		= gcc
CXX		= g++
CXXLD		= g++

PREFFLAGS	= -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wall -Wextra -Os
CFLAGS		= $(PREFFLAGS)
CXXFLAGS	= $(PREFFLAGS) -std=c++11
LDFLAGS		=

PROGS	= siphash24_test \
	  cdrparity cdrparity-v1 \
	  cdrverify cdrrepair cdrrescue

all:	$(PROGS)

install:	$(PROGS)
	cp $(PROGS) ../../bin

siphash24_test:	src/siphash24_test.o src/siphash24.o src/siphash24inc.o
	$(CXXLD) -o $@ $^ $(LDFLAGS)

cdrparity:	src/cdrparity.o src/siphash24inc.o
	$(CXXLD) -o $@ $^ $(LDFLAGS)

cdrparity-v1:	src/cdrparity-v1.o src/Marker.o
	$(CXXLD) -o $@ $^ $(LDFLAGS)

cdrverify:	src/cdrverify.o src/cdrverify-v1.o src/cdrverify-v2.o src/siphash24.o
	$(CXXLD) -o $@ $^ $(LDFLAGS)

cdrrepair:	src/cdrrepair.o src/siphash24.o
	$(CXXLD) -o $@ $^ $(LDFLAGS)

cdrrescue:	src/cdrrescue.o src/Marker.o
	$(CXXLD) -o $@ $^ $(LDFLAGS)

clean:
	rm -f $(PROGS) src/*.o *~ core
