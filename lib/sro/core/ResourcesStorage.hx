package lib.sro.core;

import lib.sro.core.ResourcesStorage;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sebastien roelandt
 */
class ResourcesStorage
{
	///Instance
	private static var instance:ResourcesStorage;
		
	private static var spritesheets:Map<String,Spritesheet>;
	
	public static function getInstance():ResourcesStorage {
		if (instance == null) {
			instance = new ResourcesStorage();
		}
		return instance;
	}
	
	private function new() {
		spritesheets = new Map();
	}
	
	public function getSpritesheet(name:String):Spritesheet {
		return spritesheets.get(name);
	}
	
	public function addSpritesheet(name:String, spritesheet:Spritesheet) {
		return spritesheets.set(name, spritesheet);
	}
}