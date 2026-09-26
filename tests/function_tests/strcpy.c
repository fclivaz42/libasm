#include "common/includes.h"

static int	copies(char* dst, const char* src, size_t dstsize, char fillchar, const char* desc)
{
	char	*ret, *cmpret;
	char	*dstcmp = malloc(dstsize + 1);
	size_t	bytes;

	memcpy(dstcmp, dst, dstsize + 1);

	printf("----\n%s copy:\n----\n", desc);
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

	if (copies(stack_dest, mt, 50, 'A', "Empty string"))
		return 1;

	if (copies(stack_dest, small_source, 50, 'A', "Stack-based"))
		return 1;

	if (copies(bigg_dest, small_source, 200, 0, "Stack-to-Heap"))
		return 1;

	if (copies(huge_dest, huge_src, 2000, 0, "Heap-to-Heap"))
		return 1;

	free(huge_src);
	free(bigg_dest);
	free(huge_dest);

	return 0;
}
