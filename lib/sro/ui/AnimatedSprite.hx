package lib.sro.ui;

import lib.sro.layers.DrawableLayer;
import lib.sro.core.Spritesheet;
import lib.sro.core.FrameData;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author Sebastien roelandt
 */
class AnimatedSprite extends Sprite
{
	private var spritesheet:Spritesheet;
	private var currentFrameData:FrameData;
	private var frameDataQueue:Array<FrameData>;
	private var bitmap:Bitmap;
	private var animationFinish:Bool;
	private var timeElapsed:Int;
	private var pause:Bool;
	
	public function new(spritesheet:Spritesheet) {
		super();
		pause = false;
		animationFinish = false;
		timeElapsed = 0;
		currentFrameData = spritesheet.getDefaultFrameData();
		this.spritesheet = spritesheet;
		frameDataQueue = new Array<FrameData>();
		bitmap = new Bitmap ();
		addChild (bitmap);
	}
	
	public function changeFrameData(name:String) {
		var frameData = spritesheet.getFrameData(name);
		if (frameData != null) {
			currentFrameData = frameData;
			timeElapsed = 0;
			animationFinish = false;
		}
	}
	
	public function addToQueue(name:String) {
		var frameData = spritesheet.getFrameData(name);
		if (frameData != null) {
			frameDataQueue.push(frameData);
		}
	}
	
	public function update(delta:Int) {
		if (!animationFinish) {
			timeElapsed += delta;
			var loopTime = currentFrameData.getLoopTime();
			var ratio = timeElapsed / loopTime;
			if (ratio >= 1) {
				if (frameDataQueue.length == 0) {
					if (!currentFrameData.getLoop()) {
						animationFinish = true;
					}
				} else {
					currentFrameData = frameDataQueue.pop();
					timeElapsed = 0;
					ratio = 0;
				}
				timeElapsed = Std.int(timeElapsed - ratio * loopTime);
			}
			var indexInFrame = 0;
			if (ratio == 1) { 
				indexInFrame = currentFrameData.getLength() - 1;
			} else {
				var length = currentFrameData.getLength();
				var indexInTime = timeElapsed;
				indexInFrame = 0;
				for (i in 0...length) {
					if (currentFrameData.getSpeedStep(i) > indexInTime) {
						break;
					} else {
						indexInFrame += 1;
					}
				}
			}
			var frame = currentFrameData.getFrame(indexInFrame);
			bitmap.bitmapData = frame.bitmapData;
		}
	}
}