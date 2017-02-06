package lib.sro.entity;

import lib.sro.ui.AnimatedSprite;
import lib.sro.engine.*;
import lib.sro.data.StatedAnimationData;
import lib.sro.ui.BasicUI;
import lib.sro.input.Keys;
import openfl.geom.Point;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Sebastien roelandt
 */

enum EntityDirection {
	Left;
	Right;
	Up;
	Down;
}
 
class Entity extends AnimatedSprite
{
	///Direction
	public var direction			: EntityDirection;
	
	///Mouvement
	private var cx					: Int;
	private var cy					: Int;
	private var xr					: Float;
	private var yr					: Float;
	private var dx					: Float;
	private var dy					: Float;
	private var xx					: Float;
	private var yy					: Float;
	
	public var frictX				: Float;
	public var frictY				: Float;
	public var gravity				: Float;
	public var speed				: Float;
	public var force				: Float;
	
	private var type				: String;
	private var calculateWidth 		: Float;
	private var calculateHeight 	: Float;
	
	//Rotation
	private var visualPosition		: Point;
	
	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI = null, 
		?deltaUp = 0, ?deltaDown = 0, ?deltaLeft = 0, ?deltaRight = 0)
	{
		super(statedAnimationData, parent);
		
		frictX = 0.90;
		frictY = 0.94;
		gravity = 0.04;
		speed = 0.005;
		force = 1;
		type = "";
		
		cx = Std.int(x);
		cy = Std.int(y);
		xr = yr = 0;
		dx = dy = 0;
		
		direction = EntityDirection.Right;
		
		calculateWidth = (this.getBitmapWidth() - deltaRight + deltaLeft);
		calculateHeight = (this.getBitmapHeigth() - deltaDown + deltaUp);
	}
	
	public override function update(delta:Float) {
		beforeUpdate(delta);
		
		super.update(delta);

		xr+=dx;
		dx *= frictX;
		
		yr+=dy;
		dy *= frictY;
		
		afterUpdate(delta);
	}
	
	public function beforeUpdate(delta:Float) {
		
	}
	
	public function afterUpdate(delta:Float) {
		updateEntityPosition();
	}
	
	public function setPosition(x : Float, y : Float) {
		xx = x;
		yy = y;
		cx = Std.int(xx / calculateWidth);
		cy = Std.int(yy / calculateHeight);
		xr = (xx - cx * calculateWidth) / calculateWidth;
		yr = (yy - cy * calculateHeight) / calculateHeight;
	}
	
	public function getPosition():Point {
		return new Point(xx, yy);
	}
	
	private function setXPosition(x : Float) {
		xx = x;
		cx = Std.int(xx / calculateWidth);
		xr = (xx - cx * calculateWidth) / calculateWidth;
	}
	
	private function setYPosition(y : Float) {
		yy = y;
		cy = Std.int(yy / calculateHeight);
		yr = (yy - cy * calculateHeight) /calculateHeight;
	}
	
	private function updateEntityPosition() {
		xx = Std.int((cx + xr) * calculateWidth);
		yy = Std.int((cy + yr) * calculateHeight);
		this.x = xx;
		this.y = yy;
	}
	
	public function getType():String {
		return type;
	}
	
	public function getCenterPoint():Point {
		return new Point((calculateWidth / 2) + this.x, (calculateHeight / 2) + this.y);
	}
	
	public function setVisualPosition(visualPosition:Point) {
		this.visualPosition = visualPosition;
	}
	
	public function getVisualPosition():Point {
		if (visualPosition != null) {
			return visualPosition;
		}
		return new Point(x, y);
	}
	
	public function getCenter():Point {
		return new Point(calculateWidth / 2, calculateHeight / 2);
	}
}