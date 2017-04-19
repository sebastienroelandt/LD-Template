package lib.sro.entity;

import lib.sro.engine.CollisionBox;
import lib.sro.engine.CollisionListener;

/**
 * @author Sebastien roelandt
 */
interface ICollisionManager 
{
	public function beforeUpdate(delta:Float):Void;
	public function update(delta:Float):Void;
	public function afterUpdate(delta:Float):Void;
	
	public function setPosition(x : Float, y : Float):Void;
	public function setXPosition(x : Float):Void;
	public function setYPosition(y : Float):Void;
	
	public function checkBoxCollision():Void;
	public function checkGridCollision():Void;
	public function hasGridCollision(cx:Int, cy:Int):Void;
	public function hasBoxCollision():Array<CollisionBox>;
	public function setCollisionReader (collisionBox:CollisionBox):Void;
	public function addCollideTo(collisionReader:CollisionListener):Void;
	public function removeCollideTo(collisionReader:CollisionListener):Void;
	public function removeAllCollideTo():Void;
}