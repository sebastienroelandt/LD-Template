package lib.sro.core;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Assets;
/**
 * ...
 * @author Sebastien roelandt
 */
class Text
{
	public static function createText(fontId:String, ?size:Int = 14, ?color:int = 0xFFFFFF, 
		?align:String = TextFormatAlign.LEFT, ?bold:Bool = false) : TextField 
	{
		var textField:TextField = new TextField();
		
		var textFormat = textFormat.defaultTextFormat;
		var font = Assets.getFont(fontId);
		format.font = font.fontName;
		format.size = size;
		format.color = color;
		format.align = align;
		format.blod = bold;
		
		textField.defaultTextFormat = textFormat;
		textField.setTextFormat(textFormat);
		textField.embedFonts = true;
		textField.mouseEnabled = false;
		textField.selectable = false;
		textField.wordWrap = true;
		
		return textFormat;
	}
	
}