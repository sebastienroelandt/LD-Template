package ld.ui.entity;

import lib.sro.core.Bresenham;
import lib.sro.data.StatedAnimationData;
import lib.sro.debug.ViusalPoint;
import lib.sro.effect.FollowRotationEffect;
import lib.sro.effect.FollowRotationTarget;
import lib.sro.effect.FollowRotationSource;
import lib.sro.entity.EntityWithInterraction;
import lib.sro.ui.BasicUI;
import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class Body extends EntityWithInterraction implements FollowRotationTarget implements FollowRotationSource
{
	var attachedTo 		: 	Body;
	var distanceMax		:	Int;
	var isInit 			: 	Bool;
	var strenght		:	Float;
	var visualPosition	:	Point; 
	var currentRotation	:	Float;
	
	var debugPoint		:	ViusalPoint;
	
	public function new(statedAnimationData:StatedAnimationData, ?attachedTo:Body = null, ?parent:BasicUI = null, 
		?deltaUp = 0, ?deltaDown = 0, ?deltaLeft = 0, ?deltaRight = 0) 
	{
		super(statedAnimationData, parent, deltaUp, deltaDown, deltaLeft, deltaRight);
		this.attachedTo = attachedTo;
		
		currentRotation = 90;
		
		if (attachedTo != null) {
			var previousCellPosition = attachedTo.getVisualPosition();
			var position = Bresenham.getPointInADirection(64, previousCellPosition, Math.abs(attachedTo.getRotation() - 90));
			setPosition(position.x - 32, position.y - 32);
			new FollowRotationEffect(this, attachedTo);
		} else {
			setPosition(200, 200);
		}
		setVisualPosition(getPosition());
		
		distanceMax = 34;
		isInit = false;
		strenght = 0.01;
		this.type = "Body";
		this.frictX = 0.2;
		this.frictY = 0.2;
		radius = 50;
		
		debugPoint = new ViusalPoint();
		debugPoint.x = 32;
		debugPoint.y = 32;
		this.add(debugPoint);
		
	}
	
	public function getPosition():Point {
		return new Point(xx, yy);
	}
	
	public function getCenter():Point {
		return new Point(32, 32);
	}
	
	public function getSprite():Sprite {
		return this;
	}
	
	public function getRotation():Float {
		return currentRotation;
	}
	
	public function setRotation(currentRotation:Float) {
		this.currentRotation = currentRotation;
	}
	
	public function setVisualPosition(visualPosition:Point) {
		this.visualPosition = visualPosition;
	}
	
	public function getVisualPosition():Point {
		return visualPosition;
	}
	
	override public function beforeUpdate(delta:Float) {
		super.beforeUpdate(delta);
		
		//Distance entre this et attachedTo
		if (attachedTo != null && isInit) {
			var deltaX = attachedTo.getVisualPosition().x - this.getVisualPosition().x;
			var deltaY = attachedTo.getVisualPosition().y - this.getVisualPosition().y;
			var distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
			if (distance > distanceMax) {
				//On doit rapprocher l'element
				var deltaDistance = Math.abs(distanceMax - distance);
				var mouvement = Bresenham.getMouvement(deltaDistance * strenght, this.getVisualPosition(), attachedTo.getVisualPosition());
				
				this.dx += mouvement.x; 
				this.dy += mouvement.y; 
			}
		}
		this.isInit = true;
		
		if (attachedTo != null) {
			var mapEntity = new Array();
			mapEntity.push(cast(attachedTo,EntityWithInterraction));
			updatePositionDueToInteraction(mapEntity);
		}
	}
	
	override public function afterUpdate(delta:Float) 
	{
		super.afterUpdate(delta);
	}
}