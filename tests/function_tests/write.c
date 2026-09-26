#include "common/includes.h"

static int	write_things_to_stdout(const char* buf, const char* desc)
{
	ssize_t bytes, cmpbytes;

	printf("----\n%s string:\n----\n", desc);
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
	char	*heap = malloc(strlen(str) + 1);

	strcpy(heap, str);
	if (!huge)
		return 1;
	memset(huge, 'a', size);
	huge[size - 1] = 0;

	if (write_things_to_stdout(mt, "Empty"))
		return 1;

	if (write_things_to_stdout(huge, "HUGE"))
		return 1;

	if (write_things_to_stdout(str, "Stack, normal"))
		return 1;

	if (write_things_to_stdout(heap, "Heap, normal"))
		return 1;

	if (rw_errno_test(WRITE))
		return 1;

	free(heap);
	free(huge);

	return 0;
}
