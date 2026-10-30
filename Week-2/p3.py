class Vehicle:
    def start(self):
        print("Vehicle Started")
    def stop(self):
        print("Vehicle Stopped")
class Car(Vehicle):
    def drive(self):
        print("Car Driving")
car = Car()
car.start()
car.drive()
car.stop()
