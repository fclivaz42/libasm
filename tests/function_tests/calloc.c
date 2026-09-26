#include "common/includes.h"

void	*ft_calloc(size_t n, size_t size);

int	calloc_tests()
{
	size_t	size1 = 125;
	size_t	size2 = 102050;
	char	*smol = ft_calloc(size1, sizeof(char));
	char	*larg = ft_calloc(size2, sizeof(double));
	char	*toobig = ft_calloc(-1, 2);

	printf("Checking for overflow...\n");
	if (toobig != NULL)
	{
		printf("ERROR: Multiplication isn't checked properly!\n");
		return 1;
	}
	else
		printf("NULL returned, all good.\n");

	printf("Checking for correctly sized allocations...\n");

	memset_explicit(smol, 'a', size1 * sizeof(char));
	smol[size1 - 1] = 0;
	memset_explicit(larg, 'b', size2 * sizeof(double));
	larg[(size2 * sizeof(double)) - 1] = 0;

	if (strlen(smol) != (size1 - 1) || strlen(larg) != ((size2 * sizeof(double)) - 1))
	{
		printf("ERROR: Somehow memset correctly but sizes do not match!\n");
		return 1;
	}
	else
	{
		printf("If you can read this, you did not segfault meaning all is good. Yippie!\n");
	}
	free(smol);
	free(larg);

	int pid = fork();
	int retstat;

	if (pid == 0)
		exit(limits(CALLOC));

	waitpid(pid, &retstat, 0);

	if (WEXITSTATUS(retstat))
		return 1;
	return 0;
}
