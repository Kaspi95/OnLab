#include "stdafx.h"
#include "CppUnitTest.h"
#include "../BlackJackInCpp/Deck.h"


using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace DeckUnitTest
{		
	TEST_CLASS(UnitTestDeck)
	{
	public:
		Deck TestBankClass = Deck("Bank");
		Deck TestPlayerClass = Deck("Player");

		TEST_METHOD(TestGetPointsforBank)
		{
			int maxPoints = 340;
			Assert::AreEqual(maxPoints, TestBankClass.getPoints());
		}

		TEST_METHOD(TestGetPointsforPlayer)
		{
			int startingPoints = 0;			
			Assert::AreEqual(startingPoints, TestPlayerClass.getPoints());		
		}

		TEST_METHOD(TestRemoveCard)
		{
			Deck TestBankClass2 = Deck("Bank");
			TestBankClass.removeCard(3);			
			Assert::AreEqual(TestBankClass.myDeck.at(3).first, TestBankClass2.myDeck.at(3).first-1);
		}

		TEST_METHOD(TestGetNewCard)
		{
			Deck TestBankClass2 = Deck("Bank");			
			TestBankClass.getNewCard(3);
			Assert::AreEqual(TestBankClass.myDeck.at(3).first, TestBankClass2.myDeck.at(3).first+1);
		}

	};
}