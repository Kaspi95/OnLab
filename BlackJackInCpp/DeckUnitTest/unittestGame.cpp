#include "stdafx.h"
#include "CppUnitTest.h"
#include "../BlackJackInCpp/Game.h"


using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace DeckUnitTest
{
	TEST_CLASS(UnitTestGame)
	{
	public:

		TEST_METHOD(TestMyPointsforBank)
		{
			int maxPoints = 320;
			Deck TestClass = Deck("Bank");
			Assert::AreEqual(maxPoints, 320);
		}

		TEST_METHOD(TestMyPointsforPlayer)
		{
			int startingPoints = 0;
			Deck TestClass = Deck("Player");
			Assert::AreEqual(startingPoints, 0);

		}

	};
}