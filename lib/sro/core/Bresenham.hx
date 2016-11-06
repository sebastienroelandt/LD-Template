package lib.sro.core;

/**
 * ...
 * @author Sebastien roelandt
 */
class Bresenham
{
	/// Utils
	private static inline function fastAbs(v:Int) : Int {
		return (v ^ (v >> 31)) - (v >> 31);
	}
 
	private static inline function fastFloor(v:Float) : Int {
		return Std.int(v); // actually it's more "truncate" than "round to 0"
	}
	
	public static function concat(pts1:Array<{x:Int, y:Int}>, pts2:Array<{x:Int, y:Int}>) {
		for (i in 0...pts2.length) {
			pts1.push(pts2[i]);
		}
	}
	
	public static function concatWithoutDouble(pts1:Array<{x:Int, y:Int}>, pts2:Array<{x:Int, y:Int}>) {
		for (i in 0...pts2.length) {
			var isOk = true;
			for (j in 0...pts1.length) {
				if (pts2[i].x == pts1[j].x 
					&& pts2[i].y == pts1[j].y) {
					isOk = false;
					break;
				}
			}
			if (isOk) {
				pts1.push({x:pts2[i].x, y:pts2[i].y});
			}
			
		}
	}
	
	///Get
	public static function getHorizontalLine(x1:Int, y1:Int, length:Int):Array<{x:Int, y:Int}>
	{
		var pts = [];
		for (i in 0...length) {
			pts.push({x:x1 + i, y:y1});
		}
		return pts;
	}
	
	public static function getVerticalLine(x1:Int, y1:Int, length:Int):Array<{x:Int, y:Int}>
	{
		var pts = [];
		for (i in 0...length) {
			pts.push({x:x1, y:y1 + i});
		}
		return pts;
	}
	
	public static function getLine(x1:Int, y1:Int, x2:Int, y2:Int):Array<{x:Int, y:Int}>
	{
		var pts = [];
		var dx = fastAbs(x2 - x1);
		var dy = fastAbs(y2 - y1);
		var sx = (x1 < x2) ? 1 : -1;
		var sy = (y1 < y2) ? 1 : -1;
		var err = dx - dy;
		
		pts.push({x:x1, y:y1});
		while (!((x1 == x2) && (y1 == y2))) {
		  var e2 = err << 1;
		  if (e2 > -dy) {
			err -= dy;
			x1 += sx;
		  }
		  if (e2 < dx) {
			err += dx;
			y1 += sy;
			
		  }
		  pts.push({x:x1, y:y1});
		}
		
		return pts;
	}
	
	public static function getLargeLine(x1:Int, y1:Int, x2:Int, y2:Int):Array<{x:Int, y:Int}>
	{
		var pts = [];
		var dx = fastAbs(x2 - x1);
		var dy = fastAbs(y2 - y1);
		var sx = (x1 < x2) ? 1 : -1;
		var sy = (y1 < y2) ? 1 : -1;
		var err = dx - dy;
		
		pts.push({x:x1, y:y1});
		while (!((x1 == x2) && (y1 == y2))) {
			var e2 = err << 1;
			if (e2 > -dy) {
				err -= dy;
				x1 += sx;
				if (e2 < dx) {
					pts.push({x:x1, y:y1});
				}
			}
			if (e2 < dx) {
				err += dx;
				y1 += sy;
			}
			pts.push({x:x1, y:y1});
		}
		
		return pts;
	}
	
	public static function getCircle(x1:Int, y1:Int, radius:Int):Array<{x:Int, y:Int}>
	{
		var pts = [];
		var x = radius;
		var y = 0;
		var err = 0;
		
		while (x >= y)
		{
			pts.push({x:x1 + x, y:y1 + y});
			pts.push({x:x1 + y, y:y1 + x});
			pts.push({x:x1 - y, y:y1 + x});
			pts.push({x:x1 - x, y:y1 + y});
			pts.push({x:x1 - x, y:y1 - y});
			pts.push({x:x1 - y, y:y1 - x});
			pts.push({x:x1 + y, y:y1 - x});
			pts.push({x:x1 + x, y:y1 - y});
			
			y += 1;
			err += 1 + 2 * y;
			if (2*(err-x) + 1 > 0)
			{
				x -= 1;
				err += 1 - 2*x;
			}
		}
		
		return pts;
	}
	
	public static function getDisc(x1:Int, y1:Int, radius:Int):Array<{x:Int, y:Int}>
	{
		var pts = [];
		var x = radius;
		var y = 0;
		var radiusError = 1-x;
		while (x >= y) {
			concat(pts, getHorizontalLine( -x + x1, y + y1, 2 * x));
			concat(pts, getHorizontalLine( -y + x1, x + y1, 2 * y));
			concat(pts, getHorizontalLine( -x + x1, -y + y1, 2 * x));
			concat(pts, getHorizontalLine( -y + x1, -x + y1, 2 * y));

			y++;
			if( radiusError<0 )
				radiusError += 2*y+1;
			else {
				x--;
				radiusError += 2*(y-x+1);
			}
		}
		return pts;
	}
	
	//Check
	public static function checkLine(x1:Int, y1:Int, x2:Int, y2:Int, allowedMap:Array<Array<Bool>>):Bool
	{
		var pts = getLine(x1, y1, x2, y2);
		for (i in 0...pts.length) {
			if (allowedMap[pts[i].y][pts[i].x]) {
				return false;
			}
		}
		return true;
	}
	
	public static function getLineBeforeCollision(x1:Int, y1:Int, x2:Int, y2:Int, allowedMap:Array<Array<Bool>>):Array<{x:Int, y:Int}>
	{
		var pts = getLargeLine(x1, y1, x2, y2);
		var toReturn:Array<{x:Int, y:Int}> = [];
		for (i in 0...pts.length) {
			if (pts[i].y < allowedMap.length
				&& pts[i].x < allowedMap[0].length
				&& !allowedMap[pts[i].y][pts[i].x]) {
				
				toReturn.push({x:pts[i].x, y:pts[i].y});
			} else {
				break;
			}
		}
		return toReturn;
	}
	
	
}