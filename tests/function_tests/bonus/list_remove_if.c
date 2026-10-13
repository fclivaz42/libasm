#include "../common/includes.h"


static void	c_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(void *, void *), void (*free_fct)(void *))
{
	t_list			*curr = *begin_list;

	if (curr->next)
		c_list_remove_if(&(curr->next), data_ref, cmp, free_fct);

	if (!cmp(curr->data, data_ref))
	{
		*begin_list = curr->next;
		free_fct(curr->data);
		free(curr);
	}
	else
		*begin_list = curr;

	return;
}

static int mod_2(void *d1, void *d2)
{
	return *(int *)d1 % *(int *)d2;
}

static int not_mod_2(void *d1, void *d2)
{
	return !(*(int *)d1 % *(int *)d2);
}

static inline t_list	*generate_list(void)
{
	t_list	*head = NULL;

	for (int i = 10; i > 0; i--)
	{
		int *data = malloc(1 * sizeof(int));
		*data = i;
		ft_list_push_front(&head, data);
	}

	return head;
}

static inline int loop_de_loop(t_list *lst, t_list *tst)
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

static int	equals(void *d1, void *d2)
{
	return *(int *)d1 == *(int *)d2;
}

int list_remove_if_tests()
{
	int		ret_code = 0;
	t_list	*lst_odd = generate_list();
	t_list	*lst_even = generate_list();
	t_list	*tst_odd = generate_list();
	t_list	*tst_even = generate_list();

	int		data_ref = 2;

	c_list_remove_if(&lst_even, &data_ref, mod_2, free);
	ft_list_remove_if(&tst_even, &data_ref, mod_2, free);

	if (loop_de_loop(lst_even, tst_even))
	{
		ret_code = 1;
		goto free_exit;
	}

	printf("-----------\n");

	c_list_remove_if(&lst_odd, &data_ref, not_mod_2, free);
	ft_list_remove_if(&tst_odd, &data_ref, not_mod_2, free);

	if (loop_de_loop(lst_odd, tst_odd))
	{
		ret_code = 1;
		goto free_exit;
	}


	printf("-----------\n");

	free_exit:

	free_list(lst_odd);
	free_list(lst_even);
	free_list(tst_odd);
	free_list(tst_even);

	return ret_code;
}
