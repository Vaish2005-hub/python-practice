class Library:
    def __init__(self):
        self.books = []
    def add_book(self):
        name = input("Enter book name: ")
        self.books.append({"name": name, "available": True})
        print("Book added successfully")
    def issue_book(self):
        name = input("Enter book name: ")
        for book in self.books:
            if book["name"] == name and book["available"]:
                book["available"] = False
                print("Book issued successfully")
                return
        print("Book not available")
    def return_book(self):
        name = input("Enter book name: ")
        for book in self.books:
            if book["name"] == name and not book["available"]:
                book["available"] = True
                print("Book returned successfully")
                return
        print("Book not found or already available")
    def display_books(self):
        for book in self.books:
            if book["available"]:
                print(book["name"])
library = Library()
while True:
    print("\n1. Add Book")
    print("2. Issue Book")
    print("3. Return Book")
    print("4. Display Books")
    print("5. Exit")
    choice = input("Enter choice: ")
    if choice == "1":
        library.add_book()
    elif choice == "2":
        library.issue_book()
    elif choice == "3":
        library.return_book()
    elif choice == "4":
        library.display_books()
    elif choice == "5":
        break
    else:
        print("Invalid choice")
