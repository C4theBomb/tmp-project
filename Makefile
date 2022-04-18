CC = g++
FLAGS = -g -c

LIB_OBJ = $(patsubst src/%.cpp, build/%.o, $(wildcard src/**/*.cpp))
OBJECTS = $(patsubst src/%.cpp, build/%.o, $(wildcard src/*.cpp))
TEST_SRC = $(wildcard test/**/*.cpp)

LIBS = 

.PHONY: all
all: libs
	mkdir -p bin
	$(CC) $(LIBS) src/main.cpp -o bin/main

compile: $(LIB_OBJ) $(OBJECTS)

libs: 

.PHONY: test
test:
	mkdir -p bin
	$(CC) -g -Iinclude $(TEST_SRC) test/test.cpp -o bin/test

%.so: $(LIB_OBJ)
	mkdir -p libs
	$(CC) -shared -o libs/lib$@ $(wildcard build/$(*F)/*.o)

$(LIB_OBJ): build/%.o: src/%.cpp
	mkdir -p $(@D)
	$(CC) $(FLAGS) $< -o $@

$(OBJECTS): build/%.o: src/%.cpp
	mkdir -p $(@D)
	$(CC) $(FLAGS) $< -o $@

clean:
	rm -rf ./build/*
	rm -rf ./libs/*
	rm -rf ./bin/*
	find ./test -type f -name "test" -exec rm {} \;