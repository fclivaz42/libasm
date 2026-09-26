#include "includes.h"

int limits(enum memmode md)
{
	struct rlimit	set;
	int				err, cmperr;
	long			bytes = 1024 * 1024;
	char			huge[bytes + 1];
	char			*test_fail, *orig;

	if (md == DUP)
	{
		memset(huge, 'a', 1024 * 1024);
		huge[1024 * 1024] = 0;
	}

	set.rlim_cur = bytes;
	set.rlim_max = bytes;
	if (setrlimit(RLIMIT_AS, &set) < 0)
	{
		perror("FATAL");
		return 1;
	}

	printf("Testing OOM returns...\n");

	switch (md)
	{
		case DUP:
			orig = strdup(huge);
			break;
		case CALLOC:
			orig = calloc(bytes, sizeof(int));
			break;
	}
	perror("Errno test ");
	err = errno;

	errno = 0;

	switch (md)
	{
		case DUP:
			test_fail = ft_strdup(huge);
			break;
		case CALLOC:
			test_fail = ft_calloc(bytes, sizeof(int));
			break;
	}
	perror("Match above");
	cmperr = errno;

	if (test_fail)
	{
		printf("ERROR: Successfully allocated or returned when it shouldnt! %p\n", test_fail);
		free(test_fail);
		return 1;
	}
	if (err != cmperr)
	{
		printf("ERROR! Errno is not the same: %d, %d\n", err, cmperr);
		return 1;
	}
	else
		printf("Errno matches: %d, %d\n", err, cmperr);

	if (orig)
		free (orig);
	if (test_fail)
		free (test_fail);
	return 0;
}
