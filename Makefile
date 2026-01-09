# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/01/09 18:23:20 by fclivaz           #+#    #+#              #
#    Updated: 2026/01/09 18:48:32 by fclivaz          ###   LAUSANNE.ch        #
#                                                                              #
# **************************************************************************** #

export MAKEFLAGS += --silent

NAME	= libasm.a

SHELL	= /bin/bash

COMP = nasm

DEPS	=	${SRCS}

SRCS	=	${SUBDIR}/base/ft_strlen.s \
			${SUBDIR}/base/ft_strcpy.s \
			${SUBDIR}/base/ft_strcmp.s \
			${SUBDIR}/base/ft_strdup.s \
			${SUBDIR}/base/ft_write.s \
			${SUBDIR}/base/ft_read.s

BONUS	=	${SUBDIR}/base/ft_atoi_base.s \
			${SUBDIR}/base/ft_list_push_front.s \
			${SUBDIR}/base/ft_list_size.s \
			${SUBDIR}/base/ft_list_sort.s \
			${SUBDIR}/base/ft_list_remove_if.s

SUBDIR	= srcs

SRCTREE	= $(shell find srcs -type d)

OBJ		= $(SRCS:${SUBDIR}/%.s=${OBJDIR}/%.o)

OBJDIR	= obj

OBJTREE	= $(SRCTREE:srcs%=${OBJDIR}%)

FLAGS= -f elf64

CRED = \033[1;31m
CGRN = \033[1;32m
CYEL = \033[1;33m
RSET = \033[0m

all:	${NAME}

${NAME}:	${DEPS}
		@if [[ $(if $(filter r,${MAKECMDGOALS}),1,0) == "1" ]]; then \
			printf "├──────────\n"; \
		else \
			printf "┌──────────\n"; \
		fi
		@${MAKE} ${OBJ}
		@printf "│\tSources for ${CGRN}${NAME}${RSET} done.\n"
		@ar rc ${NAME} ${OBJ}
		@printf "├──────────\n├─>>> ${CGRN}${NAME}${RSET} compiled!\n└──────────\n"

${OBJDIR}/%.o:	${SUBDIR}/%.s | ${OBJDIR}
				@printf "│\t > Compiling ${CYEL}$<${RSET} for ${CGRN}${NAME}${RSET}...\r"
				@${COMP} ${FLAGS} $< -o $@
				@printf "\33[2K"

${OBJDIR}:
		@printf "│ Compiling ${CGRN}${NAME}${RSET}...\n"
		@printf "│\tCreating ${CYEL}${OBJTREE}${RSET} for ${CGRN}${NAME}${RSET}\n"
		@mkdir -p ${OBJTREE}

clean:
		@if [[ $(if $(filter r,${MAKECMDGOALS}),1,0) == "1" ]]; then \
			printf "├──────────\n"; \
		else \
			printf "┌──────────\n"; \
		fi
		@if [ -d "./${OBJDIR}" ]; then \
			printf "│\tRemoving ${CRED}${OBJDIR}${RSET} for ${CYEL}${NAME}${RSET}\n"; \
			rm -rf ${OBJDIR}; \
		else \
			if [[ $(if $(filter fclean,${MAKECMDGOALS}),1,0) == "1" ]]; then \
				printf "│\t${CYEL}${OBJDIR}${RSET} already removed!\n├──────────\n"; \
			else \
				printf "│\t${CYEL}${OBJDIR}${RSET} already removed!\n└──────────\n"; \
			fi; \
		fi
		@if [ -d "./${NAME}.dSYM" ]; then \
			printf "│\tRemoving ${CYEL}${NAME}.dSYM${RSET}\n"; \
			rm -rf ${NAME}.dSYM; \
		fi

fclean: clean
		@if [ -e "./${NAME}" ]; then \
			if [[ $(if $(filter r,${MAKECMDGOALS}),1,0) == "1" ]]; then \
				printf "│\tRemoving ${CYEL}${NAME}${RSET}\n"; \
			else \
				printf "│\tRemoving ${CYEL}${NAME}${RSET}\n└──────────\n"; \
			fi; \
			rm -f ${NAME}; \
		else \
			if [[ $(if $(filter r,${MAKECMDGOALS}),1,0) == "1" ]]; then \
				printf "│\t${CYEL}${NAME}${RSET} already removed!\n├──────────\n"; \
			else \
				printf "│\t${CYEL}${NAME}${RSET} already removed!\n└──────────\n"; \
			fi; \
		fi

re:
		@printf "\n┌──────────\n│ Cleaning and ${CGRN}recompiling${RSET}...\n"
		@${MAKE} fclean r
		@${MAKE} all r

.PHONY: all fclean clean re

$(eval r:;@:)
