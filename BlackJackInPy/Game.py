from Deck import *
from random import randint


class Game:

    def __init__(self):
        self.bank = Deck("Bank")
        self.dealer = Deck("Dealer")
        self.player1 = Deck("Player")

    def position(self):
        print("Player's points and cards: " + str(self.player1.get_points()))
        self.player1.my_cards()
        print("Dealer's points and cards: " + str(self.dealer.get_points()))
        self.dealer.my_cards()

    def flop(self):
        for index in range(4):
            temp = self.get_rand()
            self.bank.remove_card(temp)
            if index < 2:
                self.player1.get_new_card(temp)
            else:
                self.dealer.get_new_card(temp)
        self.position()

    def hit(self):
        temp = self.get_rand()
        try:
            self.bank.remove_card(temp)
        except RuntimeError:    #igen kicsi a valoszinusege, hogy elfogyjon egy lap, es meg ugyan azt is dobja 2x
            temp = self.get_rand()
            self.bank.remove_card(temp)
        self.player1.get_new_card(temp)
        self.position()
        return self.player1.get_points()

    def calculate_winner(self):
        if self.dealer.get_points() <= 21 and self.dealer.get_points() >= self.player1.get_points():
            print("The Bank won!\n")
        else:
            print("You won!\n")

    def dealers_round(self):
        while self.dealer.get_points() < 17:
            temp = self.get_rand()
            try:
                self.bank.remove_card(temp)
            except RuntimeError:
                temp = self.get_rand()
                self.bank.remove_card(temp)
            self.dealer.get_new_card(temp)
        self.position()

    def get_rand(self):
        return randint(0, 12)

