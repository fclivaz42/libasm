#include "includes.h"

int	rw_errno_test(enum rwmode rw)
{
	int		err, cmperr;
	char	fah[] = "Hello wordl!\n";
	ssize_t	bytes = 0, cmpbytes = 0;
	char	buf[NORMAL + 1];
	char	cmpbuf[NORMAL + 1];

	printf("----\nERRNO:\n----\n");
	switch (rw)
	{
		case READ:
			bytes = read(12, buf, NORMAL);
			break;
		case WRITE:
			bytes = write(12, fah, strlen(fah));
			break;
	}
	perror("Errno test ");
	err = errno;

	errno = 0;

	switch (rw)
	{
		case READ:
			cmpbytes = ft_read(12, cmpbuf, NORMAL);
			break;
		case WRITE:
			cmpbytes = ft_write(12, fah, strlen(fah));
			break;
	}
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

	if (err != cmperr)
	{
		printf("ERROR! Errno is not the same: %d, %d\n", err, cmperr);
		return 1;
	}
	else
		printf("Errno matches: %d, %d\n", err, cmperr);

	return 0;
}
