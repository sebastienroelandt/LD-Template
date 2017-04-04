package lib.sro.engine;

import lib.sro.engine.CollisionInformation;
import lib.sro.engine.CollisionPolygon;
import openfl.geom.Point;
import lib.sro.entity.constraint.ICollisionableEntity;

/**
 * ...
 * @author Sebastien roelandt
 */
 
class CollisionUtils
{
	public static function boxCollision(entity:ICollisionableEntity, box:CollisionBox) : CollisionInformation {
		var information = new CollisionInformation();
		
		if (hasBoxCollision(box,entity)) {
			//Left, Rigth, Top or Down ?
			//Bottom
			var pxInBottom = Math.abs(box.getY() + box.getHeight() - entity.getYy() - entity.getDeltaDown());
			
			//Top
			var pxInTop = Math.abs(box.getY() - entity.getYy() - entity.getHeight() - entity.getDeltaUp());
			
			//Right 
			var pxInRight = Math.abs(box.getX() + box.getWidth() - entity.getXx() - entity.getDeltaRight());
			
			//Left
			var pxInLeft = Math.abs(box.getX() - entity.getXx() - entity.getWidth() - entity.getDeltaLeft());
					
			if (pxInRight <= 1  && pxInBottom <= 1) {
				// Coin bas-droit
			} else if (pxInLeft <= 1 && pxInBottom <= 1) {
				// Coin bas-gauche
			} else if (pxInRight <= 1 && pxInTop <= 1) {
				// Coin haut-droit
			} else if (pxInLeft <= 1 && pxInTop <= 1) {
				// Coin haut-gauche
			} else if (pxInBottom < pxInTop && pxInBottom < pxInRight && pxInBottom < pxInLeft) {
				// bas
				information.setIsDownCollision(true);
				information.setIsCollision(true);
				information.setCalculatedY(box.getY() + box.getHeight() - entity.getDeltaUp() + 0.1);
			} else if (pxInTop < pxInRight && pxInTop < pxInLeft) {
				// haut
				information.setIsUpCollision(true);
				information.setIsCollision(true);
				information.setCalculatedY(box.getY() - entity.getHeight() + entity.getDeltaDown() - 0.1);
			} else if (pxInRight < pxInLeft) {
				// droite
				information.setIsRightCollision(true);
				information.setIsCollision(true);
				information.setCalculatedX(box.getX() + box.getWidth() - entity.getDeltaLeft() + 0.1);
			} else {
				// gauche
				information.setIsLeftCollision(true);
				information.setIsCollision(true);
				information.setCalculatedX(box.getX() - entity.getWidth() + entity.getDeltaRight() - 0.1);
			}
		}
		return information;
	}
	
	private static function isPointInBox(box:CollisionBox, point:Point):Bool {
		return point.x > box.getX() 
			&& point.y > box.getY() 
			&& point.x <= box.getX() + box.getWidth() 
			&& point.y <= box.getY() + box.getHeight(); 
	}
	
	private static function isPointInEntity(entity:ICollisionableEntity, point:Point):Bool {
		return point.x > entity.getXx() + entity.getDeltaLeft() 
			&& point.y > entity.getYy() + entity.getDeltaUp() 
			&& point.x <= entity.getXx() + entity.getWidth() - entity.getDeltaLeft() - entity.getDeltaRight()
			&& point.y <= entity.getYy() + entity.getHeight() - entity.getDeltaUp() - entity.getDeltaDown(); 
	}

	private static function hasBoxCollision(box:CollisionBox, entity:ICollisionableEntity):Bool { 
		if (		isPointInBox(box, new Point(entity.getXx() + entity.getDeltaLeft()	, entity.getYy() + entity.getDeltaUp())) 
			|| 		isPointInBox(box, new Point(entity.getXx() + entity.getWidth() - entity.getDeltaRight()	, entity.getYy() + entity.getDeltaUp())) 
			|| 		isPointInBox(box, new Point(entity.getXx() + entity.getDeltaLeft()	, entity.getYy() + entity.getHeight() - entity.getDeltaDown())) 
			|| 		isPointInBox(box, new Point(entity.getXx() + entity.getWidth() - entity.getDeltaRight()	, entity.getYy() + entity.getHeight() - entity.getDeltaDown())))
		{
			return true;
		} else if ( isPointInEntity(entity, new Point(box.getX()						, box.getY()					)) 
			|| 		isPointInEntity(entity, new Point(box.getX() + box.getWidth()		, box.getY() 					)) 
			|| 		isPointInEntity(entity, new Point(box.getX() 						, box.getY() + box.getHeight()	)) 
			|| 		isPointInEntity(entity, new Point(box.getX() + box.getWidth()		, box.getY() + box.getHeight()	)))
		{
			return true;
		}
		return false;  
	}
	
	public static function polygonCollision(entity:ICollisionableEntity, polygon:CollisionPolygon) : CollisionInformation {
		return null;
	}
	
}