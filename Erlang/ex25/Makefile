.SUFFIXES: .erl .beam
.erl.beam:
	erlc -W $<

ERL = erl -boot start_clean

MODS  = mutex

all: compile
	${ERL} 

compile: ${MODS:%=%.beam}

clean:
	rm -rf *.beam erl_crash.dump
