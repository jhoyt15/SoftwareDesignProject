clc;
clear;
close all;

playerObj = Player(); %Initialize the player object.
room = RoomChecker(); %Intitialize object to check the room

my_scene = simpleGameEngine('retro_pack.png',16,16,4); %Download the retro_pack file

blank_sprite = 1; %Assigns the sprite value to a variable
sword_sprite = 28*32+3; %Assigns the sprite value to a variable
boots_sprite = 23*32+9; %Assigns the sprite value to a variable
shield_sprite = 26*32+9; %Assigns the sprite value to a variable
potion_sprite = 23*32+27; %Assigns the sprite value to a variable
monster_sprite = 9*32+19; %Assigns the sprite value to a variable
player_sprite = 27; %Assigns the sprite value to a variable
door_sprite = 9*32+11; %Assigns the sprite value to a variable
empty_room_sprite = 17; %Assigns the sprite value to a variable
rooms_display = empty_room_sprite * ones(10,10); %Makes the room display full of empty sprites

gameboard_display = blank_sprite * ones(10,10); %Assigns gameboard_display to empty sprites



drawScene(my_scene,rooms_display) %Draws the blank scene
drawScene(my_scene,rooms_display,gameboard_display)

fprintf("Welcome to Dungeon Dweller! \n")
fprintf("In order to move, use the WASD keys. \n")
fprintf("Picking up power-ups will increases your attributes! \n")
fprintf("Walk to a monster to battle it. Combat is rock-paper-scissors based. \n")
fprintf("Attack beats Defense, Defense beats Speed, and Speed beats Attack. \n")
fprintf("Defeating a monster will give you xp. If you get enough xp you will level up. \n")
fprintf("After 5 floors you will battle the boss! He is challenging so make sure you become as strong as possible!\n")
fprintf("If you defeat the boss, you win the game!\n\n\n")

fprintf("Despite the warning of your relatives, you've built your house next to a dungeon. \n");
fprintf("Now the boss has captured your son, and you must fight to get him back!. \n\n\n");

spriteVector = [sword_sprite,boots_sprite,shield_sprite,potion_sprite,monster_sprite,monster_sprite,monster_sprite,door_sprite]; %creates a sprite vector for easy iteration
for i = 1: 10 %gameboard with blank displays for the new room.
    for j = 1: 10
         gameboard_display(i,j) = blank_sprite;
    end
end
gameboard_display(10,10) = 9*32+11; %Puts the door in the bottom left corner of the room
playerObj.xPos = 1; %Put the player at position 1,1 
playerObj.xPos = 1; %Put the player at position 1,1
for i = 1: length(spriteVector)  %Iterate through sprite vector
     xPos = randi([2,10],1); %Put value in a random x position excluding 1 and 10
     yPos = randi([2,9],1); %Put value in a random y position excluding 1 and 10
     if(spriteVector(i) ~= 9*32+11) %Don't want to add Door to random spot
           gameboard_display(xPos, yPos) = spriteVector(i); %Put sprite in that position on the gameboard.
     end
end
close all; %Close all other windows of the gameboard
gameboard_display(playerObj.xPos, playerObj.yPos) = player_sprite; %Put the player sprite on the board.
drawScene(my_scene,rooms_display,gameboard_display) %Redraw the room to match generation




