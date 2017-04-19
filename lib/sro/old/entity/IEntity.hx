package lib.sro.entity;

import openfl.display.Bitmap;
import openfl.geom.Point;

/**
 * @author Sebastien roelandt
 */
interface IEntity 
{
	public function update(delta:Float):Void;
	public function beforeUpdate(delta:Float):Void;
	public function afterUpdate(delta:Float):Void;
	public function getPosition():Point;
	public function getType():String;
	public function getCenterPoint():Point;
	public function setVisualPosition(visualPosition:Point):Void;
	public function getVisualPosition():Point;
	public function getCenter():Point;
	
	//Getter & setter
	public function setCx(cx : Int):Void;
	public function getCx(): Int;
	public function setCy(cy : Int):Void;
	public function getCy(): Int;
	public function setXr(xr : Float):Void;
	public function getXr(): Float;
	public function setYr(yr : Float):Void;
	public function getYr(): Float;
	public function setDx(dx : Float):Void;
	public function getDx(): Float;
	public function setDy(dy : Float):Void;
	public function getDy(): Float;
	public function setXx(xx : Float):Void;
	public function getXx(): Float;
	public function setYy(yy : Float) :Void;
	public function getYy(): Float;
	public function setFrictX(frictX : Float):Void;
	public function getFrictX(): Float;
	public function set(frictY : Float):Void;
	public function getFrictY(): Float;
	public function setGravity(gravity : Float):Void;
	public function getGravity(): Float;
	public function setSpeed(speed : Float):Void;
	public function getSpeed(): Float;
	public function setForce(force : Float):Void;
	public function getForce(): Float;
	public function setCalculateWidth(calculateHeight:Float):Void;
	public function getCalculateWidth() :Float;
	public function setCalculateHeight(calculateHeight:Float ):Void;
	public function getCalculateHeight() :Float;
	public function setCollisionManager(collisionManager:ICollisionManager):Void;
	public function getCollisionManager():ICollisionManager;
	public function setInterractionController(interractionController:IInterractionController):Void;
	public function getInterractionController():IInterractionController;
	public function getBitmap():Bitmap;
	public function getBitmapWidth(): Float;
	public function getBitmapHeigth(): Float;
}