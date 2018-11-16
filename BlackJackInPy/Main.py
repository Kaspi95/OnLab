from Game import Game


read_main_action = input("Write \"Start\" if u ready to play!")

while read_main_action != "End":
    if read_main_action != "Start":
        break

    new_game = Game()
    new_game.flop()

    read_inside_action = input("Your options: Hit/Stand/Surr")

    while read_inside_action != "Surr":
        points = 0
        if read_inside_action == "Hit":
            points = new_game.hit()
        if points > 21:
            print("You Lost with Bust!")
            break
        if read_inside_action == "Stand" or points == 21:
            new_game.dealers_round()
            new_game.calculate_winner()
            break
        read_inside_action = input("Your options: Hit/Stand/Surr")

    read_main_action = input("Your options Start/End")


