package lib.sro.entity;

import lib.sro.engine.CollisionListener;
import lib.sro.engine.CollisionBox;

/**
 * ...
 * @author Sebastien roelandt
 */
class CollisionManager implements ICollisionManager
{
	private var entity				: IEntity;
	
	private var collideToGrid		: Array<CollisionListener>;
	private var collideToBox		: Array<CollisionListener>;

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
	
	public function new(entity:IEntity, ?deltaUp = 0, ?deltaDown = 0, ?deltaLeft = 0, ?deltaRight = 0) 
	{
		this.entity = entity;
		
		collideToGrid = new Array();
		collideToBox = new Array();
		
		this.deltaUp = deltaUp;
		this.deltaDown = deltaDown;
		this.deltaLeft = deltaLeft;
		this.deltaRight = deltaRight;
		this.autoCollisionCheck = true;
		this.tileWidth = 16;
		this.tileHeigth = 16;
		
		collisionBox = new CollisionBox(x + deltaLeft, y + deltaUp, 
				x +  this.getBitmapWidth() - deltaRight, y  + this.getBitmapHeigth() - deltaDown);
		entity.add(collisionBox);
	}
	
	public function beforeUpdate(delta:Float):Void {}
	public function update(delta:Float):Void {}
	
	public function afterUpdate(delta:Float) 
	{
		if (autoCollisionCheck) {
			checkBoxCollision();
			checkGridCollision();
		}
	}
	
	public function setPosition(x : Float, y : Float) {
		setXPosition(x);
		setYPosition(y);
	}
	
	public function setXPosition(x : Float) {
		entity.xx = x + deltaLeft;
		entity.cx = Std.int(entity.xx / tileWidth);
		entity.xr = (entity.xx - entity.cx * tileWidth) / tileWidth;
	}
	
	public function setYPosition(y : Float) {
		entity.yy = y + deltaUp;
		entity.cy = Std.int(entity.yy / tileHeigth);
		entity.yr = (entity.yy - entity.cy * tileHeigth) / tileHeigth;
	}
	
	private function updateEntityPosition() {
		entity.xx = Std.int((entity.cx + entity.xr) * tileWidth);
		entity.yy = Std.int((entity.cy + entity.yr) * tileHeigth);
		entity.x = entity.xx - deltaLeft;
		entity.y = entity.yy - deltaUp;
	}
	
	public function checkBoxCollision() {
		entity.updateEntityPosition();
		
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
				
				if (pxInRight <= 1  && pxInBottom <= 1) {
					// Coin bas-droit
				} else if (pxInLeft <= 1  && pxInBottom <= 1) {
					// Coin bas-gauche
				} else if (pxInRight <= 1  && pxInTop <= 1) {
					// Coin haut-droit
				} else if (pxInLeft <= 1 && pxInTop <= 1) {
					// Coin haut-gauche
				} else if (pxInBottom < pxInTop && pxInBottom < pxInRight && pxInBottom < pxInLeft) {
					// bas
					entity.setYPosition(c.box.y + c.box.height - deltaUp + 0.8);
					dy = 0;
				} else if (pxInTop < pxInRight && pxInTop < pxInLeft) {
					// haut
					entity.setYPosition(c.box.y - collisionBox.box.height - deltaUp - 0.8);
					entity.dy = 0;
				} else if (pxInRight < pxInLeft) {
					// droite
					entity.setXPosition(c.box.x + c.box.width - deltaLeft + 0.8);
					entity.dx = 0;
				} else {
					// gauche
					entity.setXPosition(c.box.x - collisionBox.box.width - deltaLeft - 0.8);
					entity.dx = 0;
				}
			} 		
		}
		
		entity.updateEntityPosition();
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
			if (hasGridCollision(cx + i, cy + 1 + heigthInTile) && yr > 1 - restHeigth) {
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

	public function addCollideTo(collisionReader:CollisionListener) 
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
	
	public function removeCollideTo(collisionReader:CollisionListener) 
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