package lib.sro.core;

import lib.sro.core.ResourcesStorage;
import lib.sro.data.StatedAnimationData;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

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
	private static var tilesets:Map<String, Array<BitmapData>>;
	private static var tilemapValues:Map<String, Array<Array<Int>>>;
	
	public static function getInstance():ResourcesStorage {
		if (instance == null) {
			instance = new ResourcesStorage();
		}
		return instance;
	}
	
	private function new() {
		statedAnimationDatas = new Map();
		bitmaps = new Map();
		tilesets = new Map();
		tilemapValues = new Map();
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
	
	public function getTileset(name:String):Array<BitmapData> {
		return tilesets.get(name);
	}
	
	public function addTileset(name:String, tileset:Array<BitmapData>) {
		return tilesets.set(name, tileset);
	}
	
	public function getTilemapValues(name:String):Array<Array<Int>> {
		return tilemapValues.get(name);
	}
	
	public function addTilemapValues(name:String, values:Array<Array<Int>>) {
		return tilemapValues.set(name, values);
	}
}