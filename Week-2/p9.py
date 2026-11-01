numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
squares = [x * x for x in numbers]
even_numbers = list(filter(lambda x: x % 2 == 0, numbers))
print("Squares:", squares)
print("Even Numbers:", even_numbers)
