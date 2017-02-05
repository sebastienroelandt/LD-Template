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
		
		var body = new StatedAnimationData("body"); 
		var bodyTileset = Assets.getBitmapData("img/Body.png"); 
		body.addLinearFrames("move", ResourcesLoader.splitToBitmap(bodyTileset, 0, 0, 64, 64, 4, 1),100); 
		body.setLoop("move", true); 
		rs.addStatedAnimationData("body", body); 
		
		var head = new StatedAnimationData("head"); 
		var headTileset = Assets.getBitmapData("img/Head.png"); 
		head.addLinearFrames("move", ResourcesLoader.splitToBitmap(headTileset, 0, 0, 64, 64, 4, 1),100); 
		head.setLoop("move", true); 
		rs.addStatedAnimationData("head", head); 
	}
	
}