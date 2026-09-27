#include "../common/includes.h"

int list_push_front_tests()
{
	t_list	*list = calloc(1, sizeof(t_list));
	char	fax[]	= "faxxx\n";
	char	fox[]	= "foxxx\n";

	list->data = fax;

	printf("%zu, %p\n",sizeof(t_list), list);
	printf("%p\n", list->data);
	printf("%p\n", list->next);

	t_list *list2 = ft_list_push_front(&list, fox);

	printf("%p\n", list);
	printf("%p\n", list2);

	printf("%s\n", (char *)list->data);
	printf("%p\n", list2->data);
	printf("%p\n", list2->next);
	return 0;
}
