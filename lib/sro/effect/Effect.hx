package lib.sro.effect;

import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;

/**
 * ...
 * @author Sebastien roelandt
 */
class Effect 
{
	private var lastTime:Float;
	private var applyTo:Sprite;
	
	public function new(applyTo:Sprite) {
		applyTo.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		this.applyTo = applyTo;
		lastTime = Lib.getTimer();
	}
	
	private function onEnterFrame(e:Event) {
		var currentTime = Lib.getTimer();
		update(Std.int(currentTime - lastTime));
		lastTime = currentTime;
	}
	
	public function update(delta:Int) {
		throw "update function of Effect must be overrited !";
	}
}