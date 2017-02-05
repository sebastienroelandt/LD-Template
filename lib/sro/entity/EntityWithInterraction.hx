package lib.sro.entity;

import lib.sro.data.StatedAnimationData;
import lib.sro.ui.BasicUI;

/**
 * Entity with collision and interraction with others EntityWithInterraction
 * 
 * @author Sebastien roelandt
 */
class EntityWithInterraction extends EntityWithCollision
{
	private var radius				: Float;

	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI = null, 
		?deltaUp = 0, ?deltaDown = 0, ?deltaLeft = 0, ?deltaRight = 0) 
	{
		super(statedAnimationData, parent, 
				deltaUp, deltaDown, deltaLeft, deltaRight);
				
		radius = this.getBitmapWidth() / 2;
	}
	
	public function updatePositionDueToInteraction(allEntity:Array<EntityWithInterraction>) {
		for ( e in allEntity ) {		
			// Fast distance check
			if( e!=this && Math.abs(cx-e.cx) <= 10 && Math.abs(cy-e.cy) <= 10 ) {
				var myx = getCenterPoint().x;
				var myy = getCenterPoint().y;
				var ex = e.getCenterPoint().x;
				var ey = e.getCenterPoint().y;
				
				// Real distance check
				var dist = Math.sqrt( (ex-myx)*(ex-myx) + (ey-myy)*(ey-myy) );
				if( dist <= radius+e.radius ) {
					var ang = Math.atan2(ey-myy, ex-myx);
					var force = 0.05;
					var repelPower = (radius+e.radius - dist) / (radius+e.radius);
					dx -= Math.cos(ang) * repelPower * force;
					dy -= Math.sin(ang) * repelPower * force;
					e.dx += Math.cos(ang) * repelPower * e.force;
					e.dy += Math.sin(ang) * repelPower * e.force;
					this.onInteraction(e);
					e.onInteraction(this);
				}
			}
		}
	}
	
	public function onInteraction(with:Entity) {
		//interraction with other entity
	}
}