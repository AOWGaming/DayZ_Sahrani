private["_iItem","_iClass","_iPos","_radius","_itemTypes","_index","_item","_qty","_max","_tQty","_canType","_weights","_cntWeights","_dateNow"];
_iItem = 	_this select 0;
_iClass = 	_this select 1;
_iPos =	_this select 2;
_radius =	_this select 3;
//diag_log Format["DEBUG LOOT: %1", _iClass];
switch (_iClass) do {
	default {
		//Item is food, add random quantity of cans along with an item (if exists)
		_item = createVehicle ["WeaponHolder", _iPos, [], _radius, "CAN_COLLIDE"];
		_itemTypes = [] + ((getArray (configFile >> "cfgLoot" >> _iClass)) select 0);
		_index = dayz_CLBase find _iClass;
		_weights = dayz_CLChances select _index;
		_cntWeights = count _weights;
		_qty = 0;
		if( _iClass == "trash" ) then {
			_max = ceil(random 3) + 1;
		} else {
			_max = ceil(random 2) + 1;
		};
		while {_qty < _max} do {
			_tQty = 1;//round(random 1) + 1;
			_index = floor(random _cntWeights);
			_index = _weights select _index;
			_canType = _itemTypes select _index;
			_item addMagazineCargoGlobal [_canType,_tQty];
			_qty = _qty + _tQty;
		};
		if (_iItem != "") then {
			_item addWeaponCargoGlobal [_iItem,1];
		};
	};
	case "weapongroup": {
		//Item is a Weapon, Pick a random weapon and add ammo
		_item = createVehicle ["WeaponHolder", _iPos, [], _radius, "CAN_COLLIDE"];
		_itemTypes = [] + ((getArray (configFile >> "cfgLoot" >> _iItem)) select 0);
		_index = dayz_CLBase find _iClass;
		_weights = dayz_CLChances select _index;
		_cntWeights = count _weights;
		
		_index = floor(random _cntWeights);
		_index = _weights select _index;
		_iItem = _itemTypes select _index;
		_item addMagazineCargoGlobal [_iItem,1];
		_mags = [] + getArray (configFile >> "cfgWeapons" >> _iItem >> "magazines");
		if ((count _mags) > 0) then {
			if (_mags select 0 == "Quiver") then { _mags set [0, "WoodenArrow"] }; // Prevent spawning a Quiver
			_item addMagazineCargoGlobal [(_mags select 0), (round(random 3))];
		};
	};
	case "weapon": {
		//Item is a weapon, add it and a random quantity of magazines
		_item = createVehicle ["WeaponHolder", _iPos, [], _radius, "CAN_COLLIDE"];
		_item addWeaponCargoGlobal [_iItem,1];
		_mags = [] + getArray (configFile >> "cfgWeapons" >> _iItem >> "magazines");
		if ((count _mags) > 0) then {
			if (_mags select 0 == "Quiver") then { _mags set [0, "WoodenArrow"] }; // Prevent spawning a Quiver
			_item addMagazineCargoGlobal [(_mags select 0), (round(random 3))];
		};
	};
	case "magazine": {
		//Item is one magazine
		_item = createVehicle ["WeaponHolder", _iPos, [], _radius, "CAN_COLLIDE"];
		_item addMagazineCargoGlobal [_iItem,1];
	};
	case "object": {
		//Item is one magazine
		_item = createVehicle [_iItem, _iPos, [], _radius, "CAN_COLLIDE"];
	};
};

// timestamp for later clearing
_dateNow = (DateToNumber date);
_item setVariable ["looted",_dateNow,true];

_iPosZ = _iPos select 2;
if( _iPosZ < 0 ) then { _iPos = [_iPos select 0,_iPos select 1,0]; };


if ((count _iPos) > 2) then {
	_item setPosATL _iPos;
};
