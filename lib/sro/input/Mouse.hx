package lib.sro.input;

import openfl.events.MouseEvent;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class Mouse
{
	static var down:Bool;
	static var click:Bool;
	static var previousClick:Bool;
	static var scrollUp:Bool;
	static var scrollDown:Bool;
	static var x:Float;
	static var y:Float;

	public static function init(){
		down = false;
		click = false;
		previousClick = false;
		x = 0;
		y = 0;
	}
	
	//Update
	public static function onKeyDown(e:MouseEvent) {
		down = true;
	}
	
	public static function onKeyUp(e:MouseEvent) {
		if (down) {
			click = true;
		}
		down = false;
	}
	
	public static function onMove(e:MouseEvent) {
		x = e.stageX;
		y = e.stageY;
	}
	
	public static function onScroll(e:MouseEvent) {
		if (e.delta > 0) {
			scrollUp = true;
		} else if (e.delta < 0) {
			scrollDown = true;
		}
		
		if (scrollUp && scrollDown) {
			scrollUp = scrollDown = false;
		}
	}
	
	public static function reset() {
		previousClick = false;
		if (click) {
			click = false;
			previousClick = true;
		}
		scrollUp = scrollDown = false;
	}
	
	//Listen methods
	public static function isDown():Bool {
		return down;
	}
	
	public static function isClick():Bool {
		return previousClick;
	}
	
	public static function getXY():Point{
		return new Point(x,y);
	}
	
	public static function isScrollUp():Bool {
		return scrollUp;
	}
	
	public static function isScrollDown():Bool {
		return scrollDown;
	}
}