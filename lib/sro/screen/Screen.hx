package lib.sro.screen;
import openfl.display.Sprite;

/**
 * ...
 * @author Sebastien roelandt
 */
class Screen extends Sprite
{
	public var zoomLayer:lib.sro.layers.ZoomLayer;
	public var layers:Map<String, lib.sro.layers.DrawableLayer>;

	private var screenController:ScreenController;
	
	public function new(screenController:ScreenController) {
		this.screenController = screenController;
	}
	
	
	
}