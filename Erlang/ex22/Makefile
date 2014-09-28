.SUFFIXES: .erl .beam
.erl.beam:
	erlc -W $<

ERL = erl -boot start_clean

MODS  = dist_demo

all: compile
	${ERL} 

compile: ${MODS:%=%.beam}

clean:
	rm -rf *.beam erl_crash.dump
