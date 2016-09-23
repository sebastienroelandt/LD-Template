package lib.sro.ui;

import lib.sro.layers.DrawableLayer;
import lib.sro.data.StatedAnimationData;
import lib.sro.data.AnimationData;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author Sebastien roelandt
 */
class AnimatedSprite extends Sprite
{
	private var statedAnimationData:StatedAnimationData;
	private var currentAnimationData:AnimationData;
	private var animationDataQueue:Array<AnimationData>;
	private var bitmap:Bitmap;
	private var animationFinish:Bool;
	private var timeElapsed:Int;
	private var pause:Bool;
	
	public function new(statedAnimationData:StatedAnimationData) {
		super();
		pause = false;
		animationFinish = false;
		timeElapsed = 0;
		currentAnimationData = statedAnimationData.getDefaultAnimationData();
		this.statedAnimationData = statedAnimationData;
		animationDataQueue = new Array<AnimationData>();
		bitmap = new Bitmap ();
		addChild (bitmap);
	}
	
	public function change(name:String) {
		var animationData = statedAnimationData.getAnimationData(name);
		if (animationData != null) {
			currentAnimationData = animationData;
			timeElapsed = 0;
			animationFinish = false;
		}
	}
	
	public function addToQueue(name:String) {
		var animationData = statedAnimationData.getAnimationData(name);
		if (animationData != null) {
			animationDataQueue.push(animationData);
		}
	}
	
	public function update(delta:Int) {
		if (!animationFinish) {
			timeElapsed += delta;
			var loopTime = currentAnimationData.getLoopTime();
			var ratio = timeElapsed / loopTime;
			if (ratio >= 1) {
				if (animationDataQueue.length == 0) {
					if (!currentAnimationData.getLoop()) {
						animationFinish = true;
					}
				} else {
					currentAnimationData = animationDataQueue.pop();
					timeElapsed = 0;
					ratio = 0;
				}
				timeElapsed = Std.int(timeElapsed - ratio * loopTime);
			}
			var indexInFrame = 0;
			if (ratio == 1) { 
				indexInFrame = currentAnimationData.getLength() - 1;
			} else {
				var length = currentAnimationData.getLength();
				var indexInTime = timeElapsed;
				indexInFrame = 0;
				for (i in 0...length) {
					if (currentAnimationData.getSpeedStep(i) > indexInTime) {
						break;
					} else {
						indexInFrame += 1;
					}
				}
			}
			var frame = currentAnimationData.getFrame(indexInFrame);
			bitmap.bitmapData = frame.bitmapData;
		}
	}
}