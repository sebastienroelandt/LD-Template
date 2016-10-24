package ld.core;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import lib.sro.data.StatedAnimationData;
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
		
		var fish = new StatedAnimationData("fish");
		fish.addLinearFrames("move_right", ResourcesLoader.split(bitmapData, 0, 0, 48, 48, 4), 100);
		fish.setLoop("move_right", true);
		fish.addLinearFrames("transform_right", ResourcesLoader.split(bitmapData, 0, 48, 48, 48, 4), 100);
		fish.setLoop("transform_right", true);
		rs.addStatedAnimationData("fish", fish);
		
		var buttonBitmapData:BitmapData = Assets.getBitmapData("img/button.png");
		var buttons = ResourcesLoader.split(buttonBitmapData, 0, 0, 300, 50, 1, 3);
		rs.addBitmap("defaultButton", buttons[0]);
		rs.addBitmap("hoverButton", buttons[1]);
		rs.addBitmap("clickButton", buttons[2]);
	}
	
}