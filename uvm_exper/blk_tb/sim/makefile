
# point to make.defs
DEPTH=../..

# defaults
TEST=test_base
SEED=1234

# Compile time args
CTARGS=
# Run time args
RTARGS=

# waves
WAV=

UCDBFILE=test.ucdb

#------------------------------------------------
#------------------------------------------------
# dirpaths and top
include $(DEPTH)/make.defs
include make.testlist

TESTDIR=test_$(@)_$(SEED)
ifneq ("$(NOMKDIR)", "1")
MKDIR= mkdir -p $(TESTDIR)
endif

ifneq ("$(WAV)", "1")
VSIMI+=-c
endif

VOPTOPTS= +acc $(TOP) -o $(TOPOPT)
VOPT=vopt  $(VOPTOPTS)

# include paths
INCDIRS+=+incdir+$(AGENTS_DIR)
INCDIRS+=+incdir+$(SEQ_DIR)
INCDIRS+=+incdir+$(VSEQ_DIR)
INCDIRS+=+incdir+$(ENV_DIR)
INCDIRS+=+incdir+$(TEST_DIR)
INCDIRS+=+incdir+$(RTL_DIR)
INCDIRS+=+incdir+$(TB_DIR)

# compile:
#   design units: packages, interfaces, top and rtl
CTOPTS+=-incr
CTOPTS+=$(INCDIRS)
CTOPTS+=$(AGENTS_DIR)/agent_pkg.sv
CTOPTS+=$(AGENTS_DIR)/bus_seq_pkg.sv
CTOPTS+=$(AGENTS_DIR)/*_if.sv
CTOPTS+=$(SEQ_DIR)/seq_lib_pkg.sv
CTOPTS+=$(SEQ_DIR)/sv_example_seq_pkg.sv
CTOPTS+=$(VSEQ_DIR)/vseq_lib_pkg.sv
CTOPTS+=$(ENV_DIR)/env_pkg.sv
CTOPTS+=$(TEST_DIR)/test_lib_pkg.sv
CTOPTS+=$(RTL_DIR)/*.*v
CTOPTS+=$(TB_DIR)/$(TOP).sv
CTOPTS+=$(BUILDLOG_ARG)

RTOPTS=

#------------------------------------------------

# First target; show usage
full_usage: usage showtests

usage: 
	@echo "Usage: make [args]" ;
	@echo "  args : clean, clobber, showtests, all" ;
	@echo "       : work, build" ; 
	@echo "       : <testname>" ;
	@echo "       : CTARGS=<...>" ;
	@echo "       : RTARGS=<...>" ;
	@echo "       : dumpargs" ;
	@echo "       : dispdefs" ;
	@echo "       : tarup" ;

showtests:
	@echo "" ;
	@echo "  <testname>:"
	@for i in $(TESTNAMES) ; do \
		echo "    $$i" ;					\
		done

all: clean work build $(TEST)

work:
	vlib work

build compile: work dumpargs
	vlog $(CTOPTS) $(CTARGS)
	$(VOPT)

sim run: $(TEST)

# run rule if any target matches test in TESTNAMES list (make.testlist)

$(TESTNAMES):
	$(MKDIR) 
	vsim -lib $(WORKDIR)/work \
	$(VSIMI)  \
	$(RTARGS) \
	-sv_seed $(SEED) +SEED=$(SEED) \
	-do "coverage save $(TESTDIR)/$(UCDBFILE); \
			run -all; quit;"        \
	$(TOPOPT) +UVM_TESTNAME=$@  \
	-l $(TESTDIR)/vsim.log


#-do "coverage attribute -name TESTNAME -value randtest_$(SEED); \
#coverage attribute -name TESTNAME -value randtest_$(SEED)
#coverage save $(UCDBFILE)

clean:
	rm -rf work transcript *~ vsim*

clobber: clean
	rm -rf test_* *.log $(BUILDLOG_DIR)* *.ucdb sim.args

# debug
dispdefs:
	@(echo "  DEPTH         : $(DEPTH)" ;      		\
    echo "  WORKDIR       : $(WORKDIR)" ; 			\
    echo "  BUILDDIR      : $(BUILDDIR)" ;   		\
    echo "  BUILDLOG_DIR  : $(BUILDLOG_DIR)" ; 	\
    echo "  BUILDLOG_ARG  : $(BUILDLOG_ARG)" ; 	\
    echo "  RTL_DIR       : $(RTL_DIR)" ;    		\
    echo "  AGENTS_DIR    : $(AGENTS_DIR)" ; 		\
    echo "  BLOCKTB_DIR   : $(BLOCKTB_DIR)" ;		\
    echo "  SIM_DIR       : $(SIM_DIR)" ;    		\
    echo "  SEQ_DIR       : $(SEQ_DIR)" ;    		\
    echo "  VSEQ_DIR      : $(VSEQ_DIR)" ;   		\
    echo "  ENV_DIR       : $(ENV_DIR)" ;    		\
    echo "  TEST_DIR      : $(TEST_DIR)" ;   		\
    echo "  TB_DIR        : $(TB_DIR)" ;     		\
    )


# compile options and args for third-party tools; dvt
dumpargs:
	@echo "$(CTOPTS) $(CTARGS)" > sim.args

tarup: clobber
	@(cd $(TAR_DIR) ; \
	tar -zcf $(PROJ).tgz  $(PROJ) ; \
	ls -1 $(PROJ).tgz )


