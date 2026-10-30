class Animal:
    def sound(self):
        print("Animal makes a sound")
class Dog(Animal):
    def sound(self):
        print("Dog says Bark")
class Cat(Animal):
    def sound(self):
        print("Cat says Meow")
dog = Dog()
cat = Cat()
dog.sound()
cat.sound()
