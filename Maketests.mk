TESTNAME	=	${TESTDIR}/libasm_test

TESTDEPS	=	${TESTS}

TESTDIR		=	tests

TESTOBJDIR	=	objtest

TESTSRC		=	${TESTDIR}/the_unit.c \
				${TESTDIR}/function_tests/calloc.c \
				${TESTDIR}/function_tests/read.c \
				${TESTDIR}/function_tests/strcmp.c \
				${TESTDIR}/function_tests/strcpy.c \
				${TESTDIR}/function_tests/strdup.c \
				${TESTDIR}/function_tests/strlen.c \
				${TESTDIR}/function_tests/write.c \
				${TESTDIR}/function_tests/common/errno_test.c \
				${TESTDIR}/function_tests/common/memlimits.c

TESTSRCTREE	=	$(shell find tests -type d)

TESTOBJ		=	$(TESTSRC:${TESTDIR}/%.c=${TESTOBJDIR}/%.o)

TESTOBJTREE	=	$(TESTSRCTREE:tests%=${TESTOBJDIR}%)

${TESTOBJDIR}/%.o:	${TESTDIR}/%.c | ${TESTOBJDIR}
				gcc -g3 -fno-omit-frame-pointer -c $< -o $@

${TESTOBJDIR}:
		mkdir -p ${TESTOBJTREE}

${TESTNAME}: ${TESTDEPS}
		${MAKE} ${TESTOBJ}
		gcc -g3 -fno-omit-frame-pointer ${TESTOBJ} -o ${TESTNAME} ${NAME}

tests: ${TESTNAME}

test: all tests
	${TESTDIR}/libasm_test

cleantest:
	@rm -rf ${TESTOBJDIR}
	@rm -rf ${TESTNAME}
