package lib.sro.engine;

import lib.sro.engine.CollisionBox;

/**
 * @author Sebastien roelandt
 */
interface CollisionReader 
{
	public function pointHasCollision (x:Float, y:Float):Bool;
	public function boxHasCollision (box:CollisionBox):Bool;
	
}