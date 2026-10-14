#include "../common/includes.h"

static inline int base_rejects(const char *base)
{
	static char	*str = "123123123";

	int ret = ft_atoi_base(str, base);

	if (ret > 0)
	{
		printf("Error! ft_atoi_base accepted base %s: %d\n", base, ret);
		return 1;
	}
	else
		printf("ft_atoi_base rejected base %s: %d\n", base, ret);

	return 0;
}

int	atoi_base_tests()
{
	char	*wrong_bases[] = { "", "1",
		"123 ", " 123",
		"123\n", "\n123",
		"12-3", "+123",
		"12345678901", "1a23456a7890", "1bb234567890",
		"12345",
		NULL };

	for (int i = 0; wrong_bases[i] != NULL; i++)
		if (base_rejects(wrong_bases[i]))
			return 1;

	return 0;
}
