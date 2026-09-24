#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <strings.h>
#include <sys/resource.h>
#include <sys/wait.h>

char	*ft_strdup(const char *s);

int limits(char* huge)
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

	char	*tfal = strdup(huge);
	perror("Errno test ");
	err = errno;

	errno = 0;

	char	*fail = ft_strdup(huge);
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
	free(huge);
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

	if (memcmp(mt, dup1, 1))
	{
		printf("ERROR: %p and %p do not have the same contents!\n", mt, dup1);
		return 1;
	}
	else
		printf("Success! Contents: %s\n", dup1);

	if (memcmp(stack, dup2, strlen(stack)))
	{
		printf("ERROR: %p and %p do not have the same contents!\n", stack, dup2);
		return 1;
	}
	else
		printf("Success! Contents: %s\n", dup2);

	if (memcmp(heap, dup3, 128 + 1))
	{
		printf("ERROR: %p and %p do not have the same contents!\n", heap, dup3);
		return 1;
	}
	else
		printf("Success! Contents: %s\n", dup3);

	if (memcmp(huge, dup4, 1024 + 1))
	{
		printf("ERROR: %p and %p do not have the same contents!\n", huge, dup4);
		return 1;
	}
	else
		printf("Success! Skipping contents of huge.\n");

	free(heap);
	free(dup1);
	free(dup2);
	free(dup3);
	free(dup4);

	int pid = fork();
	int retstat;

	if (pid == 0)
		exit(limits(huge));

	waitpid(pid, &retstat, 0);

	if (WEXITSTATUS(retstat))
		return 1;

	free(huge);

	return 0;
}
