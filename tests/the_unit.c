#include <limits.h>
#include <stddef.h>
#include <sys/types.h>
#include "function_tests/strlen.c"
#include "function_tests/read.c"
#include "function_tests/write.c"

char	*ft_strcpy(char *restrict dst, const char *restrict src);
int		ft_strcmp(const char *s1, const char *s2);
char	*ft_strdup(const char *s);
void	*ft_calloc(size_t n, size_t size);

int	main(void)
{
	printf("ASSEMBLY BLYAAAT!\n");

	printf("\nBeginning tests for strlen:\n");
	if (strlen_tests())
		return 1;

	printf("\nBeginning tests for read:\n");
	if (read_tests())
		return 1;

	printf("\nBeginning tests for write:\n");
	if (write_tests())
		return 1;
}
