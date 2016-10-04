package lib.sro.core;

import lib.sro.screen.ScreenController;
import lib.sro.core.ResourcesStorage;
import lib.sro.input.*;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.events.Event;

/**
 * ...
 * @author Sebastien roelandt
 */
class GameController extends ScreenController
{
	public var assets:ResourcesStorage;

	public function new() 
	{
		super();
		
		Keys.init();
		Mouse.init();
	}
	
	public override function start():GameController {		
		super.start();
		
		this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		this.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		this.addEventListener(MouseEvent.MOUSE_UP, onMouseKeyUp);
		this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseKeyDown);
		this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		return this;
	}
	
	///Update control
	override public function update() 
	{
		super.update();
		Mouse.reset();
	}
	
	///Event control
	private function onKeyDown(event:KeyboardEvent) {
		Keys.setKeyDown(event);
	}
	
	private function onKeyUp(event:KeyboardEvent) {
		Keys.setKeyUp(event);
	}
	
	private function onMouseKeyDown(event:MouseEvent) {
		Mouse.onKeyDown(event);
	}
	
	private function onMouseKeyUp(event:MouseEvent) {
		Mouse.onKeyUp(event);
	}
	
	private function onMouseMove(event:MouseEvent) {
		Mouse.onMove(event);
	}
	
	private function onEnterFrame(e) {
		update();
	}
	
}