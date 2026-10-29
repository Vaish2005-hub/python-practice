
def assign_grade(score):
    if score < 0 or score > 100:
        return "Invalid Score"
    elif score >= 90:
        return "A"
    elif score >= 80:
        return "B"
    elif score >= 70:
        return "C"
    elif score >= 60:
        return "D"
    else:
        return "F"
print("assign_grade(95) ->", assign_grade(95))
print("assign_grade(85) ->", assign_grade(85))
print("assign_grade(75) ->", assign_grade(75))
print("assign_grade(65) ->", assign_grade(65))
print("assign_grade(55) ->", assign_grade(55))
print("assign_grade(105) ->", assign_grade(105))
