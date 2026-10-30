class Employee:
    def __init__(self, employee_id, employee_name, salary):
        self.employee_id = employee_id
        self.employee_name = employee_name
        self.salary = salary
    def display_details(self):
        print("Employee ID:", self.employee_id)
        print("Employee Name:", self.employee_name)
        print("Salary:", self.salary)
        print()
employee1 = Employee(101, "Anil", 25000)
employee2 = Employee(102, "Ravi", 30000)
employee3 = Employee(103, "Priya", 35000)
employee1.display_details()
employee2.display_details()
employee3.display_details()
