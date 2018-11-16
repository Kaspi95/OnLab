#pragma once
#include <vector>
#include <string>
#include <iostream>
#include <exception>
using namespace std;

class Deck
{public:
	vector<pair<int, int>> myDeck; //ahol a 0. helyen a 2-es, a 12. pedig az ász van
								   //a belso pair a (mennyiseg,ertek)



	int getPoints();
	void getNewCard(int);
	void removeCard(int);
	void myCards();

	Deck(string);
	~Deck();
};

