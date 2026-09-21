#include <stdio.h>
#include <string.h>
#include <stdlib.h>

size_t	ft_strlen(const char *str);

static int	strlen_three(const char* str)
{
	size_t	len = 0, cmplen = 0;
	
	len = strlen(str);
	cmplen = ft_strlen(str);

	if (len != cmplen)
	{
		printf("ERROR! lens are not the same: %zd, %zd\n", len, cmplen);
		return 1;
	}
	else
	{
		printf("strlen:\t\t%zu\n", len);
		printf("ft_strlen:\t%zu\n", cmplen);
	}

	return 0;
}

int	strlen_tests()
{
	size_t	size = 2ULL * 1024 * 1024 * 1024;
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
	if (strlen_three(mt))
		return 1;

	printf("----\nHUGE string:\n----\n");
	if (strlen_three(huge))
		return 1;

	printf("----\nStack, normal string:\n----\n");
	if (strlen_three(str))
		return 1;

	printf("----\nHeap, normal string:\n----\n");
	if (strlen_three(heap))
		return 1;
	
	free(huge);

	return 0;
}
