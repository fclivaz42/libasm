#include "common/includes.h"

static int	cmpdiff(const char *s1, const char *s2)
{
	int res = strcmp(s1, s2);
	int rescmp = ft_strcmp(s1, s2);

	printf("Checking difference between '%s' and '%s'\n", s1, s2);
	if (res != rescmp)
	{
		printf("Error: result is not the same! %d, %d\n", res, rescmp);
		return 1;
	}
	printf("Passed, Same result: %d, %d\n", res, rescmp);
	return 0;
}

int	strcmp_tests()
{
	char	mt[] = "";
	char	str1[] = "This is a string!";
	char	*strsame = strdup("This is a string!");
	char	str2[] = "This is a string.";
	char	str2big[] = "This could be a string?";
	char	*str3 = strdup("3");
	char	str4[] = "4";

	if (cmpdiff(str1, strsame))
		return 1;

	if (cmpdiff("ABC", "AB"))
		return 1;

	if (cmpdiff("ABA", "ABZ"))
		return 1;

	if (cmpdiff(str1, str2))
		return 1;

	if (cmpdiff(str1, str2big))
		return 1;

	if (cmpdiff(str3, str4))
		return 1;

	if (cmpdiff(str1, str4))
		return 1;

	if (cmpdiff(str3, str1))
		return 1;

	if (cmpdiff(strsame, mt))
		return 1;

	if (cmpdiff(mt, str1))
		return 1;

	if (cmpdiff(mt, mt))
		return 1;

	free(strsame);
	free(str3);
	return 0;
}
