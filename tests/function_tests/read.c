#include "common/includes.h"

static	int loop_test(const int size, const char* desc)
{
	int		fd, diff;
	ssize_t	bytes = 0, cmpbytes = 0;
	char	buf[size + 1];
	char	cmpbuf[size + 1];

	printf("----\n%s string:\n----\n", desc);
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

int	read_tests()
{
	if (loop_test(SMALL, "Small"))
		return 1;
	if (loop_test(NORMAL, "Normal"))
		return 1;
	if (loop_test(HUGE, "BIG"))
		return 1;

	if (rw_errno_test(READ))
		return 1;

	return 0;
}
