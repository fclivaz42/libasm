#include "../common/includes.h"

static void	c_list_sort(t_list **begin_list, int (*cmp)(void *, void *))
{
	t_list	*tmp;
	void	*content;
	int		swapped = 1;

	while (swapped)
	{
		swapped = 0;
		tmp = *begin_list;
		while (tmp->next != NULL)
		{
			if (cmp(tmp->data, tmp->next->data) > 0)
			{
				content = tmp->data;
				tmp->data = tmp->next->data;
				tmp->next->data = content;
				swapped = 1;
			}
			tmp = tmp->next;
		}
	}

	return;
}

static int diff(void *d1, void *d2)
{
	return *(int *)d1 - *(int *)d2;
}

static inline int cmp_sorted_lists(t_list *lst, t_list *tst)
{
	t_list	*crt = lst;
	t_list	*tst_crt = tst;

	while (crt != NULL && tst_crt != NULL)
	{
		if (*(int *)crt->data == *(int *)tst_crt->data)
			printf("%d and %d matched!\n", *(int *)crt->data, *(int *)tst_crt->data);
		else
		{
			printf("%d and %d DID NOT match!\n", *(int *)crt->data, *(int *)tst_crt->data);
			return 1;
		}

		crt = crt->next;
		tst_crt = tst_crt->next;
	}

	if (crt || tst_crt)
	{
		printf("Sizes of lists vary!\n");
		return 1;
	}

	return 0;
}

void	print_list(t_list *lst)
{
	printf("==== PRINT_LIST ====\n");
	for (t_list *tmp = lst; tmp != NULL; tmp = tmp->next)
		printf("%d!\n", *(int *)tmp->data);
}

int list_sort_tests()
{
	int		ret_code = 0;
	struct timeval f;
	gettimeofday(&f, NULL);
	t_list	*lst = generate_list(f.tv_usec);
	t_list	*tst = generate_list(f.tv_usec);

	c_list_sort(&lst, diff);
	ft_list_sort(&tst, diff);

	if (cmp_sorted_lists(lst, tst))
	{
		ret_code = 1;
		goto free_exit;
	}

	free_exit:

	free_list(lst);
	free_list(tst);

	return ret_code;
}
