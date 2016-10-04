package ld.core;

import lib.sro.screen.Screen;
import lib.sro.core.ResourcesStorage;
import lib.sro.core.GameController;
import lib.sro.layers.DrawableLayer;
import lib.sro.ui.AnimatedSprite;
import lib.sro.input.Mouse;

/**
 * ...
 * @author Sebastien roelandt
 */
class GameManager extends GameController
{
	public var i:Int;
	
	public function new()
	{
		super();
		assets = ResourcesStorage.getInstance();
		MyResourcesLoader.load(assets);
		
		i = 10;
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		this.addScreen(initScreen1());
		start();
	}
	
	public function initScreen1():Screen {
		var screen1 = new Screen();
		var animatedSprite = new AnimatedSprite(this.assets.getStatedAnimationData("fish")); 
		animatedSprite.x = i; 
		animatedSprite.y = i; 
		i += 10;
		screen1.add(animatedSprite);
		return screen1;
	}
	
	public override function update() {
		super.update();
		if (Mouse.isClick()) {
			this.nextScreen();
		}
	}
}