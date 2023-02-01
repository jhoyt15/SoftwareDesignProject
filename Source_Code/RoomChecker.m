classdef RoomChecker < handle
    properties
        room = 1;
    end

    methods
        function changeRoom(RoomChecker)
            RoomChecker.room = RoomChecker+1;
        end

    end
end

            