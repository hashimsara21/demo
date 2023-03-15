# CS 303E Quiz 3
# do NOT rename this file, otherwise Gradescope will not accept your submission
# also, do NOT change any of the function names or parameters


# Problem 1: Slithering String
def slitheringString(s):
    # replace pass with your solution to problem 1
    snake_msg = s.replace(' ','_')
    snake_msg = snake_msg.replace('!','.')
    snake_msg = snake_msg.replace('?','.')
    return snake_msg

# Problem 2: Locked Phone Class
class LockedPhone:
    # REMEMBER TO MAKE YOUR DATA MEMBERS PRIVATE
    def __init__(self, brand, password):
        self.__brand = brand
        self.__password = password
        self.__lock = True

    def unlock(self, password):
        if password == self.__password:
            self.__lock = False
            return True 
        else:
            return False

    def changePassword(self, newPassword):
        if not self.__lock:
            self.__pasword = newPassword

    def lock(self):
        self.__lock = True

    def __str__(self):
        if self.__lock:
            return f'This {self.__brand} phone is currently locked.'
        else:
            return f'This {self.__brand} phone is currently not locked.'


if __name__ == '__main__':
    # uncomment the following lines to run the given test cases
    # note that the output will look slightly different
    # due to how the expected output is formatted

    # print(slitheringString("I am SO excited for the TWICE concert in May!!"))
    # print(slitheringString("Me too! Who's your bias?"))
    # print(slitheringString("My bias is Tzuyu! What about you?"))

    lp = LockedPhone('Samsung', 'v3rys3cr3tpa55w0rd')
    print(lp.unlock('v3rys3cr3tpa55w0rd'))

    lp = LockedPhone('Apple', 'notsosecretpassword')
    lp.lock()
    print(str(lp))

    lp = LockedPhone('Nokia', 'psswrd')
    lp.changePassword('nwpsswrd')
    lp.lock()
    print(lp.unlock('nwpsswrd'))
    print(lp.unlock('psswrd'))
    print(str(lp))

    # DO NOT DELETE THIS PASS
    pass
    # DON'T DO IT
