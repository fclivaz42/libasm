#include "../common/includes.h"

static inline t_list	*gemerate_list(void *param1, void *param2, void *param3)
{

	t_list	*list = calloc(1, sizeof(t_list));
	t_list	*list2 = calloc(1, sizeof(t_list));
	t_list	*list3 = calloc(1, sizeof(t_list));

	list->data = param1;
	list->next = list2;
	list2->data = param2;
	list2->next = list3;
	list3->data = param3;

	return list;
}

static inline t_list	*generate_test(void *param1, void *param2, void *param3)
{
	t_list	*lst = NULL;
	ft_list_push_front(&lst, param3);
	ft_list_push_front(&lst, param2);
	ft_list_push_front(&lst, param1);
	return lst;
}

int list_push_front_tests()
{
	static char	*stc = "static string omg";
	char		*mlc = strdup(stc);
	int			*nbr = malloc(sizeof(int)), *cnbr = malloc(sizeof(int));
	double		*flt = malloc(sizeof(double)), *cflt = malloc(sizeof(double));

	*nbr = 1337;
	*flt = 1337.69696969;
	*cnbr = 1337;
	*cflt = 1337.69696969;

	t_list	*lst_check = gemerate_list(stc, nbr, flt);
	t_list	*lst_cmp = generate_test(mlc, cnbr, cflt);

	t_list	*check = lst_check;
	t_list	*cmp = lst_cmp;

	if (strcmp(check->data, cmp->data))
	{
		printf("Strings somehow not be the same. %p - %p; %s - %s\n", check->data, cmp->data, (char *)check->data, (char *)cmp->data);
		return 1;
	}
	else
		printf("Strings match: %p - %p; %s - %s\n", check->data, cmp->data, (char *)check->data, (char *)cmp->data);

	check = check->next;
	cmp = cmp->next;

	if (*(int *)check->data != *(int *)cmp->data)
	{
		printf("ints somehow not be the same. %p - %p; %d - %d\n", check->data, cmp->data, *(int *)check->data, *(int *)cmp->data);
		return 1;
	}
	else
		printf("ints match: %p - %p; %d - %d\n", check->data, cmp->data, *(int *)check->data, *(int *)cmp->data);

	check = check->next;
	cmp = cmp->next;

	if (*(double *)check->data != *(double *)cmp->data)
	{
		printf("doubles somehow not be the same. %p - %p; %f - %f\n", check->data, cmp->data, *(double *)check->data, *(double *)cmp->data);
		return 1;
	}
	else
		printf("doubles match: %p - %p; %f - %f\n", check->data, cmp->data, *(double *)check->data, *(double *)cmp->data);

	free_list(lst_check->next);
	free_list(lst_cmp->next);
	free(lst_check);
	free(lst_cmp);
	free(mlc);

	return 0;
}
