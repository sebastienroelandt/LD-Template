package lib.sro.effect;

import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * @author Sebastien roelandt
 */
interface FollowRotationSource 
{
  	public function getPosition():Point;
	public function getCenter():Point;
	public function getSprite():Sprite;
	public function setRotation(rotation:Float):Void;
	public function getRotation():Float;
	public function setVisualPosition(position:Point):Void;
	public function getVisualPosition():Point;
}