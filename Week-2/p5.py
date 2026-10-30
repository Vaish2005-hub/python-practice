class Circle:
    def area(self):
        radius = float(input("Enter the radius of circle: "))
        result = 3.14 * radius * radius
        print("Area of Circle:", result)
class Rectangle:
    def area(self):
        length = float(input("Enter the length of rectangle: "))
        breadth = float(input("Enter the breadth of rectangle: "))
        result = length * breadth
        print("Area of Rectangle:", result)
circle = Circle()
rectangle = Rectangle()
circle.area()
rectangle.area()
