package lib.sro.ui;

import openfl.display.Bitmap;
import lib.sro.ui.BasicUI;
import lib.sro.input.Mouse;
import openfl.display.BitmapData;
import openfl.geom.Point;

/**
 * ...
 * @author Sebastien roelandt
 */
enum ButtonState {
	Default;
	Hover;
	Press;
}
 
class ButtonUI extends BasicUI
{
	
	//Default
	private var defaultBitmapData:BitmapData;
	//Hover
	private var hoverBitmapData:BitmapData;
	//Press
	private var pressBitmapData:BitmapData;
	
	private var isPress:Bool;
	private var currentBitmap:Bitmap;
	private var currentState:ButtonState;
	
	public function new(defaultBitmap:Bitmap, ?hoverBitmap:Bitmap, ?pressBitmap:Bitmap) 
	{
		super();
		this.defaultBitmapData = defaultBitmap.bitmapData;
		this.hoverBitmapData = hoverBitmap == null ? defaultBitmapData: hoverBitmap.bitmapData;
		this.pressBitmapData = pressBitmap == null ? defaultBitmapData: pressBitmap.bitmapData;
		this.isPress = false;
		this.currentState = ButtonState.Default;
		this.currentBitmap = new Bitmap();
		this.currentBitmap.bitmapData = defaultBitmap.bitmapData;
		this.currentBitmap.x = 150;
		this.currentBitmap.y = 100;
		this.addChild(this.currentBitmap);
	}
	
	override public function update(delta:Float) {	
		updateButtonState();
	}
	
	private function updateButtonState() {
		var previousState = currentState;
		
		//update
		if (isMouseIn()) {
			if (!Mouse.isDown() && isPress) {
				onClick();
				isPress = false;
				currentState = ButtonState.Hover;
			} else if (Mouse.isDown()) {
				isPress = true;
				currentState = ButtonState.Press;
			} else {
				isPress = false;
				currentState = ButtonState.Hover;
			}
		} else {
			if (!Mouse.isDown()) {
				isPress = false;
				currentState = ButtonState.Default;
			}
		}
		
		if (previousState != currentState) {
			onNewState();
			switch (currentState) {
				case ButtonState.Press 	: currentBitmap.bitmapData = pressBitmapData;
				case ButtonState.Hover 	: currentBitmap.bitmapData = hoverBitmapData;
				default					: currentBitmap.bitmapData = defaultBitmapData;					
			}
		}
	}
	
	private function isMouseIn():Bool {
		var point = Mouse.getXY();
		return point.x >= this.currentBitmap.x 
				&& point.x <= this.currentBitmap.x + this.currentBitmap.width
				&& point.y >= this.currentBitmap.y 
				&& point.y <= this.currentBitmap.y + this.currentBitmap.height;
	}
		
	public function onClick() {
		trace("aa");
		//onClick Event
	}
	
	public function onNewState() {
		//change Event
	}
}