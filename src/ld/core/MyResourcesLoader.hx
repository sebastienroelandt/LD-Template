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
		
		var tileset = Assets.getBitmapData("img/2ColorsTileset.png");
		var tilesetData = ResourcesLoader.splitToBitmapData(tileset, 0, 0, 8, 8, 2, 1);
		rs.addTileset("myGround", tilesetData);
		
	}
	
}