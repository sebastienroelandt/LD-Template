package lib.sro.data;

import openfl.display.Bitmap;

/**
 * ...
 * @author Sebastien roelandt
 */
class ImageData
{
	private var name:String;
	private var bitmap:Bitmap;
	
	public function new(name:String, bitmap:Bitmap) 
	{
		this.name = name;
		this.bitmap = bitmap;
	}
	
}