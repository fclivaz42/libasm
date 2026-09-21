#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <strings.h>

#define SMALL 16
#define NORMAL 1024
#define HUGE 65536

size_t	ft_write(int fd, const void *buf, int count);

static int	w_errno_test()
{
	int		err, cmperr;
	char	fah[] = "Hello wordl!\n";
	ssize_t	bytes = 0, cmpbytes = 0;

	bytes = write(12, fah, strlen(fah));
	perror("Errno test ");
	err = errno;

	errno = 0;

	cmpbytes = ft_write(12, fah, strlen(fah));
	perror("Match above");
	cmperr = errno;

	if (bytes != cmpbytes)
	{
		printf("ERROR! bytes are not the same: %zd, %zd\n", bytes, cmpbytes);
		return 1;
	}
	else
		printf("Bytes written match: %zd, %zd\n", bytes, cmpbytes);

	if (bytes != cmpbytes)
	{
		printf("ERROR! Errno is not the same: %d, %d\n", err, cmperr);
		return 1;
	}
	else
		printf("Errno matches: %d, %d\n", err, cmperr);

	return 0;
}

static int	write_things_to_stdout(const char* buf)
{
	ssize_t bytes, cmpbytes;

	printf("write():\n");
	bytes = write(STDOUT_FILENO, buf, strlen(buf));
	printf("\n");

	printf("ft_write():\n");
	cmpbytes = ft_write(STDOUT_FILENO, buf, strlen(buf));
	printf("\n");

	if (bytes != cmpbytes)
	{
		printf("ERROR! bytes are not the same: %zd, %zd\n", bytes, cmpbytes);
		return 1;
	}
	else
		printf("Bytes written match: %zd, %zd\n", bytes, cmpbytes);
	return 0;
}

int write_tests()
{
	size_t	size = 1024 + 1;
	char	*huge = (char *)malloc(size);
	char	mt[] = "";
	char	str[] = "string!";
	char	*heap = malloc(strlen(str));

	strcpy(heap, str);
	if (!huge)
		return 1;
	memset(huge, 'a', size);
	huge[size - 1] = 0;

	printf("----\nEmpty string:\n----\n");
	if (write_things_to_stdout(mt))
		return 1;

	printf("----\nHUGE string:\n----\n");
	if (write_things_to_stdout(huge))
		return 1;

	printf("----\nStack, normal string:\n----\n");
	if (write_things_to_stdout(str))
		return 1;

	printf("----\nHeap, normal string:\n----\n");
	if (write_things_to_stdout(heap))
		return 1;

	printf("----\nERRNO:\n----\n");
	if (w_errno_test())
		return 1;

	return 0;
}
