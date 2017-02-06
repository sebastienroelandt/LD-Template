package ld.ui.entity;

import lib.sro.data.StatedAnimationData;
import lib.sro.entity.Entity;
import lib.sro.entity.EntityWithInterraction;
import lib.sro.ui.BasicUI;
import lib.sro.input.Mouse;
import lib.sro.core.Bresenham;
import lib.sro.effect.FollowRotationEffect;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class Head extends Body
{
	
	public function new(player:Player, statedAnimationData:StatedAnimationData, ?attachedTo:Body = null, ?parent:BasicUI = null, 
		?deltaUp = 0, ?deltaDown = 0, ?deltaLeft = 0, ?deltaRight = 0) 
	{
		super(player, statedAnimationData, attachedTo, parent, deltaUp, deltaDown, deltaLeft, deltaRight);
		
		if (attachedTo == null) {
			new FollowRotationEffect(this, null);
		}
		this.type = "Head";
	}
	
	override public function beforeUpdate(delta:Float) {
		super.beforeUpdate(delta);
		
		var previousPos = getPosition();
		var mousePos = new Point(200, 200);//Mouse.getXY();
		var pos = new Point(mousePos.x - 32, mousePos.y - 32);
		
		setPosition(pos.x, pos.y);
		setVisualPosition(getPosition());
		
		var deltaX = previousPos.x - pos.x;
		var deltaY = previousPos.y - pos.y;
		if (Math.abs(deltaX) >= 0.2 && Math.abs(deltaY) >= 0.2) {
			var newRotation = Bresenham.getAngle(Std.int(previousPos.x), Std.int(previousPos.y), 
				Std.int(previousPos.x), Std.int(previousPos.y - 20), Std.int(pos.x), Std.int(pos.y));
			if (newRotation >= -180 && newRotation <= 180) {
				currentRotation = newRotation;
			}			
		}
	}
	
}