package lib.sro.core;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class ResourcesLoader
{
	public static function split(source:BitmapData, startX:Int, startY:Int, 
		width:Int, height:Int, ?repeatX = 1, ?repeatY = 1) : Array<Bitmap> {
		
		if (source == null || width <= 0 || height <= 0 || repeatX <= 0 || repeatY <= 0) {
			throw "split impossible, un des parametres est non conforme !";
		}
		var destination = new Array<Bitmap>();
		for (y in 0...repeatY){
			for (x in 0...repeatX) {
				var cutBitmapData:BitmapData = new BitmapData(width , height);
				cutBitmapData.copyPixels(source, new Rectangle(startX + x*width, startY + y*height, width, height), new Point(0, 0));
				
				destination.push(new Bitmap(cutBitmapData));
			}
		}
		
		return destination;
	}
}