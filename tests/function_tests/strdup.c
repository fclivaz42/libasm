#include "common/includes.h"

static inline int	cmp_print_err(const char* s1, const char* s2, size_t cmp_size)
{
	if (memcmp(s1, s2, cmp_size))
	{
		printf("ERROR: %p and %p do not have the same contents!\n", s1, s2);
		return 1;
	}

	if (cmp_size < 1025)
		printf("Success! Contents: %s\n", s2);
	else
		printf("Success! Skipping contents of huge string.\n");

	return 0;
}

int strdup_tests()
{
	char	mt[] = "";
	char	stack[] = "Hello world!";
	char	*heap = malloc(128 + 1);
	char	*huge = malloc(1024 * 1024 + 1);

	memset(heap, 'A', 128);
	memset(huge, 'a', 1024 * 1024);
	heap[128] = 0;
	huge[1024 * 1024] = 0;

	printf("Duplicating...\n");

	char	*dup1 = ft_strdup(mt);
	char	*dup2 = ft_strdup(stack);
	char	*dup3 = ft_strdup(heap);
	char	*dup4 = ft_strdup(huge);

	printf("Duplicated successfully.\n");

	if (cmp_print_err(mt, dup1, 1))
		return 1;

	if (cmp_print_err(stack, dup2, strlen(stack)))
		return 1;

	if (cmp_print_err(heap, dup3, 128 + 1))
		return 1;

	if (cmp_print_err(huge, dup4, 1024 * 1024 + 1))
		return 1;

	free(heap);
	free(dup1);
	free(dup2);
	free(dup3);
	free(dup4);

	int pid = fork();
	int retstat;

	if (pid == 0)
		exit(limits(DUP));

	waitpid(pid, &retstat, 0);

	if (WEXITSTATUS(retstat))
		return 1;

	free(huge);

	return 0;
}
