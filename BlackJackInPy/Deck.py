class Deck:

    def __init__(self, deck_type):
        self.my_deck = []
        if deck_type == "Bank":
            for index in range(9):
                self.my_deck.append([index + 2, 4])
            # "Jack"
            self.my_deck.append([10, 4])
            # "Queen"
            self.my_deck.append([10, 4])
            # "King"
            self.my_deck.append([10, 4])
            # "Ace"
            self.my_deck.append([0, 4])
        elif deck_type == "Dealer" or deck_type == "Player":
            for index in range(9):
                self.my_deck.append([index + 2, 0])
            # "Jack"
            self.my_deck.append([10, 0])
            # "Queen"
            self.my_deck.append([10, 0])
            # "King"
            self.my_deck.append([10, 0])
            # "Ace"
            self.my_deck.append([0, 0])
        else:
            raise RuntimeError("Just Bank/Player/Dealer!")

    def get_points(self):
        points = 0
        for index in range(12):
            points += self.my_deck[index][0] * self.my_deck[index][1]
        # Ace
        if (points+self.my_deck[12][1]*11) <= 21:
            points += 11 * self.my_deck[12][1]
        else:
            points += 1 * self.my_deck[12][1]
        return points

    def get_new_card(self, position):
        self.my_deck[position][1] += 1

    def remove_card(self, position):
        if self.my_deck[position][1] > 0:
            self.my_deck[position][1] -= 1
        else:
            raise RuntimeError("Out from that card")

    def my_cards(self):
        for index in range(9):
            if self.my_deck[index][1] > 0:
                print(str(self.my_deck[index][0]) + " X " + str(self.my_deck[index][1]))
        if self.my_deck[9][1] > 0:
            print("Jack X " + str(self.my_deck[9][1]))
        if self.my_deck[10][1] > 0:
            print("Queen X " + str(self.my_deck[10][1]))
        if self.my_deck[11][1] > 0:
            print("King X " + str(self.my_deck[11][1]))
        if self.my_deck[12][1] > 0:
            print("Ace X " + str(self.my_deck[12][1]))





'''
#ez nem mukodik
class PlayerDeck(Deck):

    def __init__(self):
        Deck.__init__(self)
        for index in range(9):
            self.my_deck.append([index + 2, 0])
        # "Jack"
        self.my_deck.append([10, 0])
        # "Queen"
        self.my_deck.append([10, 0])
        # "King"
        self.my_deck.append([10, 0])
        # "Ace"
        self.my_deck.append([0, 0])


class BankDeck(Deck):

    def __init__(self):
        Deck.__init__(self)
        for index in range(9):
            self.my_deck.append([index + 2, 4])
        # "Jack"
        self.my_deck.append([10, 4])
        # "Queen"
        self.my_deck.append([10, 4])
        # "King"
        self.my_deck.append([10, 4])
        # "Ace"
        self.my_deck.append([0, 4])

'''
