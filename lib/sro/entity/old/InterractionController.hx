package lib.sro.entity;

import lib.sro.data.StatedAnimationData;
import lib.sro.ui.impl.BasicUI;

/**
 * Entity with collision and interraction with others EntityWithInterraction
 * 
 * @author Sebastien roelandt
 */
class InterractionController implements IInterractionController
{
	private var entity 					: IEntity;
	
	private var interractionRadius		: Float;
	private var interractionStrenght	: Float;

	public function new(entity:IEntity, ?interractionRadius = -1, ?interractionStrenght = 0.05) 
	{
		this.entity = entity;
		this.interractionRadius = interractionRadius < 0 ? entity.getBitmapWidth() / 2 : interractionRadius;
		this.interractionStrenght = interractionStrenght;
	}
	
	public function updatePositionDueToInteraction(allEntity:Array<IEntity>) {
		for ( e in allEntity ) {		
			// Fast distance check
			if( e!=entity && Math.abs(entity.getCx()-e.getCx()) <= 10 && Math.abs(entity.getCy()-e.getCy()) <= 10 ) {
				var myx = entity.getVisualPosition().x + entity.getCalculateWidth();
				var myy = entity.getVisualPosition().y + entity.getCalculateHeight();
				var ex = e.getVisualPosition().x + entity.getCalculateWidth();
				var ey = e.getVisualPosition().y + entity.getCalculateHeight();
				
				// Real distance check
				var dist = Math.sqrt( (ex-myx)*(ex-myx) + (ey-myy)*(ey-myy) );
				if( dist <= getEntityRadius(entity) + getEntityRadius(e) ) {
					var ang = Math.atan2(ey-myy, ex-myx);
					var force = interractionStrenght;
					var repelPower = (getEntityRadius(entity)+getEntityRadius(e) - dist) / (getEntityRadius(entity)+getEntityRadius(e));
					
					entity.setDx(entity.getDx() - Math.cos(ang) * repelPower * force);
					entity.setDy(entity.getDy() - Math.sin(ang) * repelPower * force);
					
					e.setDx(e.getDx() + Math.cos(ang) * repelPower * e.getForce());
					e.setDy(e.getDy() + Math.sin(ang) * repelPower * e.getForce());
					
					var otherInteractionController = entity.getInterractionController();
					if (otherInteractionController != null) {
						otherInteractionController.onInteraction(entity);
					}
					onInteraction(e);
				}
			}
		}
	}
	
	private function getEntityRadius(entity:IEntity) :Float {
		var radius : Float;
		var interactionController = entity.getInterractionController();
		
		if (interactionController != null) {
			radius = interactionController.getInterractionRadius();
		} else {
			radius = entity.getBitmapWidth() / 2;
		}
		
		return radius;
	}
	
	public function onInteraction(with:IEntity) {
		//interraction with other entity
	}
	
	/* Getter & Setter */
	
	public function getInterractionRadius():Float 
	{
		return this.interractionRadius;
	}
	
	public function setInterractionRadius(interractionRadius:Float):Void 
	{
		this.interractionRadius = interractionRadius;
	}
	
	public function getInterractionStrenght():Float 
	{
		return this.interractionStrenght;
	}
	
	public function setInterractionStrenght(interractionRadius:Float):Void 
	{
		this.interractionStrenght = interractionRadius;
	}
}