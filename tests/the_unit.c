#define CRED "\033[1;31m"
#define CGRN "\033[1;32m"
#define CYEL "\033[1;33m"
#define RSET "\033[0m"
#include <limits.h>
#include <stddef.h>
#include <sys/types.h>
#include "function_tests/strlen.c"
#include "function_tests/read.c"
#include "function_tests/write.c"
#include "function_tests/strcpy.c"
#include "function_tests/strdup.c"
#include "function_tests/calloc.c"
#include "function_tests/strcmp.c"

int	main(void)
{
	printf("ASSEMBLY BLYAAAT!\n");

	printf("\n----- %sTESTING%s ft_read()...\n", CYEL, RSET);
	if (read_tests())
	{
		printf("\n----- %sERROR%s: Failed tests for ft_read()!\n", CRED, RSET);
		return 1;
	}
	printf("\n----- %sPASSED%s tests for ft_read()!\n", CGRN, RSET);

	errno = 0;

	printf("\n----- %sTESTING%s ft_write()...\n", CYEL, RSET);
	if (write_tests())
	{
		printf("\n----- %sERROR%s: Failed tests for write!\n", CRED, RSET);
		return 1;
	}
	printf("\n----- %sPASSED%s tests for write!\n", CGRN, RSET);

	errno = 0;

	printf("\n----- %sTESTING%s ft_strlen()...\n", CYEL, RSET);
	if (strlen_tests())
	{
		printf("\n----- %sERROR%s: Failed tests for ft_strlen!\n", CRED, RSET);
		return 1;
	}
	printf("\n----- %sPASSED%s tests for ft_strlen!\n", CGRN, RSET);

	errno = 0;

	printf("\n----- %sTESTING%s ft_strcpy()...\n", CYEL, RSET);
	if (strcpy_tests())
	{
		printf("\n----- %sERROR%s: Failed tests for ft_strcpy!\n", CRED, RSET);
		return 1;
	}
	printf("\n----- %sPASSED%s tests for ft_strcpy!\n", CGRN, RSET);

	errno = 0;

	printf("\n----- %sTESTING%s ft_strcmp()...\n", CYEL, RSET);
	if (strcmp_tests())
	{
		printf("\n----- %sERROR%s: Failed tests for ft_strcmp!\n", CRED, RSET);
		return 1;
	}
	printf("\n----- %sPASSED%s tests for ft_strcmp!\n", CGRN, RSET);

	errno = 0;

	printf("\n----- %sTESTING%s ft_strdup()...\n", CYEL, RSET);
	if (strdup_tests())
	{
		printf("\n----- %sERROR%s: Failed tests for ft_strdup!\n", CRED, RSET);
		return 1;
	}
	printf("\n----- %sPASSED%s tests for ft_strdup!\n", CGRN, RSET);

	errno = 0;

	printf("\n----- %sTESTING%s ft_calloc()...\n", CYEL, RSET);
	if (calloc_tests())
	{
		printf("\n----- %sERROR%s: Failed tests for ft_calloc()!\n", CRED, RSET);
		return 1;
	}
	printf("\n----- %sPASSED%s tests for ft_calloc()!\n", CGRN, RSET);

	return 0;
}
