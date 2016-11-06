package ld.ui;
import lib.sro.ui.BasicUI;
import openfl.display.Sprite;
import lib.sro.input.Mouse;
import lib.sro.core.Bresenham;
import openfl.filters.GlowFilter;

/**
 * ...
 * @author Sebastien roelandt
 */
class DrawMyLine extends BasicUI
{
	private var cases			: Array<Sprite>;
	private var previousColor	: UInt;

	public function new() 
	{
		super();
		
		cases = new Array();
		previousColor = 0xFFFF00;
	}
	
	override public function update(delta:Float) 
	{
		var mouseX = Mouse.getXY().x;
		var mouseY = Mouse.getXY().y;
		
		var tileX = Std.int(mouseX / 8);
		var tileY = Std.int(mouseY / 8);
		
		/*
		var pts:Array<{x:Int, y:Int}> = Bresenham.getLine(24, 15, tileX, tileY);
		var colorBool:Bool = Bresenham.checkLine(24, 15, tileX, tileY, 
			[[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],
			[true,false,false,false,false,false,false,false,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,true,false,false,false,true,false,false,false,true,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,true,true,true,true,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,true,false,true,false,false,false,false,true,false,false,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,true,false,false,true,true,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,true,false,false,false,false,false,true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,true,false,false,true,false,false,false,false,true,false,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,true,false,false,true,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,true,false,false,true,false,false,true,false,true,false,false,true,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,true,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,true,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,true,true,false,true,true,false,true,true,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,true,false,true,false,false,false,true,false,false,false,false,true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
			[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]]);
		/*var color = colorBool ? 0x00FF00 : 0x0000FF;
		changeColor(color);*/
		
		//var pts:Array<{x:Int, y:Int}> = Bresenham.getLargeLine(12, 12, tileX, tileY);
		//var pts:Array<{x:Int, y:Int}> = Bresenham.getCircle(12, 12, 8);
		//var pts:Array<{x:Int, y:Int}> = Bresenham.getDisc(12, 12, 5);
		
		//Light
		var pts = [];
		var circlePts = Bresenham.getCircle(tileX, tileY, 12);
		for (i in 0...circlePts.length) {
			var tempPts:Array<{x:Int, y:Int}> = Bresenham.getLineBeforeCollision(tileX, tileY, circlePts[i].x, circlePts[i].y, 
				[[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true],
				[true,false,false,false,false,false,false,false,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,true,false,false,false,true,false,false,false,true,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,true,true,true,true,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,true,false,true,false,false,false,false,true,false,false,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,true,false,false,true,true,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,true,false,false,false,false,false,true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,true,false,false,true,false,false,false,false,true,false,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,true,false,false,true,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,true,false,false,true,false,false,true,false,true,false,false,true,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,true,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,true,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,true,true,false,true,true,false,true,true,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,true,false,true,false,false,false,true,false,false,false,false,true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true],
				[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]]);
			
			for (k in 0...tempPts.length) {
				var ok = true;
				for (j in 0...pts.length) {
					if (tempPts[k].x == pts[j].x 
						&& tempPts[k].y == pts[j].y) {
						ok = false;
						break;
					}
				}
				if (ok) {
					pts.push({x:tempPts[k].x, y:tempPts[k].y});
				}
			}
		}
		
		while (pts.length > cases.length) {
			addBlock();
		}
		
		for (i in 0...cases.length) {
			if (pts.length > i ) {
				var strengh = 1 / (1 + (Math.abs(tileX - pts[i].x) + Math.abs(tileY - pts[i].y)) / 5 ) / 1.3;
				
				var block:Sprite = cases[i];
				block.visible = true;
				block.alpha = strengh;
				block.x = pts[i].x * 8;
				block.y = pts[i].y * 8;
			} else {
				var block:Sprite = cases[i];
				block.visible = false;
			}
		}
	}
	
	private function addBlock()
	{
		var block = new Sprite(); 
			block.graphics.beginFill(previousColor, 1); 
			block.graphics.drawRect(0, 0, 8, 8); 
			block.graphics.endFill(); 
			this.addChild(block);
			cases.push(block);
	}
	
	private function changeColor(color:UInt)
	{
		if (color != previousColor) {
			while (cases.length != 0) {
				this.removeChild(cases[0]);
				cases.remove(cases[0]);
			}
		}
		previousColor = color;
		
	}
}