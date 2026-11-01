class BankAccount:
    def __init__(self, account_number, account_holder_name, balance):
        self.account_number = account_number
        self.account_holder_name = account_holder_name
        self.__balance = balance

    def deposit(self):
        amount = float(input("Enter amount to deposit: "))

        if amount > 0:
            self.__balance += amount
            print("Amount deposited successfully.")
        else:
            print("Enter a valid amount.")

    def withdraw(self):
        amount = float(input("Enter amount to withdraw: "))

        if amount <= 0:
            print("Enter a valid amount.")
        elif amount > self.__balance:
            print("Insufficient balance.")
        else:
            self.__balance -= amount
            print("Amount withdrawn successfully.")

    def check_balance(self):
        print("Account Number:", self.account_number)
        print("Account Holder:", self.account_holder_name)
        print("Available Balance:", self.__balance)


account = BankAccount(123456, "Vaishnavi", 5000)

while True:
    print("\n----- BANK MENU -----")
    print("1. Deposit")
    print("2. Withdraw")
    print("3. Check Balance")
    print("4. Exit")

    choice = input("Enter your choice: ")

    if choice == "1":
        account.deposit()

    elif choice == "2":
        account.withdraw()

    elif choice == "3":
        account.check_balance()

    elif choice == "4":
        print("Thank you for using our banking system.")
        break

    else:
        print("Invalid choice. Please try again.")
