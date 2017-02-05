package lib.sro.debug;

import lib.sro.ui.BasicUI;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Sebastien roelandt
 */
class ViusalPoint extends BasicUI
{
	var follow 		: BasicUI;
	
	public function new(?size = 1, ?color = 0xFF0000) 
	{
		super();
		
		this.graphics.beginFill(color, 1);
		this.graphics.drawRect(0, 0, size, size);
		this.graphics.endFill();
	}
	
	public function setPosition(point:Point) {
		this.x = point.x;
		this.y = point.y;
	}
	
}