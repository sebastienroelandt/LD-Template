package lib.sro.ui;

import lib.sro.ui.BasicUI;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

/**
 * ...
 * @author Sebastien roelandt
 */
class TiledMapUI extends BasicUI
{
	
	public function new(tileset:Array<BitmapData>,	values:Array<Array<Int>>) 
	{
		super();
		for (j in 0...values.length) {
			var line = values[j];
			for (i in 0...line.length) {
				var tileBitmapData = tileset[line[i]];
				var child = new BasicUI();
				child.addChild(new Bitmap(tileBitmapData));
				child.x = i * 32;
				child.y = j * 32;
				add(child);
			}
		}
	}
	
}