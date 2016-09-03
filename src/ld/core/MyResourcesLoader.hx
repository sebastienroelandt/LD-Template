package ld.core;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import lib.sro.core.Spritesheet;
import lib.sro.core.ResourcesLoader;
import lib.sro.core.ResourcesStorage;


/**
 * ...
 * @author Sebastien roelandt
 */
class MyResourcesLoader
{
	public static function load(rs:ResourcesStorage) {
		var bitmapData:BitmapData = Assets.getBitmapData("img/fish.png");
		
		var fishSpritesheet = new Spritesheet("fish");
		fishSpritesheet.addLinearFrames("move_right", ResourcesLoader.split(bitmapData, 0, 0, 48, 48, 4), 100);
		fishSpritesheet.setLoop("move_right", false);
		fishSpritesheet.addLinearFrames("transform_right", ResourcesLoader.split(bitmapData, 0, 48, 48, 48, 4), 100);
		fishSpritesheet.setLoop("transform_right", false);
		rs.addSpritesheet("fish",fishSpritesheet);
	}
	
}