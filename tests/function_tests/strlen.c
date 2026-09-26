#include "common/includes.h"

static int	strlen_three(const char* str, const char* desc)
{
	size_t	len = 0, cmplen = 0;
	
	printf("----\n%s string:\n----\n", desc);
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
	char	*heap = malloc(strlen(str) + 1);

	strcpy(heap, str);
	if (!huge)
		return 1;
	memset(huge, 'a', size);
	huge[size - 1] = 0;

	if (strlen_three(mt, "Empty"))
		return 1;

	if (strlen_three(huge, "Huge"))
		return 1;

	if (strlen_three(str, "Stack, normal"))
		return 1;

	if (strlen_three(heap, "Heap, normal"))
		return 1;

	{
		size_t	len = 0, cmplen = 0;

		printf("----\nStatic string:\n----\n");
		len = strlen("");
		cmplen = ft_strlen("");

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
	}
	
	free(huge);
	free(heap);

	return 0;
}
