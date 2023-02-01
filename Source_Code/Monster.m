classdef Monster < handle
    properties
        health = 5;
        attack = 5;
        speed = 5;
        defense = 5;
    end
    
    methods
        function obj = Monster(level)
            if nargin == 0
                obj.health = 5;
                obj.attack = 5;
                obj.speed = 5;
                obj.defense = 5;
            else
                obj.health = (5*level);
                obj.attack = (5*level);
                obj.speed = (5*level);
                obj.defense = (5*level);
            end
        end
    end
end
                