running = true; %Initialize loop condition
while(running && room.room <= 5) %Run while game is in play
    keyInput = getKeyboardInput(my_scene); %Gets the keyboard input
    oldXPos = playerObj.xPos; %Keep track of the old x position
    oldYPos = playerObj.yPos; %Keep track of the old y position
    isChanged = false; %Keep track of if the player has moved or not
    if(keyInput == 'w') %Check if key input is w
        if(playerObj.xPos >= 2) %Check if the move is allowed
            playerObj.xPos = playerObj.xPos-1; %Move the player
            isChanged = true; %Show that the player has moved
        end
    elseif(keyInput == 's') %Check if the key input is s
        if(playerObj.xPos < 10) %Check if the move is allowed
            playerObj.xPos = playerObj.xPos+1; %Move the player
            isChanged = true; %Show that the player has moved
        end
    elseif(keyInput == 'd') %Check if the key input is d
        if(playerObj.yPos < 10) %Check if the move is allowed
            playerObj.yPos = playerObj.yPos+1; %Move the player
            isChanged = true; %Show that the player has moved
        end
    elseif(keyInput == 'a') %Check if the key input is a 
        if(playerObj.yPos >= 2) %Check if the move is allowed
             playerObj.yPos = playerObj.yPos-1; %Move the player
             isChanged = true; %Show that the player has move
        end
    end



    if(gameboard_display(playerObj.xPos, playerObj.yPos) ~= blank_sprite && gameboard_display(playerObj.xPos, playerObj.yPos) ~= player_sprite) %Check if the player has moved to a position containing a sprite
        if(gameboard_display(playerObj.xPos, playerObj.yPos) == 28*32+3) %Value assigned with sword sprite
            playerObj.attack = playerObj.attack+1; %Adjust the players stats
            fprintf("\nAttack Power-up! New Attack: %i", playerObj.attack) %Tell the player of the stat change
        elseif(gameboard_display(playerObj.xPos, playerObj.yPos) == 26*32+9) %Value assigned with shield sprite
            playerObj.defense = playerObj.defense+1; %Adjust the players stats
            fprintf("\nDefense Power-up! New Defense: %i", playerObj.defense) %Tell the player of the stat change
        elseif(gameboard_display(playerObj.xPos, playerObj.yPos) == 23*32+9) %Value assigned with boots sprite
            playerObj.speed = playerObj.speed+1; %Adjust the players stats
            fprintf("\nSpeed Power-up! New Speed: %i", playerObj.speed) %Tell the player of the stat change
        elseif(gameboard_display(playerObj.xPos, playerObj.yPos) == 23*32+27) %Value assigned with potion sprite
            playerObj.health = playerObj.health+1; %Adjust the players stats
            fprintf("\nHealth Power-up! New Health: %i", playerObj.health) %Tell the player of the stat change


        elseif(gameboard_display(playerObj.xPos, playerObj.yPos) == 9*32+11) %Value assigned with door, generate a new room
             running  = true; %Keep the game running
             room.room = room.room+1; %Increase the value of the room
             for i = 1: 10
                for j = 1: 10
                    gameboard_display(i,j) = blank_sprite; %Fill the room with blank sprites
                end
             end
             gameboard_display(10,10) = 9*32+11; %Put the door in the bottom right corner
             playerObj.xPos = 1; %Put player in the position 1,1
             playerObj.xPos = 1; %Put player in the position 1,1
             for i = 1: length(spriteVector) %Iterate throught the sprite vector
                xPos = randi([2,10],1); %Put the sprite in a random x position exluding 1
                yPos = randi([2,9],1); %Put the sprite in a random y position exluding 1,10        
                if(spriteVector(i) ~= 9*32+11) %Don't want to add Door to random spot
                    gameboard_display(xPos, yPos) = spriteVector(i); %Put sprite in that spot
                end
             end
             close all; %Close all other floor displays
             gameboard_display(playerObj.xPos, playerObj.yPos) = player_sprite; %Put player sprite in position 1,1
             drawScene(my_scene,rooms_display,gameboard_display) %Draw the new room



         elseif(gameboard_display(playerObj.xPos, playerObj.yPos) == 9*32+19)
             monsterObj = Monster(room.room); %Initialize Monster object with a level based on the room number
             %Player has encountered a monster and must fight it.


             runAgain = 0; %Intitialze loop condition
             while(runAgain == 0) %Run while condition is true
                playerInput = inputdlg("Use attack (type a), defense (type d), or speed (type s)? (Default is attack): "); %Get the players input
                playerInput = lower(playerInput); %Send string to lower case
                playerInput = playerInput(1); %Get first letter of the string
                monsterInput = randi([1,3],1); %Generate the monsters choice
                xpGain = room.room*5; %Determine the xp gain from the battle
                if(playerInput == "a" && monsterInput == 2) %2 = defense, player wins
                    fprintf("\nMonster chose defense, Player Wins Round!"); %Show the result of the battle
                    damage = 5+(playerObj.attack - monsterObj.defense); %Generate the damage
                    if(damage < 2) %Minimum damage is 2
                        damage = 2;
                    end
                    monsterObj.health = monsterObj.health-damage; %Adjust the health of the monster
                    fprintf(", New monster health: %i ", monsterObj.health) %Print result
                    if(monsterObj.health <= 0) %If the monster is dead
                        runAgain = 1; %End the battle
                        result = 0; %Player wins
                        if(room.room < playerObj.level) %Check how much xp needs to be given
                            xpGain = xpGain/2; %Determine xp gain
                            playerObj.xp = playerObj.xp+xpGain; %Adjust xp
                            levelUp(playerObj); %Check if player has leveled
                        else
                             playerObj.xp = playerObj.xp+xpGain;
                             levelUp(playerObj);
                        end
                     end
                elseif(playerInput == "d" && monsterInput == 3)%3 = speed, player wins
                    fprintf("\nMonster chose Defense, Player Wins Round!");%Display result to the player
                    damage = 5+(playerObj.defense -  monsterObj.speed); %Calculate damage
                    if(damage < 2) %Minimum damage is 2
                        damage = 2;
                    end
                    monsterObj.health = monsterObj.health-damage; %Adjust health
                    fprintf(", New monster health: %i ", monsterObj.health) %Display result
                    if(monsterObj.health <= 0) %If monster is dead
                        runAgain = 1; %End battle
                        result = 0; %Player wins
                        if(room.room < playerObj.level) %Determine xp
                            xpGain = xpGain/2;
                            playerObj.xp = playerObj.xp+xpGain; %Add xp
                            playerObj.levelUp(playerObj); %Check if player has leveled up
                        else
                            playerObj.xp = playerObj.xp+xpGain; %Award xp
                            levelUp(playerObj); %Check if player has leveled up
                        end
                    end
                elseif(playerInput == "s" && monsterInput == 1) %1 = attack, Player wins
                    fprintf("\nMonster chose attack, Player Wins Round!"); %Display results 
                    damage = 5+(playerObj.speed - monsterObj.attack); %Calculate damage
                    if(damage < 2) %Minimum damage is 2
                        damage = 2;
                    end
                    monsterObj.health = monsterObj.health-damage; %Adjust monster health
                    fprintf(", New monster health: %i ", monsterObj.health) %Display result
                        if(monsterObj.health <= 0) %Check if monster is defeated
                            runAgain = 1; %End battle
                            result = 0; %Player wins
                            if(room.room < playerObj.level) %Determine xp gain
                                xpGain = xpGain/2;
                                playerObj.xp = playerObj.xp+xpGain; %Award xp
                                levelUp(playerObj); %Check if player has leveled up
                            else
                                 playerObj.xp = playerObj.xp+xpGain; %Award xp
                                 levelUp(playerObj); %Check if player has leveled up
                            end
                         end
                 elseif(playerInput == "a" && monsterInput == 3) %3 = speed, monster wins
                    fprintf("\nMonster chose speed, Monster Wins Round"); %Print result
                    damage = 5+(monsterObj.speed - playerObj.attack); %Calculate damage
                    if(damage < 2) %Minimum damage is 2
                        damage = 2;
                    end 
                    playerObj.health = playerObj.health-damage; %Adjust player health
                    fprintf(", New Player Health: %i", playerObj.health) %Display result
                    if(playerObj.health <= 0) %Player is dead
                        runAgain = 1; %End battle
                        result = 1; %Monster wins
                        close all; %Close all windows
                        msg = msgbox("Game Over"); %The game is over.
                    end
                  elseif(playerInput == "d" && monsterInput == 1)%1 = attack, monster wins
                    fprintf("\nMonster chose attack, Monster Wins Round"); %Print result
                    damage = 5+(monsterObj.attack - playerObj.defense); %Calculate damage
                    if(damage < 2) %Minimum damage is 2
                        damage = 2;
                    end
                    playerObj.health = playerObj.health-damage; %Adjust player health
                    fprintf(", New Player Health: %i", playerObj.health) %Print result
                    if(playerObj.health <= 0) %If player is dead.
                        runAgain = 1; %End battle
                        result = 1; %Monster wins
                        close all; %Close all windows
                        msg = msgbox("Game Over"); %The game is over
                    end
                   elseif(playerInput == "s" && monsterInput == 2) %2 = defense, monster wins
                    fprintf("\nMonster chose defense, Monster Wins Round"); %Print result
                    damage = 5+(monsterObj.defense - playerObj.speed); %Calculate damage
                    if(damage < 2) %Minimum damage is 2
                        damage = 2;
                    end
                    playerObj.health = playerObj.health-damage; %Adjust player health
                    fprintf(", New Player Health: %i", playerObj.health) %Print result
                    if(playerObj.health <= 0) %If player is dead
                        runAgain = 1; %End battle
                        result = 1; %Monster wins
                        close all; %Close all windows
                        msg = msgbox("Game Over"); %The game is over
                    end
                 end
             end





                    if(result == 1) %if monster wins
                        running = false; %The game is over
                        close all; %Close all windows 
                    else
                        running = true; %Game keeps running
                    end
         end
                
        else
            running = true; %Game keeps running
   end
        gameboard_display(playerObj.xPos, playerObj.yPos) = player_sprite; %Adjust the position of the player sprite
        
        
        
        
        
        
        
        
        if(isChanged == true) %If the player has moved
            gameboard_display(oldXPos, oldYPos) = blank_sprite; %Make the players old position blank
        end
        drawScene(my_scene,rooms_display,gameboard_display) %Redraw the board
        if(keyInput == 'q')
            running = false; %Player has quit the game
        end
        if(room.room == 6) %Player has reached the boss.
            close all; %Close all windows
            fprintf("\nBoss Battle!") %Tell the player the boss has been reached
            image = imread('boss.jpg'); %Display boss image
            imshow(image); %Show the image
            monsterObj = Monster((room.room*2)+5); %Initialze the boss
            [y, Fs] = audioread('bossSong.mp3'); %Load in the boss music
            player = audioplayer(y,Fs); %Create an audioplayer for the song
            play(player) %Play the song
            runAgain = 0; %Initialize the loop condtion
            while(runAgain == 0)
            playerInput = inputdlg("Use attack (type a), defense (type d), or speed (type s)? (Default is attack): "); %Get user choice
            playerInput = lower(playerInput); %Put the input into lower case
            playerInput = playerInput(1); %Get the first letter of the player input
            monsterInput = randi([1,3],1); %Generate the monster input
            if(playerInput == "a" && monsterInput == 2) %2 = defense, player wins
                   fprintf("\nMonster chose defense, Player Wins Round!"); %Display result
                   damage = 5+(playerObj.attack - monsterObj.defense); %Calculate damage
                   if(damage < 2) %Minimum damage is 2
                        damage = 2;
                   end
                   monsterObj.health = monsterObj.health-damage; %Adjust monster health
                   fprintf(", New monster health: %i ", monsterObj.health) %Display result
                   if(monsterObj.health <= 0) %If monster is defeated
                        runAgain = 1; %End battle
                        result = 0; %Player wins
                   end
            elseif(playerInput == "d" && monsterInput == 3)%3 = speed, player wins
                fprintf("\nMonster chose Defense, Player Wins Round!"); %Display result
                damage = 5+(playerObj.defense -  monsterObj.speed); %Calculate damage
                if(damage < 2) %Minimum damage is 2
                    damage = 2;
                end
                monsterObj.health = monsterObj.health-damage; %Adjust monster health
                fprintf(", New monster health: %i ", monsterObj.health) %Display result
                if(monsterObj.health <= 0) %If monster is defeated
                    runAgain = 1; %End battle
                    result = 0; %Player wins
                end
            elseif(playerInput == "s" && monsterInput == 1) %1 = attack, Player wins
                fprintf("\nMonster chose attack, Player Wins Round!"); %Display result
                damage = 5+(playerObj.speed - monsterObj.attack); %Calculate damage
                if(damage < 2) %Minimum damage is 2.
                    damage = 2;
                end
                monsterObj.health = monsterObj.health-damage; %Adjust monster health
                fprintf(", New monster health: %i ", monsterObj.health) %Display result
                if(monsterObj.health <= 0) %If monster is defeated
                    runAgain = 1; %End battle
                    result = 0; %Player wins
                end
            elseif(playerInput == "a" && monsterInput == 3) %3 = speed, monster wins
                fprintf("\nMonster chose speed, Monster Wins Round"); %Display result
                damage = 5+(monsterObj.speed - playerObj.attack); %Calculate damage
                if(damage < 2) %Minimum damage is 2
                    damage = 2;
                end
                playerObj.health = playerObj.health-damage; %Adjust player health
                fprintf(", New Player Health: %i", playerObj.health) %Display result
                if(playerObj.health <= 0) %If player is defeated
                    runAgain = 1; %End battle
                    result = 1; %Monster wins
                    close all; %Close all windows
                    stop(player); %Stop the music
                    msg = msgbox("Game Over"); %The game is over
                end
             elseif(playerInput == "d" && monsterInput == 1)%1 = attack, monster wins
                  fprintf("\nMonster chose attack, Monster Wins Round"); %Display the result
                  damage = 5+(monsterObj.attack - playerObj.defense); %Calculate the damage
                  if(damage < 2) %Minimum damage is 2
                      damage = 2;
                  end
                  playerObj.health = playerObj.health-damage; %Adjust player health
                  fprintf(", New Player Health: %i", playerObj.health) %Display result
                  if(playerObj.health <= 0) %If player is defeated
                       runAgain = 1; %End battle
                       result = 1; %Monster wins
                       close all; %Close all windows
                       stop(player); %Stop music
                       msg = msgbox("Game Over"); %The game is over
                  end
            elseif(playerInput == "s" && monsterInput == 2) %2 = defense, monster wins
                fprintf("\nMonster chose speed, Monster Wins Round"); %Display result
                damage = 5+(monsterObj.defense - playerObj.speed); %Calculate damage
                if(damage < 2) %Minimum damage is 2
                    damage = 2;
                end
                playerObj.health = playerObj.health-damage; %Adjust player health
                fprintf(", New Player Health: %i", playerObj.health) %Display result
                if(playerObj.health <= 0) %If player is defeated
                    runAgain = 1; %End battle
                    result = 1; %Monster wins
                    close all; %Close all windows 
                    stop(player); %Stop the music
                    msg = msgbox("Game Over"); %The game is over
                end
            end
            end




            close all; %Close all windows
            if(result == 0) %Check if player won
                msg = msgbox("The Player Wins"); %Display result
                fprintf("\nYou got your kid back from the dungeon!");
            end
        end
end

        function levelUp(playerObj)
            if(playerObj.xp >= 20) %Check if xp requirement has been met
                fprintf("\nLevel Up!\n") %Tell the player that they have leveled up
                playerObj.level = playerObj.level+1; %Adjust level
                playerObj.xp = 0; %Adjust xp
                playerObj.health = playerObj.health+5; %Adjust health
                playerObj.attack = playerObj.attack+5; %Adjust attack
                playerObj.defense = playerObj.defense+5; %Adjust defense
                playerObj.speed = playerObj.speed + 5; %Adjust speed
                fprintf("New stats: \n") %Display the new stats
                fprintf("Health: %i  \n", playerObj.health)
                fprintf("Attack: %i \n", playerObj.attack)
                fprintf("Defense: %i \n", playerObj.defense)
                fprintf("Speed: %i \n", playerObj.speed)
            end
        end