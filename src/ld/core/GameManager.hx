package ld.core;

import lib.sro.screen.Screen;
import lib.sro.core.ResourcesStorage;
import lib.sro.core.GameController;
import lib.sro.layers.DrawableLayer;
import lib.sro.ui.AnimatedSprite;
import lib.sro.input.Mouse;
import lib.sro.ui.TextAnimation;
import lib.sro.core.Text;

/**
 * ...
 * @author Sebastien roelandt
 */
class GameManager extends GameController
{
	public var i:Int;
	
	public function new()
	{
		var assets = ResourcesStorage.getInstance();
		MyResourcesLoader.load(assets);
		GameController.assets = assets;
		
		super();
		
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
		var layer = new DrawableLayer();
		var animatedSprite = new AnimatedSprite(GameController.assets.getStatedAnimationData("fish")); 
		animatedSprite.x = i; 
		animatedSprite.y = i; 
		i += 10;
		layer.add(animatedSprite);
		
		var animatedText = new TextAnimation("Hello World !", Text.createText("fonts/AAAA.TTF"));
		animatedText.start();
		animatedText.x = 10;
		animatedText.y = 300;
		layer.add(animatedText);
		
		screen1.add(layer);
		return screen1;
	}
	
	public override function update() {
		super.update();
		if (Mouse.isClick()) {
			this.nextScreen();
		}
	}
}