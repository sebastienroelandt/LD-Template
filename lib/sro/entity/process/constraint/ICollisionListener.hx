package lib.sro.entity.process.constraint;

import lib.sro.entity.constraint.ICollisionableEntity;

/**
 * @author Sebastien roelandt
 */
interface ICollisionListener 
{
	public function onCollision(entity:ICollisionableEntity, isBlocking:Bool, process:AbstractCollisionProcess):Void;
}