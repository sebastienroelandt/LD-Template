package lib.sro.entity.process.impl;

import lib.sro.engine.CollisionInformation;
import lib.sro.entity.constraint.ICollisionableEntity;
import lib.sro.entity.process.constraint.IProcess;
import lib.sro.entity.process.constraint.AbstractCollisionProcess;
import lib.sro.engine.CollisionUtils;
import lib.sro.engine.CollisionBox;

/**
 * ...
 * @author Sebastien roelandt
 */
class GridCollisionProcess extends AbstractCollisionProcess implements IProcess
{
	private var priority			: Int;
	
	private var tileHeight			: Int;
	private var tileWidth			: Int;
	private var collisionMap		: Array<Array<Bool>>;
	private var xTiles				: Int;
	private var yTiles				: Int;
	
	//collision calculation
	private var entityHeightInTile	: Int;
	private var entityWidthInTile	: Int;
	private var restHeight			: Float;
	private var restWidth 			: Float;
	
	//Entity position
	private var cx					: Int;
	private var cy					: Int;
	private var xr					: Float;
	private var yr					: Float;
	

	public function new(entity:ICollisionableEntity, tileHeight:Int, tileWidth:Int, 
		collisionMap:Array<Array<Bool>>, ?isBlocking = true) 
	{
		super(entity, isBlocking);
		
		this.priority = ProcessesOrder.GRID_COLLISION_PRIORITY;
		this.entity = entity;
		
		this.tileHeight = tileHeight;
		this.tileWidth = tileWidth;
		this.xTiles = collisionMap[0].length;
		this.yTiles = collisionMap.length;
		this.collisionMap = collisionMap;
		this.isBlocking = isBlocking;
		
		this.entityHeightInTile = Std.int((entity.getHeight() - entity.getDeltaUp() + entity.getDeltaDown()) / tileHeight);
		this.entityWidthInTile = Std.int((entity.getWidth() - entity.getDeltaLeft() + entity.getDeltaRight()) / tileWidth);

		this.restHeight = ((entity.getHeight() - entity.getDeltaUp() + entity.getDeltaDown()) % tileHeight) / tileHeight;
		this.restWidth = ((entity.getWidth() - entity.getDeltaLeft() + entity.getDeltaRight()) % tileWidth) / tileWidth;
	}
		
	private function isOnCollisionTile(x:Int, y:Int):Bool {
		var toReturn = false;
		if (xTiles > x && yTiles > y && y >= 0 && x >= 0) {
			toReturn = collisionMap[Std.int(y)][Std.int(x)];
		}
		return toReturn;
	}

	public function check() {
		for (i in (cx - 1)...(cx + entityWidthInTile + 2)) {
			//x
			for (j in (cy - 1)...(cy + entityHeightInTile + 2)) {
				//y
				if (isOnCollisionTile(i , j)) {
					var collisionInformation = getCollisionInformation(i , j);
					if (collisionInformation.getIsCollision()) {
						//Collision
						if (collisionInformation.getCalculatedX() != 0) {
							onCollision();
							entity.setDx(0);
							var x = convertAbsolutePositionToGridPosition(collisionInformation.getCalculatedX() + entity.getDeltaLeft(), tileWidth);
							cx = x.c;
							xr = x.r;
						}
						
						if (collisionInformation.getCalculatedY() != 0) {
							onCollision();
							entity.setDy(0);
							var y = convertAbsolutePositionToGridPosition(collisionInformation.getCalculatedY() + entity.getDeltaUp(), tileHeight);
							cy = y.c;
							yr = y.r;
						}
					}
				}
			}
		}
	}
	
	private function convertAbsolutePositionToGridPosition(p:Float, tileSize:Int): { c : Int , r : Float } {
		var c = Std.int(p / tileSize);
		var r = (p - c * tileSize) / tileSize;
		return { c:c, r:r };
	}
	
	private function getCollisionInformation(i : Int, j : Int) : CollisionInformation {
		return CollisionUtils.boxCollision(entity, new CollisionBox(i * tileWidth, j * tileHeight, tileWidth, tileHeight));
	}
	
	private function updateEntityPosition() {
		var newCx = cx;
		var newCy = cy;
		var newXr = xr;
		var newYr = yr;
		getPosition();
		
		entity.setXx(entity.getXx() + (newCx - cx + newXr - xr) * tileWidth);
		entity.setYy(entity.getYy() + (newCy - cy + newYr - yr) * tileWidth);
	}
	
	private function getPosition() {
		var x = convertAbsolutePositionToGridPosition(entity.getXx() + entity.getDeltaLeft(), tileWidth);
		cx = x.c;
		xr = x.r;
		var y = convertAbsolutePositionToGridPosition(entity.getYy() + entity.getDeltaUp(), tileHeight);
		cy = y.c;
		yr = y.r;
	}
	
	override public function getType():CollisionProcessType 
	{
		return CollisionProcessType.GRID;
	}
	
	public function beforeEntityUpdate(delta:Float):Void 
	{
		getPosition();
		check();
		updateEntityPosition();
	}
	
	public function afterEntityUpdate(delta:Float):Void 
	{
		
	}
	
	public function stop():Void 
	{
		
	}
	
	public function getPriority():Int 
	{
		return priority;
	}
	
	public function setPriority(priority:Int):Void 
	{
		this.priority = priority;
	}
	
}