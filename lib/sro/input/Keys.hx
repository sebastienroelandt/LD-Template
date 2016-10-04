package lib.sro.input;

import openfl.events.KeyboardEvent;

/**
 * ...
 * @author Sebastien roelandt
 */
class Keys
{
	static var downCodes = new Map< Int, Bool >();
	static var upCodes =  new Map< Int, Bool >();
	static var isEspaced =  new Map< Int, Bool >();

	public static function init() {
		downCodes = new Map();
		upCodes = new Map();
	}
	
	//Update
	public static function setKeyDown(e:KeyboardEvent) {
		onKey(e.keyCode, true);
	}
	
	public static function setKeyUp(e:KeyboardEvent) {
		onKey(e.keyCode, false);
	}
	
	public static function onKey( code:Int, down:Bool ) {
		if ( down ) {
			downCodes.set(code, true);
			upCodes.set(code, false);
		} else {
			upCodes.set(code, true);
			isEspaced.set(code,true);
			downCodes.set(code, false);
		}
	}
	
	//Listen methods
	public static function isDown(k:Int) {
		return downCodes.get(k);
	}
	
	public static function isUp(k:Int) {
		return upCodes.get(k);
	}
	
	public static function isClick(k:Int) {
		if (downCodes.get(k) && isEspaced.get(k)){
			isEspaced.set(k, false);
			return true;
		}
		return false;
	}
}