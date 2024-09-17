import random

Lst = [random.randint(1, 100) for i in range(20)]
Lst_2 = [random.randint(1, 100) for i in range(20)]

print(set(Lst + Lst_2))
