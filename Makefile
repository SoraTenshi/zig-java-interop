CWD := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
LIB_PATH := $(CWD)zig-out/lib
JAVA_SRC := This

.PHONY: javagen compile clean run

javagen:
	javac -h src/ src/java/$(JAVA_SRC).java

compile: javagen
	zig build
	javac src/java/$(JAVA_SRC).java -d $(CWD)
	rm src/java/$(JAVA_SRC).class

run:
	java -Djava.library.path=$(LIB_PATH) $(JAVA_SRC)

all: javagen compile run clean

clean:
	rm $(JAVA_SRC).class
	rm src/$(JAVA_SRC).h
