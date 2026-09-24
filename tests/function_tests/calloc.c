#include <stdio.h>
#include <errno.h>
#include <limits.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <strings.h>
#include <sys/resource.h>
#include <sys/wait.h>

void	*ft_calloc(size_t n, size_t size);

int calloc_limits()
{
	struct rlimit	set;
	int				err, cmperr;
	long			bytes = 1024 * 1024;

	set.rlim_cur = bytes;
	set.rlim_max = bytes;
	if (setrlimit(RLIMIT_AS, &set) < 0)
	{
		perror("FATAL");
		return 1;
	}

	printf("Testing OOM returns...\n");

	char	*tfal = calloc(1024 * 1024, sizeof(int));
	perror("Errno test ");
	err = errno;

	errno = 0;

	char	*fail = ft_calloc(1024 * 1024, sizeof(int));
	perror("Match above");
	cmperr = errno;

	if (fail)
	{
		printf("ERROR: Successfully allocated or returned when it shouldnt! %p\n", fail);
		free(fail);
		return 1;
	}
	if (err != cmperr)
	{
		printf("ERROR! Errno is not the same: %d, %d\n", err, cmperr);
		return 1;
	}
	else
		printf("Errno matches: %d, %d\n", err, cmperr);

	if (tfal)
		free (tfal);
	if (fail)
		free (fail);
	return 0;
}

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
		exit(calloc_limits());

	waitpid(pid, &retstat, 0);

	if (WEXITSTATUS(retstat))
		return 1;
	return 0;
}
