import unittest
from Deck import *


class MyTestCase(unittest.TestCase):

    def test_get_points_forBank(self):
        test_deck=Deck("Bank")
        self.assertEqual(test_deck.get_points(),340)

    def test_get_points_forPlayer(self):
        test_deck = Deck("Player")
        self.assertEqual(test_deck.get_points(), 0)

    def test_remove_card(self):
        test_deck1=Deck("Bank")
        test_deck1.remove_card(0)
        self.assertEqual(test_deck1.my_deck[0], [2, 3])

    def test_get_new_card(self):
        test_deck1=Deck("Dealer")
        test_deck1.get_new_card(0)
        self.assertEqual(test_deck1.my_deck[0], [2, 1])


if __name__ == '__main__':
    unittest.main()
