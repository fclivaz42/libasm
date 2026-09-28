#pragma once

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <limits.h>
#include <stddef.h>
#include <string.h>
#include <strings.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/resource.h>

enum memmode
{
	CALLOC	= 0,
	DUP		= 1
};

enum rwmode
{
	READ	= 0,
	WRITE		= 1
};

typedef struct	s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

#define SMALL 16
#define NORMAL 1024
#define HUGE 65536

void	*ft_calloc(size_t n, size_t size);
char	*ft_strdup(const char *s);

size_t	ft_write(int fd, const void *buf, int count);
size_t	ft_read(int fd, void *buf, int count);
int		ft_strcmp(const char *s1, const char *s2);
char	*ft_strcpy(char *restrict dst, const char *restrict src);
char	*ft_strdup(const char *s);
size_t	ft_strlen(const char *str);

void	ft_list_push_front(t_list **begin_list, void *data);
uint	ft_list_size(t_list *begin_list);

int		limits(enum memmode md);
int		rw_errno_test(enum rwmode rw);

int		read_tests(void);
int		write_tests(void);
int		strlen_tests(void);
int		strcpy_tests(void);
int		strcmp_tests(void);
int		strdup_tests(void);
int		calloc_tests(void);
int		list_push_front_tests(void);
int		list_remove_if_tests(void);
int		list_size_tests(void);
int		list_sort_tests(void);
int		simd_memchr_tests(void);
int		atoi_base_tests(void);
