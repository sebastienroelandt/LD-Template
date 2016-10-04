package lib.sro.layers;

import openfl.geom.Point;
import openfl.text.TextField;
import lib.sro.core.Text;
import lib.sro.screen.ScreenController;
import lib.sro.core.GameController;
import lib.sro.input.Mouse;
import lib.sro.input.Keys;
import lib.sro.DefaultConstant;
import openfl.Lib;
import openfl.geom.Point;
import openfl.ui.Keyboard;
import lib.sro.ui.AnimatedSprite;

/**
 * ...
 * @author Sebastien roelandt
 */
class DebugLayer extends DrawableLayer
{
	var topLeftText:TextField;
	var isDisplay:Bool;
	var lastTimer:Float;
	var animatedSprite:AnimatedSprite;
	
	public function new() 
	{
		super();
		
		topLeftText = Text.createText();
		topLeftText.width = 500;
		
		isDisplay = true;
		
		this.addChild(topLeftText);
	}
	
	public override function update(delta:Float) {	
		if (Keys.isClick(Keyboard.F1)) {
			isDisplay = !isDisplay;
		}

		if (isDisplay) {
			var output:String = "";
			var currentStage = Lib.current.stage;
			output += "SIZE		: " + currentStage.stageWidth + "x" + currentStage.stageHeight + "\n";
			
			var screenController = ScreenController.ME;
			var time = Lib.getTimer();
			var diff = currentStage.frameRate / (time - lastTimer) * 1000;
			output += "FPS   	: " + Math.round(diff * 10 / 10) + " 	/ " + currentStage.frameRate + "\n";
			
			output += "VERSION 	: LIB - v" + DefaultConstant.LIBVERSION + " || GAME - v" + DefaultConstant.GAMEVERSION + "\n";
			
			var point:Point = Mouse.getXY() ;
			output += "MOUSE 	: X-" + point.x + " || Y-" + point.x + " || " + Mouse.isClick() + "\n";
			
			output += "KEY 		: DOWN	- " + Keys.downCodes.toString() + "\n";
			output += "    		  CLICK	- " + Keys.click.toString();
			
			
			topLeftText.text = output;
			topLeftText.visible = true;
			lastTimer = time;
		} else {
			topLeftText.visible = false;
		}
	}

}