all: $(patsubst %.scad,%.stl,$(wildcard *.scad))
%.stl: %.scad
	openscad -o $@ $^
