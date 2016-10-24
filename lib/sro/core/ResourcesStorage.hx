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
	private static var bitmaps:Map<String, Bitmap>;
	
	public static function getInstance():ResourcesStorage {
		if (instance == null) {
			instance = new ResourcesStorage();
		}
		return instance;
	}
	
	private function new() {
		statedAnimationDatas = new Map();
		bitmaps = new Map();
	}
	
	public function getStatedAnimationData(name:String):StatedAnimationData {
		return statedAnimationDatas.get(name);
	}
	
	public function addStatedAnimationData(name:String, spritesheet:StatedAnimationData) {
		return statedAnimationDatas.set(name, spritesheet);
	}
	
	public function getBitmap(name:String):Bitmap {
		return bitmaps.get(name);
	}
	
	public function addBitmap(name:String, bitmap:Bitmap) {
		return bitmaps.set(name, bitmap);
	}
}