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
	private var interractionRadius		: Float;
	private var interractionStrenght	: Float;

	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI = null, 
		?deltaUp = 0, ?deltaDown = 0, ?deltaLeft = 0, ?deltaRight = 0) 
	{
		super(statedAnimationData, parent, 
				deltaUp, deltaDown, deltaLeft, deltaRight);
				
		interractionRadius = this.getBitmapWidth() / 2;
		
		interractionStrenght = 0.05;
	}
	
	public function updatePositionDueToInteraction(allEntity:Array<EntityWithInterraction>) {
		for ( e in allEntity ) {		
			// Fast distance check
			if( e!=this && Math.abs(cx-e.cx) <= 10 && Math.abs(cy-e.cy) <= 10 ) {
				var myx = this.getVisualPosition().x + this.calculateWidth;
				var myy = this.getVisualPosition().y + this.calculateHeight;
				var ex = e.getVisualPosition().x + this.calculateWidth;
				var ey = e.getVisualPosition().y + this.calculateHeight;
				
				// Real distance check
				var dist = Math.sqrt( (ex-myx)*(ex-myx) + (ey-myy)*(ey-myy) );
				if( dist <= interractionRadius+e.interractionRadius ) {
					var ang = Math.atan2(ey-myy, ex-myx);
					var force = interractionStrenght;
					var repelPower = (interractionRadius+e.interractionRadius - dist) / (interractionRadius+e.interractionRadius);
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