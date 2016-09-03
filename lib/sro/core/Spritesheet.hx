package lib.sro.core;

import openfl.display.Bitmap;

/**
 * ...
 * @author Sebastien roelandt
 */
class Spritesheet
{
	private var name:String;
	private var framesData: Map<String, FrameData>;
	
	public function new(name:String) 
	{
		this.framesData = new Map();
		this.name = name;
	}
	
	public function addLinearFrames(name:String, frames:Array<Bitmap>, ?speed:Int = 1):Void {
		getFrameData(name).addLinearFrames(frames, speed);
	}
	
	public function addVariousFrames(name:String, frames:Array<Bitmap>, speeds:Array<Int>):Void {
		getFrameData(name).addVariousFrames(frames, speeds);
	}
	
	public function setLoop(name:String, loop:Bool):Void {
		var frameData = framesData.get(name);
		if (frameData != null) {
			frameData.setLoop(loop);
		}
	}
	
	public function getFrameData(name:String):FrameData {
		var frameData = framesData.get(name);
		if (frameData == null) {
			frameData = new FrameData(name, true);
			framesData.set(name, frameData);
		}
		return frameData;
	}
	
	public function getDefaultFrameData():FrameData {
		var frameData = null;
		var iterator = framesData.iterator();
		if (iterator.hasNext()) {
			frameData = iterator.next();
		}
		return frameData;
	}
}