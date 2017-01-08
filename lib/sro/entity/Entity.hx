package lib.sro.entity;

import lib.sro.ui.AnimatedSprite;
import lib.sro.engine.*;
import lib.sro.data.StatedAnimationData;
import lib.sro.ui.BasicUI;
import lib.sro.engine.CollisionReader;
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
		cx = Std.int(xx / 16);
		cy = Std.int(yy / 16);
		xr = (xx - cx * 16) / 16;
		yr = (yy - cy * 16) / 16;
	}
	
	private function setXPosition(x : Float) {
		xx = x;
		cx = Std.int(xx / 16);
		xr = (xx - cx * 16) / 16;
	}
	
	private function setYPosition(y : Float) {
		yy = y;
		cy = Std.int(yy / 16);
		yr = (yy - cy * 16) / 16;
	}
	
	private function updateEntityPosition() {
		xx = Std.int((cx + xr) * 16);
		yy = Std.int((cy + yr) * 16);
		this.x = xx;
		this.y = yy;
	}
	
	public function getType():String {
		return type;
	}
}