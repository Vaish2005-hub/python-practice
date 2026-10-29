def convert_case(text, case_type):
    if case_type == "upper":
        return text.upper()
    elif case_type == "lower":
        return text.lower()
    elif case_type == "title":
        return text.title()
    else:
        return "Invalid case_type. Use upper, lower, or title."
print("'hello world', 'upper' ->", repr(convert_case("hello world", "upper")))
print("'HELLO WORLD', 'lower' ->", repr(convert_case("HELLO WORLD", "lower")))
print("'hello world', 'title' ->", repr(convert_case("hello world", "title")))
print("'hello', 'caps' ->", repr(convert_case("hello", "caps")))
