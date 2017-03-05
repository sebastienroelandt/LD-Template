package ld.ui.entity;

import lib.sro.core.Bresenham;
import lib.sro.data.StatedAnimationData;
import lib.sro.debug.ViusalPoint;
import lib.sro.effect.FollowRotationEffect;
import lib.sro.effect.FollowRotationTarget;
import lib.sro.effect.FollowRotationSource;
import lib.sro.entity.InterractionController;
import lib.sro.entity.IEntity;
import lib.sro.entity.Entity;
import lib.sro.ui.BasicUI;
import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
class Body extends Entity implements FollowRotationTarget implements FollowRotationSource
{
	var player			:	Player;
	
	var attachedTo 		: 	Body;
	var distanceMax		:	Int;
	var isInit 			: 	Bool;
	var strenght		:	Float;
	var currentRotation	:	Float;
	
	var debugPoint		:	ViusalPoint;
	
	public function new(player:Player, statedAnimationData:StatedAnimationData, ?attachedTo:Body = null, ?parent:BasicUI = null, 
		?deltaUp = 0, ?deltaDown = 0, ?deltaLeft = 0, ?deltaRight = 0) 
	{
		super(statedAnimationData, parent, deltaUp, deltaDown, deltaLeft, deltaRight);
		
		this.interractionController = new InterractionController(this, 22, 0.05);
		
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
				
		distanceMax = 64;
		isInit = false;
		strenght = 0.005;
		this.type = "Body";
		this.frictX = 0.2;
		this.frictY = 0.2;
				
		debugPoint = new ViusalPoint();
		debugPoint.x = 32;
		debugPoint.y = 32;
		this.add(debugPoint);
		
		this.player = player;
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
			/*
			var mapEntity = new Array();
			mapEntity.push(cast(attachedTo,EntityWithInterraction));
			updatePositionDueToInteraction(mapEntity);*/
			var mapEntity = new Array();
			if (player != null) {
				for (c in player.getCells()) {
					mapEntity.push(cast(c, IEntity));
				}
			}
			interractionController.updatePositionDueToInteraction(mapEntity);
			
		}
	}
	
	public function setPlayer(player:Player )
	{
		this.player = player;
	}
	
	override public function afterUpdate(delta:Float) 
	{
		super.afterUpdate(delta);
	}
}