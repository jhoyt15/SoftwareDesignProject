classdef Player < handle
    properties
        attack = 10;
        defense = 10;
        speed = 10;
        xp = 0;
        level = 1;
        health = 15;
        xPos = 1;
        yPos = 1;
    end
    methods 
        function powerUp(playerObj,item)
            if(item == "Attack")
                playerObj.attack = playerObj.attack+1;
            elseif(item == "Defense")
                playerObj.defense = playerObj.defense+1;
            else
                playerObj.speed = playerObj.speed+1;
            end
        end

        function levelUp(playerObj)
            if(playerObj.xp >= 25)
                fprintf("Level Up!")
                playerObj.level = playerObj.level+1;
                playerObj.xp = 0;
                playerObj.health = playerObj.health+5;
                playerObj.attack = playerObj.attack+5;
                playerObj.defense = playerObj.defense+5;
                playerObj.speed = playerObj.speed + 5;
            end
        end
    end
end
