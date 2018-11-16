#include "stdafx.h"
#include "Deck.h"


Deck::Deck(string dackType)		//kiszervezheto kulon osztalyba, a haszon elhanyagolhato
{
	if (dackType == "Bank")
	{
		for (int i = 0; i<9; ++i) {		//2-10
			myDeck.push_back(make_pair(4, i + 2));
			//mennyiseg es ertek			
		}
		//Jack
		myDeck.push_back(make_pair(4, 10));

		//Queen
		myDeck.push_back(make_pair(4, 10));

		//King
		myDeck.push_back(make_pair(4, 10));;

		//Ace
		myDeck.push_back(make_pair(4, 0));

	}
	else if (dackType == "Player" || dackType == "Dealer")
	{
		for (int i = 0; i<9; ++i) {		//2-10
			myDeck.push_back(make_pair(0, i + 2));
			//mennyiseg es ertek			
		}
		//Jack
		myDeck.push_back(make_pair(0, 10));

		//Queen
		myDeck.push_back(make_pair(0, 10));

		//King
		myDeck.push_back(make_pair(0, 10));;

		//Ace
		myDeck.push_back(make_pair(0, 0));
	}
	else
		throw std::runtime_error("Only Player ,Dealer or Bank is possible");
}

int Deck::getPoints() {
	int points = 0;
	vector<pair<int, int>>::iterator iter_out;
	int i = 0;
	for (iter_out = myDeck.begin(); i<12; ++iter_out, ++i) {
		points += iter_out->first*iter_out->second;
	}
	//Aszra kulon szabaly van
	if (points + 11 * myDeck.at(12).first <= 21)
		points += 11 * myDeck.at(12).first;
	else
		points += 1 * myDeck.at(12).first;

	return points;
}

void Deck::getNewCard(int num) {
	myDeck.at(num).first++;
}

void Deck::removeCard(int num) {
	if (myDeck.at(num).first != 0)
		myDeck.at(num).first--;
	else
		throw runtime_error("nincs tobb ilyen lap a pakliban");
}

void Deck::myCards() {
	vector<pair<int, int>>::iterator iter_out;
	int i = 0;
	for (iter_out = myDeck.begin(); i<9; ++iter_out, ++i) {
		if (iter_out->first != 0)
			cout << i + 2 << " X " << iter_out->first << endl;
	}
	if (myDeck.at(9).first != 0)
		cout << "Jack" << " X " << myDeck.at(9).first << endl;
	if (myDeck.at(10).first != 0)
		cout << "Queen" << " X " << myDeck.at(10).first << endl;
	if (myDeck.at(11).first != 0)
		cout << "King" << " X " << myDeck.at(11).first << endl;
	if (myDeck.at(12).first != 0)
		cout << "Ace" << " X " << myDeck.at(12).first << endl;
}

Deck::~Deck()
{
}
