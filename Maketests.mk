# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Maketests.mk                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/09/26 21:36:07 by fclivaz           #+#    #+#              #
#    Updated: 2026/09/27 17:02:07 by fclivaz          ###   LAUSANNE.ch        #
#                                                                              #
# **************************************************************************** #

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
				${TESTDIR}/function_tests/bonus/list_push_front.c \
				${TESTDIR}/function_tests/bonus/list_remove_if.c \
				${TESTDIR}/function_tests/bonus/list_size.c \
				${TESTDIR}/function_tests/bonus/list_sort.c \
				${TESTDIR}/function_tests/bonus/atoi_base.c \
				${TESTDIR}/function_tests/bonus/simd_memchr.c \
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

test: fclean
	${MAKE} bonus
	${MAKE} tests
	${TESTDIR}/libasm_test

cleantest:
	@rm -rf ${TESTOBJDIR}

fcleantest: cleantest
	@rm -rf ${TESTNAME}
