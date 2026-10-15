#include "../common/includes.h"

int chr_test(const char *str, int find, size_t size)
{
	void	*res;
	void	*tst;

	res = (void *)memchr(str, find, size);
	tst = (void *)ft_simd_memchr(str, find, size);

	if (res != tst)
	{
		printf("Failed! Pointers differ: %p, %p\n", res, tst);
		return 1;
	}
	else
		printf("Success! Pointers match: %p, %p\n", res, tst);

	return 0;
}

int	simd_memchr_tests()
{
	char	*mt = "";
	char	*str = "This is a string.";
	char	*fail = "You can't find me!";

	if (chr_test(mt, 'A', strlen(mt)))
		return 1;

	if (chr_test(str, 'n', strlen(str)))
		return 1;

	if (chr_test(fail, '.', strlen(fail)))
		return 1;

	if (chr_test(fail, '\'', strlen(fail)))
		return 1;

	if (chr_test(fail, '\'', 7))
		return 1;

	if (chr_test(fail, '\'', 8))
		return 1;

	return 0;
}
