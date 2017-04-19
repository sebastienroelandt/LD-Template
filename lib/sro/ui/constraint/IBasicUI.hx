package lib.sro.ui.constraint;
import openfl.display.DisplayObject;

/**
 * @author Sebastien roelandt
 */
interface IBasicUI 
{
	public function add(child:IBasicUI):Void;
	public function remove(child:IBasicUI):Void;
	public function removeAll():Void;
	public function updateAll(delta:Float):Void;
	public function update(delta:Float):Void;
	public function setPause(pause:Bool):Void;
	public function getDisplayObject():DisplayObject;
}