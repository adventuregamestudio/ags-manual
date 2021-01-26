.POSIX:
.SUFFIXES:

all: release.yml test.yml

.SUFFIXES: .m4 .yml
.m4.yml:
	m4 $< > $@

clean:
	rm -f *.yml
