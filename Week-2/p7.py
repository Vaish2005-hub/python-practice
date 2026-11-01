students = {
    "Anil": {"marks": 89, "grade": "A"},
    "Ravi": {"marks": 76, "grade": "B"},
    "Priya": {"marks": 95, "grade": "A+"},
    "Sneha": {"marks": 82, "grade": "A"},
    "Kiran": {"marks": 68, "grade": "C"}
}
print("Student Details:")
for name, details in students.items():
    print("Name:", name)
    print("Marks:", details["marks"])
    print("Grade:", details["grade"])
    print()
highest_student = ""
highest_marks = 0
for name, details in students.items():
    if details["marks"] > highest_marks:
        highest_marks = details["marks"]
        highest_student = name
print("Student with Highest Marks:")
print("Name:", highest_student)
print("Marks:", highest_marks)
