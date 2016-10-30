package lib.sro.entity;

import lib.sro.ui.AnimatedSprite;
import lib.sro.engine.*;
import lib.sro.data.StatedAnimationData;
import lib.sro.ui.BasicUI;
import lib.sro.engine.CollisionReader;
import lib.sro.input.Keys;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Sebastien roelandt
 */

enum EntityDirection {
	Left;
	Rigth;
	Up;
	Down;
}
 
class Entity extends AnimatedSprite
{
	private var collideToGrid		: Array<CollisionReader>;
	private var collideToBox		: Array<CollisionReader>;
	
	///Mouvement
	private var cx					: Int;
	private var cy					: Int;
	private var xr					: Float;
	private var yr					: Float;
	private var dx					: Float;
	private var dy					: Float;
	private var xx					: Float;
	private var yy					: Float;
	
	//Collision box
	private var collisionBox		: CollisionBox;
	private var deltaUp 			: Int;
	private var deltaDown 			: Int;
	private var deltaLeft 			: Int;
	private var deltaRight 			: Int;
	private var widthInTile			: Int;
	private var heigthInTile		: Int;
	private var restWidth			: Float;
	private var restHeigth			: Float;
	
	private var tileHeigth			: Float;
	private var tileWidth			: Float;
	
	public var autoCollisionCheck 	: Bool;
	public var frictX				: Float;
	public var frictY				: Float;
	public var gravity				: Float;
	public var speed				: Float;
	
	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI = null, 
		?deltaUp = 0, ?deltaDown = 0, ?deltaLeft = 0, ?deltaRight = 0)
	{
		super(statedAnimationData, parent);
		
		collideToGrid = new Array();
		collideToBox = new Array();
		
		this.deltaUp = deltaUp;
		this.deltaDown = deltaDown;
		this.deltaLeft = deltaLeft;
		this.deltaRight = deltaRight;
		
		collisionBox = new CollisionBox(x + deltaLeft, y + deltaUp, 
			x +  this.getBitmapWidth() - deltaRight, y  + this.getBitmapHeigth() - deltaDown);
		
		add(collisionBox);
		
		autoCollisionCheck = true;
		frictX = 0.90;
		frictY = 0.94;
		gravity = 0.04;
		speed = 0.01;
		
		cx = Std.int(x);
		cy = Std.int(y);
		xr = yr = 0;
		dx = dy = 0;
		
		setPosition(200, 200);
	}
	
	public override function update(delta:Float) {
		super.update(delta);
		
		if (Keys.isDown(Keyboard.LEFT)) {
			dx -= speed;
		}
		if (Keys.isDown(Keyboard.RIGHT)) {
			dx += speed;
		}
		if (Keys.isDown(Keyboard.UP)) {
			dy -= speed;
		} 
		if (Keys.isDown(Keyboard.DOWN)) {
			dy += speed;
		} 
		
		if (autoCollisionCheck) {
			checkCollision();
		}
	}
	
	public function setPosition(x,y) {
		xx = x + deltaLeft;
		yy = y + deltaUp;
		cx = Std.int(xx / 32);
		cy = Std.int(yy / 32);
		xr = (xx - cx * 32) / 32;
		yr = (yy - cy * 32) / 32;
	}
	
	public function checkCollision() {		
		// X component
		xr+=dx;
		dx *= frictX;
		//Left
		for (i in 0...(heigthInTile + 1)) {
			if (hasGridCollision(cx - 1, cy + i)  && xr <= 0.0) {
				dx = 0;
				xr = 0;
			}
		}
		//Rigth
		for (i in 0...(heigthInTile + 1)) {
			if (hasGridCollision(cx + 1 + widthInTile, cy + i) && xr >= 1 - restWidth) {
				dx = 0;
				xr = 1 - restWidth;
			}
		}
		while (xr < 0) {
			cx--;
			xr++;
		}
		while (xr > 1) {
			cx++;
			xr--;
		}
		
		// Y component
		//dy+=gravity;
		yr+=dy;
		dy *= frictY;
		for (i in 0...(heigthInTile + 1)) {
			if (hasGridCollision(cx + i, cy - 1) && yr <= 0.0) {
				dy = 0;
				yr = 0;
			}
		}
		//if ((hasCollision(cx, cy + 1) || hasCollision(cx + 1, cy + 1) && xr >= 0.7 || hasCollision(cx - 1, cy + 1) && xr <= 0.1) && yr >= 0 ) {
		for (i in 0...(widthInTile + 1)) {
			if (hasGridCollision(cx + i, cy + 1 + heigthInTile) && yr >= 1 - restHeigth) {
				dy = 0;
				yr = 1 - restHeigth;
			}
		}
		while ( yr < 0 ) {
			cy--;
			yr++;
		}
		while ( yr > 1 ) {
			cy++;
			yr--;
		}
			
		xx = Std.int((cx + xr) * 32);
		yy = Std.int((cy + yr) * 32);
		this.x = xx - deltaLeft;
		this.y = yy - deltaUp;
	}

	public function hasGridCollision(cx:Int, cy:Int):Bool{
		for (c in collideToGrid) {
			if (c.pointHasCollision(cx , cy)) {
				return true;
			}
		}
		return false;
	}
	
	public function hasBoxCollision():Bool {
		//TODO
		return false;
	}
	
	public function setCollisionReader (collisionBox:CollisionBox)
	{
		this.collisionBox = collisionBox;
	}

	public function addCollideTo(collisionReader:CollisionReader) 
	{
		if (CollisionType.Box.equals(collisionReader.getType())
			|| collideToGrid.length == 0 
			|| (collideToGrid[0].getHeigth() == collisionReader.getHeigth()
				&& collideToGrid[0].getWidth() == collisionReader.getWidth())) {
			if (collideToGrid.length == 0) {
				tileHeigth	= collisionReader.getHeigth();
				tileWidth	= collisionReader.getWidth();	
				heigthInTile = Std.int(collisionBox.getHeigth() / tileHeigth);
				widthInTile = Std.int(collisionBox.getWidth() / tileWidth);
				restHeigth = (collisionBox.getHeigth() % tileHeigth) / tileHeigth;
				restWidth = (collisionBox.getWidth() % tileWidth) / tileWidth;
			}
			collideToGrid.push(collisionReader);
		} else {
			collideToBox.push(collisionReader);
		}
	}
	
	public function removeCollideTo(collisionReader:CollisionReader) 
	{
		collideToGrid.remove(collisionReader);
		collideToBox.remove(collisionReader);
	}
	
	public function removeAllCollideTo() 
	{
		collideToGrid = new Array();
		collideToBox = new Array();
	}
}