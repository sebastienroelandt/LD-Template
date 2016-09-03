package lib.sro.screen;
import openfl.display.Stage;

/**
 * ...
 * @author Sebastien roelandt
 */
class ScreenController
{
	public var debugLayer:lib.sro.layers.DebugLayer;

	private var stage:Stage;
	private var currentScreen:Screen;
	private var nextScreens:Array<Screen>;
	
	public function new() 
	{
		stage = null;
		currentScreen = null;
		nextScreens = new Array<Screen>();
	}
	
	public function init(stage:Stage):ScreenController {
		this.stage = stage;
		
		while (nextScreens.length > 0) {
			nextScreens.pop();
		}
		
		stage.addEventListener(Event.RESIZE, onStageResize);
		stage.addEventListener(KeyBoardEvent.KEY_DOWN, onKeyDown);
		
		return this;
	}
	
	///Screen Control
	
	public function addScreen(screen:Screen) {
		if (screen != null) {
			nextScreens.push(screen);
		}
	}
	
	public function nextScreen() {
		if (nextScreens.length > 0) {
			
		}
	}
	
	public function getCurrentScreen():Screen {
		return currentScreen;
	}
	
	///Event control
	private function onKeyAction(event:KeyboardEvent)
	{
		if (activeScreen == null)
			return;
			
		activeScreen.handleKeyAction(event);
	}
	
	private function onStageResize(e)
	{
		updateScreenSize();
	}
	
	public function updateScreenSize() {
		//To do
	}
	
}