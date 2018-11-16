#pragma once
#include "Deck.h"

class Game
{
	Deck bank = Deck("Bank");
	Deck dealer = Deck("Dealer");
	Deck player1 = Deck("Player");

public:

	void position();
	void flop();
	int hit();
	void calculateWinner();
	void dealersRound();
	int getRand();




	Game();
	~Game();
};

