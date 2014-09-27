.SUFFIXES: .erl .beam
.erl.beam:
	erlc -W $<

ERL = erl -boot start_clean

MODS  = cat_fsm

all: compile
	${ERL} 

compile: ${MODS:%=%.beam}

clean:
	rm -rf *.beam erl_crash.dump
