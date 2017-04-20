package lib.sro.ui.constraint;

import openfl.display.IBitmapDrawable;
import openfl.display.Sprite;

/**
 * @author Sebastien roelandt
 */
interface ISprite extends IBitmapDrawable
{
	public function getSprite():Sprite;
	public function getAlpha():Float ;
	public function setAlpha(alpha:Float):Void;
}