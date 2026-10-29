def calculate_bmi(weight_kg, height_m):
    bmi = weight_kg / (height_m ** 2)
    bmi = round(bmi, 2)
    if bmi < 18.5:
        category = "Underweight"
    elif bmi < 25:
        category = "Normal weight"
    elif bmi < 30:
        category = "Overweight"
    else:
        category = "Obese"

    return {'bmi': bmi, 'category': category}
print(calculate_bmi(70, 1.75))
print(calculate_bmi(90, 1.75))
