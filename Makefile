LIB-PATH=-I ./lib/ -I ../perl6-typesafe-html/lib/

lib/Typesafe/XHTML/Writer.pm6: bin/generate-function-definition.p6 Build.pm
	perl6 $(LIB-PATH) -M Build -e 'Build.new.build(".")'

bin/benchmark.p6: bin/generate-benchmark.p6
	perl6 $(LIB-PATH) $< > $@

TESTS=t/basic.t t/skeleton.t t/parametric.t

$(TESTS): lib/Typesafe/XHTML/Writer.pm6

benchmark: bin/benchmark.p6
	perl6 $(LIB-PATH) $< > /dev/null

test: t/basic.t
	prove -v --exec "perl6 $(LIB-PATH)" -r ./t/

lib: lib/Typesafe/XHTML/Writer.pm6


all: lib test benchmark
