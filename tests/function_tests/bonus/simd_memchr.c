#include "../common/includes.h"

int chr_test(const char *str, int find, size_t size)
{
	void	*res;
	void	*tst;

	res = (void *)memchr(str, find, size);
	tst = (void *)ft_simd_memchr(str, find, size);

	printf("Attempting to find %c ...", find);

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
	char	find_in_aligned[32];
	char	no_find_in_aligned[32];
	char	find_in_tail[35];
	char	no_find_in_tail[35];
	char	*find_in_HUGE = malloc(35000);
	char	*no_find_in_HUGE = malloc(35000);

	memset_explicit(find_in_aligned, 'a', 32);
	memset_explicit(no_find_in_aligned, 'a', 32);
	memset_explicit(find_in_tail, 'a', 35);
	memset_explicit(no_find_in_tail, 'a', 35);
	memset_explicit(find_in_HUGE, 'a', 35000);
	memset_explicit(no_find_in_HUGE, 'a', 35000);

	find_in_aligned[31] = 'b';
	find_in_tail[33] = 'b';
	find_in_HUGE[26791] = 'b';

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

	if (chr_test(fail, '\'', 0))
		return 1;

	if (chr_test(fail, '\'', -1))
		return 1;

	if (chr_test(find_in_aligned, 'b', 32))
		return 1;

	if (chr_test(no_find_in_aligned, 'b', 32))
		return 1;

	if (chr_test(find_in_tail, 'b', 35))
		return 1;

	if (chr_test(no_find_in_tail, 'b', 35))
		return 1;

	if (chr_test(find_in_HUGE, 'b', 35000))
		return 1;

	if (chr_test(no_find_in_HUGE, 'b', 35000))
		return 1;

	free(find_in_HUGE);
	free(no_find_in_HUGE);

	return 0;
}
