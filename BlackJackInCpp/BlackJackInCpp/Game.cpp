#include "stdafx.h"
#include "Game.h"


Game::Game()
{
}

void Game::position() {
	cout << "Player's points and Cards: " << player1.getPoints() << endl;
	player1.myCards();

	cout << "Dealer's points and Cards: " << dealer.getPoints() << endl;
	dealer.myCards();

	//cout << "Bank's points and Cards: " << bank.getPoints() << endl;
	//bank.myCards();
}

int Game::getRand() {
	return ((rand() % 8) + (rand() % 3)*(rand() % 7) + (rand() % 2)) % 13;
}

void Game::flop() {//a klasszikus szabalyok szerint az oszto mindket lapja lathato

	for (int i = 0; i < 4; i++) {
		int temp = getRand();
		try {
			bank.removeCard(temp);
		}
		catch (...) { i--; }	//ez csak tobb jatekos eseten tortenhetne meg
		if (i < 2)
			player1.getNewCard(temp);
		else
			dealer.getNewCard(temp);
	}
	position();
}

int Game::hit() {
	int temp = getRand();
	try {
		bank.removeCard(temp);
	}
	catch (...) {//igen kicsi a valoszinusege, hogy elfogyjon egy lap, aztan ujra ugyan azt dobja 2x
		temp = getRand();
		bank.removeCard(temp);
	}
	player1.getNewCard(temp);
	position();
	return player1.getPoints();
}

void Game::dealersRound() {//az oszto kore;

	while (dealer.getPoints() < 17) {
		int temp = getRand();
		try {
			bank.removeCard(temp);
		}
		catch (...) {
			temp = getRand();
			bank.removeCard(temp);
		}
		dealer.getNewCard(temp);
	}
	position();
}

void Game::calculateWinner() {
	if (dealer.getPoints() <= 21 && dealer.getPoints() >= player1.getPoints())
		cout << "The Bank won" << endl;
	else
		cout << "You won!" << endl;
}

Game::~Game()
{
}
