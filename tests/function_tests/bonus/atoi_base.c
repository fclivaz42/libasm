#include "../common/includes.h"
#define ACCEPTED "accepted"
#define REJECTED "rejected"

typedef enum {
	REJECT = 0,
	ACCEPT = 1
}	rejac;

/*	WARN:	Base rejects has been commented out since i tested if it worked
			on whether or not atoi_base was returning 0 or more during testing.
			Since now atoi_base actually converts, there is a possibility
			that the conversion returns zero, which would be considered a failure.
			therefore this test has been removed.

static inline int	base_rejects(const char *base, const rejac opt)
{
	static char	*str = "0123456789abcdefhijklmnopqrstuwxyz";
	static char	*msg[]	= {"rejected", "accepted"};

	int ret = ft_atoi_base(str, base);

	if (ret > 0)
	{
		printf("Error! ft_atoi_base %s base %s: %d\n", msg[!opt], base, ret);
		return 1;
	}
	else
		printf("ft_atoi_base %s base %s: %d\n", msg[opt], base, ret);

	return 0;
}
*/

static inline int	check_base10(const char *faah)
{
	static char	*base = "0123456789";

	const int	nbr = atoi(faah);
	const int	tst = ft_atoi_base(faah, base);

	if (nbr != tst)
	{
		printf("Error! Numbers differ: %d, %d\n", nbr, tst);
		return 1;
	}
	else
		printf("Numbers match: %d, %d\n", nbr, tst);

	return 0;
}

static inline int	check_against_atoi()
{
	const char	*tests[] = {
		"9219371",
		"			  -16",
		"  \n \t\t\f   16",
		"-----128",
		"+128", "-128", "-+128", "+-128",
		"128			 a",
		"128aaaaaaaaaaaaaa",
		"2147483647",
		"2147483648",
		"-2147483648",
		"-2147483647",
		"0",
		NULL
	};
	for (int i = 0; tests[i] != NULL; i++)
		if (check_base10(tests[i]) == 1)
			return 1;

	return 0;
}

static inline int	launch_atoi_test(const char *test, const char *base, const int result)
{
	int	tst = ft_atoi_base(test, base);

	if (tst != result)
	{
		printf("Error! Numbers differ: %d, %d\n", result, tst);
		return 1;
	}
	else
		printf("Numbers match: %d, %d\n", result, tst);

	return 0;
}

static inline int	check_base_2()
{
	const char	*base = "01";
	const char *tests[] = {
		"101",
		"10000",
		"100101110101101",
		"1101100111001",
		"-1101001101111",
		NULL,
	};
	const int results[] = {
		5, 16, 19373, 6969, -6767
	};

	for (int i = 0; tests[i] != NULL; i++)
		if (launch_atoi_test(tests[i], base, results[i]))
			return 1;

	return 0;
}

static inline int	check_base_hex()
{
	const char	*base = "0123456789ABCDEF";
	const char *tests[] = {
		"DEB33F",
		"B4BE",
		"B0B0",
		"-F00D1E",
		"-379",
		NULL,
	};
	const int results[] = {
		14594879, 46270, 45232, -15731998, -889
	};

	for (int i = 0; tests[i] != NULL; i++)
		if (launch_atoi_test(tests[i], base, results[i]))
			return 1;

	return 0;
}

static inline int	check_base_oct()
{
	const char	*base = "01234567";
	const char *tests[] = {
		"01615427",
		"2652571",
		"1122334455",
		"-6666666666",
		"-371",
		NULL,
	};
	const int results[] = {
		465687, 742777, 155826477, -920350134, -249
	};

	for (int i = 0; tests[i] != NULL; i++)
		if (launch_atoi_test(tests[i], base, results[i]))
			return 1;

	return 0;
}

static inline int	check_base_deltarune()
{
	const char	*baserune = "D3LTARUNE";
	const char *testsrune[] = {
		"3UTEDLRTN",
		"TRTRUTNARL",
		"RRRAT3L33",
		"-RANENNTUN3",
		"-TNE",
		NULL,
	};
	const int results[] = {
		73813147, 1394880635, 242062435, -2147483647, -314
	};

	for (int i = 0; testsrune[i] != NULL; i++)
		if (launch_atoi_test(testsrune[i], baserune, results[i]))
			return 1;

	return 0;
}

int	atoi_base_tests()
{
	/*	WARN: See above!

	char	*wrong_bases[] = {"", "1", "123\x7F",
		"123 ", " 123",
		"123\n", "\n123",
		"12-3", "+123",
		"12345678901", "1a23456a7890", "1bb234567890",
		NULL };
	char	*good_bases[] = {"12", "01",
		"0123456789", "0123456789abcdef", "01234567",
		"poneyvif", "helotiam", "ahoypel",
		"fclivaz", "mlapouge", "ruidejs", "d3ltarune",
		NULL
	};

	for (int i = 0; wrong_bases[i] != NULL; i++)
		if (base_rejects(wrong_bases[i], REJECT))
			return 1;

	for (int i = 0; good_bases[i] != NULL; i++)
		if (base_rejects(good_bases[i], ACCEPT))
			return 1;
	*/

	printf("\nChecking results versus good ol' atoi...\n");

	if (check_against_atoi())
		return 1;

	printf("\nChecking binary results...\n");

	if (check_base_2())
		return 1;

	printf("\nChecking hexadecimal results...\n");

	if (check_base_hex())
		return 1;

	printf("\nChecking octal results...\n");

	if (check_base_oct())
		return 1;

	printf("\nDELTARUNE TOMORROW????\n");
	if (check_base_deltarune())
		return 1;

	return 0;
}
