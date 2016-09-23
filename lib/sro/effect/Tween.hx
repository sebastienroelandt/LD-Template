package lib.sro.effect;

/**
 * ...
 * @author Sebastien roelandt
 */
enum TweenType {
	Linear;
	Loop;
	LoopEaseIn;
	LoopEaseOut;
	Random;
}
 
class Tween
{
	private var speed		:Int;
	private var type		:TweenType;
	
	public function new(speed:Int) {
		this.speed = speed;
	}
	
	private dynamic function interpolate(v:Float) -> Float {
		return v;
	}
	
	private function power2(n:Float) -> Float {
		return n * n;
	}
	
	private function power3(n:Float) -> Float {
		return n * n * n;
	}
	
	private function bezier(t:Float, x0:Float, x1:Float, x2:Float, x3: Float) -> Float {
		return power3(1 - t) * x0 +
			3 * t * power2(1 - t) * x1 +
			3 * power2(t) * (1 - t) * x2 +
				power3(t) * x3;
	}
	
	private function random(t:Float) -> Float {
		return 
			if (Std.random(100) < 33) 
				t
			else
				0;
	}
	
	private function setType(type:TweenType) {
		this.type = type;
		this.interpolate = switch(type) {
			case Linear			: function(v) return v;
			case Loop			: function(v) return v;
			case LoopEaseIn 	: function(v) return bezier(v, 0.00, 0.00, 2.25, 1.00);
			case LoopEaseOut	: function(v) return bezier(v, 0.00, 2.25, 0.00, 1.00);
			case Random			: function(v) return random(v);
		}
	}
	
	public function update(time:Float) -> Bool {
		
	}
	
}