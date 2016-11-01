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
		fish.addLinearFrames("move_right", ResourcesLoader.splitToBitmap(bitmapData, 0, 0, 48, 48, 4), 100);
		fish.setLoop("move_right", true);
		fish.addLinearFrames("transform_right", ResourcesLoader.splitToBitmap(bitmapData, 0, 48, 48, 48, 4), 100);
		fish.setLoop("transform_right", true);
		rs.addStatedAnimationData("fish", fish);
		
		var buttonBitmapData:BitmapData = Assets.getBitmapData("img/button.png");
		var buttons = ResourcesLoader.splitToBitmap(buttonBitmapData, 0, 0, 300, 50, 1, 3);
		rs.addBitmap("defaultButton", buttons[0]);
		rs.addBitmap("hoverButton", buttons[1]);
		rs.addBitmap("clickButton", buttons[2]);
		
		var toggleButtonBitmapData:BitmapData = Assets.getBitmapData("img/toggleButton.png");
		var toggleButtons = ResourcesLoader.splitToBitmap(toggleButtonBitmapData, 0, 0, 20, 20, 4, 1);
		rs.addBitmap("defaultRightButton", toggleButtons[0]);
		rs.addBitmap("activeRightButton", toggleButtons[1]);
		rs.addBitmap("defaultLeftButton", toggleButtons[2]);
		rs.addBitmap("activeLeftButton", toggleButtons[3]);
		
		var sourceTileset:BitmapData = Assets.getBitmapData("img/tileset.png");
		var tileset:Array<BitmapData> = ResourcesLoader.splitToBitmapData(sourceTileset, 0, 0, 32, 32, 8, 3);
		rs.addTileset("background", tileset);
		
		rs.addSound("1", Assets.getSound("audio/1.wav"));
		rs.addSound("2", Assets.getSound("audio/2.wav"));
		rs.addSound("3", Assets.getSound("audio/3.wav"));
	}
	
}