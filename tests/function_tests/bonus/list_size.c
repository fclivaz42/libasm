#include "../common/includes.h"

static t_list	*generate_test(int amount)
{
	t_list	*lst = NULL;
	for (int i = 0; i < amount; i++)
		ft_list_push_front(&lst, NULL);
	return lst;
}

static inline int	the_print(int amount, int expected)
{
	if (amount != expected)
	{
		printf("FAILED: returned size: %d, expected: %d\n", amount, expected);
		return 1;
	}
	else
		printf("Success: Size is indeed %d\n", amount);
	return 0;
}

int	list_size_tests()
{
	int		tw = 12;
	int		fr = 4;
	int		bill = 10000;
	t_list	*twelve = generate_test(tw);
	t_list	*four = generate_test(fr);
	t_list	*billion = generate_test(bill);

	if (the_print(ft_list_size(twelve), tw))
		return 1;

	if (the_print(ft_list_size(four), fr))
		return 1;

	if (the_print(ft_list_size(billion), bill))
		return 1;

	if (the_print(ft_list_size(NULL), 0))
		return 1;

	return 0;
}
