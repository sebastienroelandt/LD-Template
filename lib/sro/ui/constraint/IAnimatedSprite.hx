package lib.sro.ui.constraint;

/**
 * @author Sebastien roelandt
 */
interface IAnimatedSprite 
{
	public function change(name:String):Void;
	public function addToQueue(name:String):Void;
	public function update(delta:Float):Void;
	public function getBitmapHeigth():Float;
	public function getBitmapWidth():Float;
	public function getCurrentAnimationName():String;
}