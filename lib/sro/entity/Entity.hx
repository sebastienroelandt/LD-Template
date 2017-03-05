package lib.sro.entity;

import lib.sro.ui.AnimatedSprite;
import lib.sro.engine.*;
import lib.sro.data.StatedAnimationData;
import lib.sro.ui.BasicUI;
import lib.sro.input.Keys;
import openfl.display.Bitmap;
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
 
class Entity extends AnimatedSprite implements IEntity
{
	//Behavior controller
	private var collisionManager		: ICollisionManager;
	private var interractionController 	: IInterractionController;
	
	///Direction
	public var direction				: EntityDirection;
	
	///Mouvement
	private var cx						: Int;
	private var cy						: Int;
	private var xr						: Float;
	private var yr						: Float;
	private var dx						: Float;
	private var dy						: Float;
	private var xx						: Float;
	private var yy						: Float;
		
	private var frictX					: Float;
	private var frictY					: Float;
	private var gravity					: Float;
	private var speed					: Float;
	private var force					: Float;
		
	private var type					: String;
	private var calculateWidth 			: Float;
	private var calculateHeight 		: Float;
	
	//Rotation
	private var visualPosition			: Point;
	
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
		
		if (collisionManager != null) {
			collisionManager.update(delta);
		}
		
		super.update(delta);

		xr+=dx;
		dx *= frictX;
		
		yr+=dy;
		dy *= frictY;
		
		afterUpdate(delta);
	}
	
	public function beforeUpdate(delta:Float) {
		if (collisionManager != null) {
			collisionManager.beforeUpdate(delta);
		}
	}
	
	public function afterUpdate(delta:Float) {
		if (collisionManager != null) {
			collisionManager.afterUpdate(delta);
		}
		
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
		if (collisionManager != null) {
			collisionManager.setXPosition(x);
		} else {
			xx = x;
			cx = Std.int(xx / calculateWidth);
			xr = (xx - cx * calculateWidth) / calculateWidth;
		}
	}
	
	private function setYPosition(y : Float) {
		if (collisionManager != null) {
			collisionManager.setYPosition(y);
		} else {
			yy = y;
			cy = Std.int(yy / calculateHeight);
			yr = (yy - cy * calculateHeight) / calculateHeight;
		}
	}
	
	private function updateEntityPosition() {
		if (collisionManager != null) {
			collisionManager.setPosition(x, y);
		} else {
			xx = Std.int((cx + xr) * calculateWidth);
			yy = Std.int((cy + yr) * calculateHeight);
			this.x = xx;
			this.y = yy;
		}
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

	/* Getter & Setter*/
	
	public function setCx(cx : Int) {
		this.cx = cx;
	}
	
	public function getCx(): Int {
		return cx;
	}
	
	public function setCy(cy : Int) {
		this.cy = cy;
	}
	
	public function getCy(): Int {
		return cy;
	}
	
	public function setXr(xr : Float) {
		this.xr = xr;
	}
	
	public function getXr(): Float {
		return xr;
	}
	
	public function setYr(yr : Float) {
		this.yr = yr;
	}
	
	public function getYr(): Float {
		return yr;
	}
	
	public function setDx(dx : Float) {
		this.dx = dx;
	}
	
	public function getDx(): Float {
		return dx;
	}
	
	public function setDy(dy : Float) {
		this.dy = dy;
	}
	
	public function getDy(): Float {
		return dy;
	}
	
	public function setXx(xx : Float) {
		this.xx = xx;
	}
	
	public function getXx(): Float {
		return xx;
	}
	
	public function setYy(yy : Float) {
		this.yy = yy;
	}
	
	public function getYy(): Float {
		return yy;
	}
	
	public function setFrictX(frictX : Float) {
		this.frictX = frictX;
	}
	
	public function getFrictX(): Float {
		return frictX;
	}
	
	public function set(frictY : Float) {
		this.frictY = frictY;
	}
	
	public function getFrictY(): Float {
		return frictY;
	}
	
	public function setGravity(gravity : Float) {
		this.gravity = gravity;
	}
	
	public function getGravity(): Float {
		return gravity;
	}
	
	public function setSpeed(speed : Float) {
		this.speed = speed;
	}
	
	public function getSpeed(): Float {
		return speed;
	}
	
	public function setForce(force : Float) {
		this.force = force;
	}
	
	public function getForce(): Float {
		return force;
	}
	
	public function setCalculateWidth(calculateHeight:Float ) {
		this.calculateHeight = calculateHeight;
	}
	
	public function getCalculateWidth() :Float {
		return calculateWidth;
	}
	
	public function setCalculateHeight(calculateHeight:Float ) {
		this.calculateHeight = calculateHeight;
	}
	
	public function getCalculateHeight() :Float {
		return calculateHeight;
	}

	public function setCollisionManager(collisionManager:ICollisionManager) {
		this.collisionManager = collisionManager;
	}
	
	public function getCollisionManager():ICollisionManager {
		return collisionManager;
	}
	
	public function setInterractionController(interractionController:IInterractionController) {
		this.interractionController = interractionController;
	}
	
	public function getInterractionController():IInterractionController {
		return interractionController;
	}
	
	public function getBitmap():Bitmap {
		return this.bitmap;
	}
}