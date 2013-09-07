//Medical Event Handlers
"norrnRaLW"   		addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\publicEH\load_wounded.sqf"};
"norrnRLact"		addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\load\load_wounded.sqf"};
"norrnRDead"   		addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\publicEH\deadState.sqf"};
"usecBleed"			addPublicVariableEventHandler {_id = (_this select 1) spawn fnc_usec_damageBleed};
"usecBandage"		addPublicVariableEventHandler {(_this select 1) call player_medBandage};
"usecInject"		addPublicVariableEventHandler {(_this select 1) call player_medInject};
"usecEpi"			addPublicVariableEventHandler {(_this select 1) call player_medEpi};
"usecTransfuse"		addPublicVariableEventHandler {(_this select 1) call player_medTransfuse};
"usecMorphine"		addPublicVariableEventHandler {(_this select 1) call player_medMorphine};
"usecPainK"			addPublicVariableEventHandler {(_this select 1) call player_medPainkiller};
"dayzHit" 			addPublicVariableEventHandler {(_this select 1) call fnc_usec_damageHandler};
"dayzHitV" 			addPublicVariableEventHandler {(_this select 1) call fnc_usec_damageVehicle};
"dayzHideBody"		addPublicVariableEventHandler {hideBody (_this select 1)};
"dayzGutBody"		addPublicVariableEventHandler {(_this select 1) spawn local_gutObject};
"dayzDelLocal"		addPublicVariableEventHandler {(_this select 1) call object_delLocal};
"dayzVehicleInit"	addPublicVariableEventHandler {(_this select 1) call fnc_vehicleEventHandler};
"dayzHumanity"		addPublicVariableEventHandler {(_this select 1) spawn player_humanityChange};
"dayz_serverObjectMonitor"		addPublicVariableEventHandler {dayz_serverObjectMonitor = dayz_safety};
"dayzSetFuel"		addPublicVariableEventHandler {(_this select 1) spawn local_setFuel};
"dayzSetFix"		addPublicVariableEventHandler {(_this select 1) call object_setFixServer};

//Both

//Server only
if (isServer) then {
	"dayzDeath"			addPublicVariableEventHandler {_id = (_this select 1) spawn server_playerDied};
	"dayzDiscoAdd"		addPublicVariableEventHandler {dayz_disco set [count dayz_disco,(_this select 1)];};
	"dayzDiscoRem"		addPublicVariableEventHandler {dayz_disco = dayz_disco - [(_this select 1)];};
	"dayzPlayerSave"	addPublicVariableEventHandler {_id = (_this select 1) call server_playerSync;};
	"dayzPublishObj"	addPublicVariableEventHandler {(_this select 1) call server_publishObj};
	"dayzUpdateVehicle" addPublicVariableEventHandler {_id = (_this select 1) call server_updateObject};
	"dayzLogin"			addPublicVariableEventHandler {_id = (_this select 1) call server_playerLogin};
	"dayzLogin2"		addPublicVariableEventHandler {(_this select 1) call server_playerSetup};
	"dayzPlayerMorph"	addPublicVariableEventHandler {(_this select 1) call server_playerMorph};
	"dayzUpdate"		addPublicVariableEventHandler {_id = (_this select 1) spawn dayz_processUpdate};
	"dayzLoginRecord"	addPublicVariableEventHandler {_id = (_this select 1) spawn dayz_recordLogin};
	"dayzCharSave"		addPublicVariableEventHandler {_id = (_this select 1) spawn server_playerSync};
	//Checking
	"dayzDeleteObj"		addPublicVariableEventHandler {(_this select 1) spawn server_deleteObj};
	"dayzCarBomb"	addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\actions\detonate_bomb.sqf";};
};

//Client only
if (!isDedicated) then {
	"dayzSetDate"		addPublicVariableEventHandler {setDate (_this select 1)};
	//"dayzFlies"			addPublicVariableEventHandler {(_this select 1) call spawn_flies};
	"dayzRoadFlare"		addPublicVariableEventHandler {(_this select 1) spawn object_roadFlare};
	"norrnRaDrag"   	addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\publicEH\animDrag.sqf"};
	"norrnRnoAnim"  	addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\publicEH\noAnim.sqf"};
	"changeCharacter"	addPublicVariableEventHandler {(_this select 1) call player_serverModelChange};
	"dayzSwitch"		addPublicVariableEventHandler {(_this select 1) call server_switchPlayer};
	"dayzFire"			addPublicVariableEventHandler {nul=(_this select 1) spawn BIS_Effects_Burn};
	"dayzAnimCrash"	addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\actions\crashmonitor.sqf";};
};
