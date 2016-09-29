package;

import ld.core.Manager;
import lib.sro.core.Bezier;
import lib.sro.ui.AnimatedSprite;
import lib.sro.effect.RotationEffect;
import lib.sro.effect.TransparencyEffect;
import lib.sro.effect.Effect;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author Sebastien roelandt
 */
class Main extends Sprite 
{
	var isInited:Bool = false;
	var animatedSprite: AnimatedSprite;
	var lastTime: Int;
	var bool:Bool;
	
	private function resize(e) 
	{
		if (!isInited) init(e);
	}
	
	public function init(e) 
	{
		if (isInited) return;
		isInited = true;
		lastTime = 0;
		//Init root
		Manager.init();
		animatedSprite = new AnimatedSprite(Manager.assets.getStatedAnimationData("fish"));
		animatedSprite.x = 100;
		animatedSprite.y = 100;
		addChild(animatedSprite);
		
		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		this.addEventListener(MouseEvent.CLICK, onClick);
	}
	
	public function onEnterFrame(e:Event) {
		
		var delta = Lib.getTimer() - lastTime;
		
		animatedSprite.update(delta);
		
		lastTime = Lib.getTimer();
	}
	
	public function onClick(e:Event) {
		animatedSprite.change("transform_right");
		animatedSprite.addToQueue("move_right");
		var e:Effect = new RotationEffect(animatedSprite, 1000, BezierType.Zigzag);
		new TransparencyEffect(animatedSprite, 1000, BezierType.In);
		e.setLoop(true);
	}
	
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init(e);
		#end
	}
	
	static function main()
	{
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}

}
