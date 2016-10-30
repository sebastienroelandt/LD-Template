package lib.sro.engine;

import lib.sro.engine.CollisionBox;

/**
 * @author Sebastien roelandt
 */
enum CollisionType {
	Box;
	Grid;
}
 
interface CollisionReader 
{
	public function pointHasCollision (x:Float, y:Float):Bool;
	public function boxHasCollision (box:CollisionBox):Bool;
	public function getHeigth():Float;
	public function getWidth():Float;
	public function getType():CollisionType;
}