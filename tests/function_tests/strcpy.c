#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

char	*ft_strcpy(char *restrict dst, const char *restrict src);

static int	copies(char* dst, const char* src, size_t dstsize, char fillchar)
{
	char	*ret, *cmpret;
	char	*dstcmp = malloc(dstsize + 1);
	size_t	bytes;

	memcpy(dstcmp, dst, dstsize + 1);

	printf("strcpy:\t\t");
	fflush(NULL);
	ret = strcpy(dst, src);

	bytes = write(STDOUT_FILENO, ret, dstsize);
	if (bytes < 0)
	{
		perror("strcpy write");
		return -1;
	}

	printf("\nft_strcpy:\t");
	fflush(NULL);
	cmpret = ft_strcpy(dstcmp, src);

	bytes = write(STDOUT_FILENO, cmpret, dstsize);
	if (bytes < 0)
	{
		perror("ft_strcpy write");
		return -1;
	}

	write(STDOUT_FILENO, "\n", 1);
	if (dstcmp != cmpret)
	{
		printf("ERROR! returns are not the same: %p, %p\n", dstcmp, cmpret);
		return 1;
	}
	else
		printf("Returns are the same: %p, %p\n", dstcmp, cmpret);

	if (memcmp(dstcmp, ret, dstsize + 1))
	{
		printf("ERROR! destination buffers are not the same.\n");
		return 1;
	}
	else
		printf("Destination buffers are the same.\n");

	memset(dst, fillchar, dstsize + 1);

	free(dstcmp);
	return 0;
}

int		strcpy_tests()
{
	char	mt[] = "";
	char	stack_dest[50 + 1];
	char	small_source[] = "Hello, World!";
	char	*huge_src = malloc(2000 + 1);
	char	*bigg_dest = calloc(200 + 1, sizeof(char));
	char	*huge_dest = calloc(2000 + 1, sizeof(char));

	memset(huge_src, 'a', 2000);
	memset(stack_dest, 'A', 50);
	huge_src[2000] = 0;

	printf("----\nEmpty string:\n----\n");
	if (copies(stack_dest, mt, 50, 'A'))
		return 1;

	printf("----\nStack-based copy:\n----\n");
	if (copies(stack_dest, small_source, 50, 'A'))
		return 1;

	printf("----\nStack-to-Heap copy:\n----\n");
	if (copies(bigg_dest, small_source, 200, 0))
		return 1;

	printf("----\nHeap-to-Heap copy:\n----\n");
	if (copies(huge_dest, huge_src, 2000, 0))
		return 1;

	free(huge_src);
	free(bigg_dest);
	free(huge_dest);

	return 0;
}
