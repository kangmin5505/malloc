#ifndef FT_MALLOC_H

#include <stddef.h>		/* for size_t */

#define ft_free			free
#define ft_malloc 		malloc
#define ft_realloc		realloc

void* ft_free(void*);
void* ft_malloc(size_t);
void* ft_realloc(void*, size_t);

#endif /* FT_MALLOC_H */
