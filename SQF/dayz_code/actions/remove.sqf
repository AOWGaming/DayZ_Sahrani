/*
delete object from db
parameters: _obj
*/
private["_obj","_objectID","_objectUID"];
_obj		= _this select 3;
_objectID 	= _obj getVariable ["ObjectID","0"];
_objectUID	= _obj getVariable ["ObjectUID","0"];

player playActionNow "Medic";
sleep 1;

	_dis=5;			//p2: Zombie alert distance, reduced from 20 meters to 5
	_sfx = "repair";
	[player,_sfx,0,false,_dis] call dayz_zombieSpeak;  
	[player,_dis,true,(getPosATL player)] spawn player_alertZombies;

sleep 5;
	
//["dayzDeleteObj",[_objectID,_objectUID]] call callRpcProcedure;
	dayzDeleteObj = [_objectID,_objectUID];
	publicVariable "dayzDeleteObj";
deleteVehicle _obj;