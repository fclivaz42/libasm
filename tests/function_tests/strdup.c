#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <strings.h>

char	*ft_strdup(const char *s);

int strdup_tests()
{
	char	mt[] = "";
	char	stack[] = "Hello world!";
	char	*heap = malloc(128 + 1);
	char	*huge = malloc(1024 + 1);

	memset(heap, 'A', 128);
	memset(huge, 'a', 1024);
	heap[128] = 0;
	huge[1024] = 0;

	printf("Duplicating...\n");

	char	*dup1 = ft_strdup(mt);
	char	*dup2 = ft_strdup(stack);
	char	*dup3 = ft_strdup(heap);
	char	*dup4 = ft_strdup(huge);

	printf("Duplicated successfully.\n");

	if (memcmp(mt, dup1, 1))
	{
		printf("ERROR: %p and %p do not have the same contents!\n", mt, dup1);
		return 1;
	}
	else
		printf("Success! Contents: %s\n", dup1);

	if (memcmp(stack, dup2, strlen(stack)))
	{
		printf("ERROR: %p and %p do not have the same contents!\n", mt, dup2);
		return 1;
	}
	else
		printf("Success! Contents: %s\n", dup2);

	if (memcmp(heap, dup3, 128 + 1))
	{
		printf("ERROR: %p and %p do not have the same contents!\n", mt, dup3);
		return 1;
	}
	else
		printf("Success! Contents: %s\n", dup3);

	if (memcmp(huge, dup4, 1024 + 1))
	{
		printf("ERROR: %p and %p do not have the same contents!\n", mt, dup4);
		return 1;
	}
	else
		printf("Success! Contents: %s\n", dup4);

	free(heap);
	free(huge);
	free(dup1);
	free(dup2);
	free(dup3);
	free(dup4);

	return 0;
}
