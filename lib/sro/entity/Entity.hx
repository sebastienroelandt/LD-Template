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
	Right;
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
	
	///Direction
	public var direction			: EntityDirection;
	
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
		
		direction = EntityDirection.Right;
	}
	
	public override function update(delta:Float) {
		super.update(delta);
		
		if (Keys.isDown(Keyboard.UP)) {
			dy -= speed;
			direction = EntityDirection.Up;
		} 
		if (Keys.isDown(Keyboard.DOWN)) {
			dy += speed;
			direction = EntityDirection.Down;
		} 
		if (Keys.isDown(Keyboard.LEFT)) {
			dx -= speed;
			direction = EntityDirection.Left;
		}
		if (Keys.isDown(Keyboard.RIGHT)) {
			dx += speed;
			direction = EntityDirection.Right;
		}
		
		xr+=dx;
		dx *= frictX;
		
		yr+=dy;
		dy *= frictY;
		
		if (autoCollisionCheck) {
			checkBoxCollision();
			checkGridCollision();
		}
		
		updateEntityPosition();
	}
	
	public function setPosition(x : Float, y : Float) {
		xx = x + deltaLeft;
		yy = y + deltaUp;
		cx = Std.int(xx / 32);
		cy = Std.int(yy / 32);
		xr = (xx - cx * 32) / 32;
		yr = (yy - cy * 32) / 32;
	}
	
	private function setXPosition(x : Float) {
		xx = x + deltaLeft;
		cx = Std.int(xx / 32);
		xr = (xx - cx * 32) / 32;
	}
	
	private function setYPosition(y : Float) {
		yy = y + deltaUp;
		cy = Std.int(yy / 32);
		yr = (yy - cy * 32) / 32;
	}
	
	private function updateEntityPosition() {
		xx = Std.int((cx + xr) * 32);
		yy = Std.int((cy + yr) * 32);
		this.x = xx - deltaLeft;
		this.y = yy - deltaUp;
	}
	
	public function checkBoxCollision() {
		updateEntityPosition();
		
		var collisionBoxes = hasBoxCollision();
		for (c in collisionBoxes) {
			if (c != null) {
				//Left, Rigth, Top or Down ?
				//Bottom
				var pxInBottom = Math.abs(c.box.y + c.box.height - this.y - deltaUp);
				
				//Top
				var pxInTop = Math.abs(c.box.y - this.y - collisionBox.box.height - deltaUp);
				
				//Right 
				var pxInRight = Math.abs(c.box.x + c.box.width - this.x - deltaDown);
				
				//Left
				var pxInLeft = Math.abs(c.box.x - this.x - collisionBox.box.width - deltaDown);
				
				if (pxInBottom < pxInTop && pxInBottom < pxInRight && pxInBottom < pxInLeft) {
					//Bottom
					setYPosition(c.box.y + c.box.height - deltaUp + 0.8);
					dy = 0;
				} else if (pxInTop < pxInRight && pxInTop < pxInLeft) {
					//Top
					setYPosition(c.box.y - collisionBox.box.height - deltaUp - 0.8);
					dy = 0;
				} else if (pxInRight < pxInLeft) {
					//Right
					setXPosition(c.box.x + c.box.width - deltaLeft + 0.8);
					dx = 0;
				} else {
					//Left
					setXPosition(c.box.x - collisionBox.box.width - deltaLeft - 0.8);
					dx = 0;
				}
			} 		
		}
		
		updateEntityPosition();
	}
	
	public function checkGridCollision() {		

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
		
		// Up
		for (i in 0...(heigthInTile + 1)) {
			if (hasGridCollision(cx + i, cy - 1) && yr <= 0.0) {
				dy = 0;
				yr = 0;
			}
		}
		// Down
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
	}

	public function hasGridCollision(cx:Int, cy:Int):Bool{
		for (c in collideToGrid) {
			if (c.pointHasCollision(cx , cy)) {
				return true;
			}
		}
		return false;
	}
	
	public function hasBoxCollision():Array<CollisionBox> {
		var toReturn:Array<CollisionBox> = new Array();
		for (c in collideToBox) {
			if (c.boxHasCollision(collisionBox, this.x + deltaLeft, this.y + deltaUp)) {
				toReturn.push(cast(c, CollisionBox));
			}
		}
		return toReturn;
	}
	
	public function setCollisionReader (collisionBox:CollisionBox)
	{
		this.collisionBox = collisionBox;
	}

	public function addCollideTo(collisionReader:CollisionReader) 
	{
		if (CollisionType.Grid.equals(collisionReader.getType())) 
		{
			if(collideToGrid.length == 0 || (collideToGrid[0].getHeigth() == collisionReader.getHeigth()
				&& collideToGrid[0].getWidth() == collisionReader.getWidth())) 
			{
				if (collideToGrid.length == 0) {
					tileHeigth	= collisionReader.getHeigth();
					tileWidth	= collisionReader.getWidth();	
					heigthInTile = Std.int(collisionBox.getHeigth() / tileHeigth);
					widthInTile = Std.int(collisionBox.getWidth() / tileWidth);
					restHeigth = (collisionBox.getHeigth() % tileHeigth) / tileHeigth;
					restWidth = (collisionBox.getWidth() % tileWidth) / tileWidth;
				}
				collideToGrid.push(collisionReader);
			}
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