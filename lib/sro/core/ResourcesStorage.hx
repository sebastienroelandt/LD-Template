package lib.sro.core;

import lib.sro.core.ResourcesStorage;
import lib.sro.data.StatedAnimationData;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sebastien roelandt
 */
class ResourcesStorage
{
	///Instance
	private static var instance:ResourcesStorage;
		
	private static var statedAnimationDatas:Map<String,StatedAnimationData>;
	
	public static function getInstance():ResourcesStorage {
		if (instance == null) {
			instance = new ResourcesStorage();
		}
		return instance;
	}
	
	private function new() {
		statedAnimationDatas = new Map();
	}
	
	public function getStatedAnimationData(name:String):StatedAnimationData {
		return statedAnimationDatas.get(name);
	}
	
	public function addStatedAnimationData(name:String, spritesheet:StatedAnimationData) {
		return statedAnimationDatas.set(name, spritesheet);
	}
}