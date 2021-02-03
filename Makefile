INPUT = skeleton.cr

all:
	crystal src/$(INPUT)

build:
	shards build

run:
	./bin/shards

document:
	$(RM) -r ./docs
	crystal docs src/*.cr

clean:
	$(RM) -r ./bin
