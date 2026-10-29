def is_palindrome(text):
    text = text.replace(" ", "").lower()
    if text == text[::-1]:
        return True
    else:
        return False

print("'level' ->", is_palindrome("level"))
print("'Hello' ->", is_palindrome("Hello"))
print("'racecar' ->", is_palindrome("racecar"))
print("'A man a plan a canal Panama' ->", is_palindrome("A man a plan a canal Panama"))
