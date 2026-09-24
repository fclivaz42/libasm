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

	printf("\nBeginning tests for strlen:\n");
	if (strlen_tests())
		return 1;

	errno = 0;

	printf("\nBeginning tests for read:\n");
	if (read_tests())
		return 1;

	errno = 0;

	printf("\nBeginning tests for write:\n");
	if (write_tests())
		return 1;

	errno = 0;

	printf("\nBeginning tests for strcpy:\n");
	if (strcpy_tests())
		return 1;

	errno = 0;

	printf("\nBeginning tests for strdup:\n");
	if (strdup_tests())
		return 1;

	errno = 0;

	printf("\nBeginning tests for calloc:\n");
	if (calloc_tests())
		return 1;

	errno = 0;

	printf("\nBeginning tests for strcmp:\n");
	if (strcmp_tests())
		return 1;

	return 0;
}
