package lib.sro.data;

import openfl.display.Bitmap;

/**
 * ...
 * @author Sebastien roelandt
 */
class AnimationData
{
	private var name:String;

	private var bitmaps:Array<Bitmap>;
	private var speeds:Array<Int>;
	private var speedsSteps:Array<Int>;
	
	private var loop:Bool;
	
	public function new(name:String, ?loop:Bool = true) 
	{
		this.name = name;
		
		this.bitmaps = new Array<Bitmap>();
		this.speeds = new Array<Int>();
		this.speedsSteps = new Array<Int>();
		this.loop = loop;
	}
	
	private function addSpeed(s:Int) {
		speeds.push(s);
		if (speedsSteps.length == 0) {
			speedsSteps.push(s);
		} else {
			speedsSteps.push(speedsSteps[speedsSteps.length - 1] + s);
		}
	}
	
	public function addLinearFrames(frames:Array<Bitmap>, ?speed:Int=1) {
		var speeds = new Array<Int>();
		for (frame in frames) {
			speeds.push(speed);
		}
		addVariousFrames(frames, speeds);
	}
	
	public function addVariousFrames(frames:Array<Bitmap>, speeds:Array<Int>) {
		if (frames.length == speeds.length) {
			for (frame in frames) {
				bitmaps.push(frame);
			}
			for (speed in speeds) {
				addSpeed(speed);
			}
		} else {
			throw "frames and speeds must be equals !";
		}
	}
	
	public function setLoop(loop:Bool) {
		this.loop = loop;
	}
	
	public function getLoop():Bool {
		return this.loop;
	}
	
	public function getLoopTime():Int {
		return speedsSteps[speedsSteps.length - 1];
	}
	
	public function getFrame(index:Int):Bitmap {
		if (index > bitmaps.length ) {
			index = bitmaps.length;
		}
		return bitmaps[index];
	}
	
	public function getLength():Int {
		return bitmaps.length;
	}
	
	public function getSpeedStep(index:Int) {
		return speedsSteps[index];
	}
}