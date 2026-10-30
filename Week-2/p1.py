class Student:
    def __init__(self, name, roll_number, marks):
        self.name = name
        self.roll_number = roll_number
        self.marks = marks
    def display_details(self):
        print("Name:", self.name)
        print("Roll Number:", self.roll_number)
        print("Marks:", self.marks)
        print()
student1 = Student("Anil", 101, 89)
student2 = Student("Vaish", 102, 95)
student1.display_details()
student2.display_details()
