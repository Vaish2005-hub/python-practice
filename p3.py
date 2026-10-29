def calculate_statistics(numbers):
    if len(numbers) == 0:
        return {
            'mean': 0,
            'max': None,
            'min': None,
            'count': 0
        }
    else:
        return {
            'mean': sum(numbers) / len(numbers),
            'max': max(numbers),
            'min': min(numbers),
            'count': len(numbers)
        }
print(calculate_statistics([10, 20, 30, 40, 50]))
print(calculate_statistics([]))
