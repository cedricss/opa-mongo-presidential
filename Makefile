########################################
# USER VARIABLES

EXE = election.exe
PACKNAME =
SRC =
MAINSRC = src/main.opa
PCKDIR = ./pck/
PCK = bootstrap.tabs.opx
PLUGIN =
PLUGINDIR =

# Build exe
default: exe

# Run Server
run: exe
	./$(EXE) $(RUN_OPT) || exit 0 ## prevent ugly make error 130 :) ##


include Makefile.common
