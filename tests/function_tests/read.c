#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <strings.h>

#define SMALL 16
#define NORMAL 1024
#define HUGE 65536

size_t	ft_read(int fd, void *buf, int count);

static	int loop_test(const int size)
{
	int		fd, diff;
	ssize_t	bytes = 0, cmpbytes = 0;
	char	buf[size + 1];
	char	cmpbuf[size + 1];

	bzero(buf, size + 1);
	bzero(cmpbuf, size + 1);

	fd = open("./Makefile", O_RDONLY);
	if (fd < 0 + 1)
	{
		perror("FATAL open");
		return -1;
	}

	bytes = read(fd, buf, size);
	close(fd);

	fd = open("./Makefile", O_RDONLY);
	if (fd < 0)
	{
		perror("FATAL open");
		return -1;
	}

	cmpbytes = ft_read(fd, cmpbuf, size);
	close(fd);

	if (bytes != cmpbytes)
	{
		printf("ERROR! bytes are not the same: %zd, %zd\n", bytes, cmpbytes);
		return 1;
	}
	else
		printf("Bytes read match: %zd, %zd\n", bytes, cmpbytes);

	buf[bytes] = 0;
	cmpbuf[cmpbytes] = 0;

	diff = strcmp(buf, cmpbuf);
	if (diff)
	{
		printf("ERROR! Difference in strcmp: %d\n", diff);
		return 1;
	}
		printf("Success for buffer: %s\n", cmpbuf);

	return 0;
}

static int	r_errno_test()
{
	int		err, cmperr;
	ssize_t	bytes = 0, cmpbytes = 0;
	char	buf[NORMAL + 1];
	char	cmpbuf[NORMAL + 1];

	bytes = read(12, buf, NORMAL);
	perror("Errno test ");
	err = errno;

	errno = 0;

	cmpbytes = ft_read(12, cmpbuf, NORMAL);
	perror("Match above");
	cmperr = errno;

	if (bytes != cmpbytes)
	{
		printf("ERROR! bytes are not the same: %zd, %zd\n", bytes, cmpbytes);
		return 1;
	}
	else
		printf("Bytes read match: %zd, %zd\n", bytes, cmpbytes);

	if (err != cmperr)
	{
		printf("ERROR! Errno is not the same: %d, %d\n", err, cmperr);
		return 1;
	}
	else
		printf("Errno matches: %d, %d\n", err, cmperr);

	return 0;
}

int	read_tests()
{
	printf("----\nSmall buffer:\n----\n");
	if (loop_test(SMALL))
		return 1;
	printf("----\nNormal buffer:\n----\n");
	if (loop_test(NORMAL))
		return 1;
	printf("----\nBIG buffer:\n----\n");
	if (loop_test(HUGE))
		return 1;

	printf("----\nERRNO:\n----\n");
	if (r_errno_test())
		return 1;

	return 0;
}
