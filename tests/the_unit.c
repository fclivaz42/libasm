#define CRED "\033[1;31m"
#define CGRN "\033[1;32m"
#define CYEL "\033[1;33m"
#define RSET "\033[0m"
#include "function_tests/common/includes.h"

static int printeroo(const char* name, int (*test)(void))
{
	errno = 0;
	printf("\n----- %sTESTING%s %s()...\n", CYEL, RSET, name);
	if (test())
	{
		printf("\n----- %sERROR%s: Failed tests for %s()!\n", CRED, RSET, name);
		return 1;
	}
	printf("\n----- %sPASSED%s tests for %s()!\n", CGRN, RSET, name);
	return 0;
}

int	main(void)
{
	printf("ASSEMBLY BLYAAAT!\n");

	if (printeroo("ft_read", read_tests))
		return 1;

	if (printeroo("ft_write", write_tests))
		return 1;

	if (printeroo("ft_strlen", strlen_tests))
		return 1;

	if (printeroo("ft_strcpy", strcpy_tests))
		return 1;

	if (printeroo("ft_strcmp", strcmp_tests))
		return 1;

	if (printeroo("ft_strdup", strdup_tests))
		return 1;

	if (printeroo("ft_calloc", calloc_tests))
		return 1;

	printf("\n%sALL PASSED!%s\n", CGRN, CYEL);
	return 0;
}
