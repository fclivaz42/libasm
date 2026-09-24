#include <stdio.h>
#include <limits.h>
#include <string.h>
#include <stdlib.h>
#include <strings.h>

int		ft_strcmp(const char *s1, const char *s2);

static int	cmpdiff(const char *s1, const char *s2)
{
	int res = strcmp(s1, s2);
	int rescmp = ft_strcmp(s1, s2);

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

	printf("Checking difference between '%s' and '%s'\n", str1, strsame);
	if (cmpdiff(str1, strsame))
		return 1;

	printf("Checking difference between '%s' and '%s'\n", "ABC", "AB");
	if (cmpdiff("ABC", "AB"))
		return 1;

	printf("Checking difference between '%s' and '%s'\n", "ABA", "ABZ");
	if (cmpdiff("ABA", "ABZ"))
		return 1;

	printf("Checking difference between '%s' and '%s'\n", str1, str2);
	if (cmpdiff(str1, str2))
		return 1;

	printf("Checking difference between '%s' and '%s'\n", str1, str2big);
	if (cmpdiff(str1, str2big))
		return 1;

	printf("Checking difference between '%s' and '%s'\n", str3, str4);
	if (cmpdiff(str3, str4))
		return 1;

	printf("Checking difference between '%s' and '%s'\n", str1, str4);
	if (cmpdiff(str1, str4))
		return 1;

	printf("Checking difference between '%s' and '%s'\n", str3, str1);
	if (cmpdiff(str3, str1))
		return 1;

	printf("Checking difference between '%s' and '%s'\n", strsame, mt);
	if (cmpdiff(strsame, mt))
		return 1;

	printf("Checking difference between '%s' and '%s'\n", mt, str1);
	if (cmpdiff(mt, str1))
		return 1;

	free(strsame);
	free(str3);
	return 0;
}
