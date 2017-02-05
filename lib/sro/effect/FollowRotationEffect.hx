package lib.sro.effect;

import lib.sro.ui.BasicUI;
import lib.sro.core.Transformation;
import openfl.geom.Point;
import lib.sro.entity.Entity;
import lib.sro.core.Bresenham;

/**
 * ...
 * @author Sebastien roelandt
 */
class FollowRotationEffect extends Effect
{
	var lookAt				:	FollowRotationTarget;
	var rotationOn			:	FollowRotationSource;
	
	public function new(rotationOn:FollowRotationSource, lookAt: FollowRotationTarget) 
	{
		super(rotationOn.getSprite(), 10000);
		loop = true;
		this.lookAt = lookAt;
		this.rotationOn = rotationOn;
	}
	
	override public function update(value:Float, diff:Float) {
		rotationOn.setVisualPosition(rotationOn.getPosition());
		var rotation;
		if (lookAt != null) {
			rotation = getRotation();
		} else {
			rotation = rotationOn.getRotation();
		}
		Transformation.rotateDegree(rotationOn.getSprite(), 
			rotationOn.getCenter(), rotation, rotationOn.getPosition());
	}
	
	private function getRotation():Float {
		var center = new Point(rotationOn.getVisualPosition().x + rotationOn.getCenter().x,
			rotationOn.getVisualPosition().y + rotationOn.getCenter().y);
		var up = center.clone();
		up.y -= 20;
		var other = new Point(lookAt.getVisualPosition().x + lookAt.getCenter().x,
			lookAt.getVisualPosition().y + lookAt.getCenter().y);
		return Bresenham.getAngle(Std.int(center.x), Std.int(center.y), Std.int(up.x), Std.int(up.y), Std.int(other.x), Std.int(other.y));
	}
}