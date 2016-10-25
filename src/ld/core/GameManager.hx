package ld.core;

import lib.sro.screen.Screen;
import lib.sro.core.ResourcesStorage;
import lib.sro.core.GameController;
import lib.sro.layers.DrawableLayer;
import lib.sro.ui.AnimatedSprite;
import lib.sro.input.Mouse;
import lib.sro.ui.TextAnimation;
import lib.sro.core.Text;
import lib.sro.ui.ButtonUI;
import lib.sro.ui.ToggleButtonUI;
import lib.sro.ui.TiledMapUI;

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
		
		var button = new ButtonUI(150, 100, GameController.assets.getBitmap("defaultButton"),
			GameController.assets.getBitmap("hoverButton"),
			GameController.assets.getBitmap("clickButton"));
		layer.add(button);
		
		var toggleButton = new ToggleButtonUI(250, 150,	GameController.assets.getBitmap("defaultLeftButton"),
														GameController.assets.getBitmap("defaultRightButton"),
														GameController.assets.getBitmap("activeLeftButton"),
														GameController.assets.getBitmap("activeRightButton")
														, 20);
		layer.add(toggleButton);
		
		var toggleButton2 = new ToggleButtonUI(250, 180,GameController.assets.getBitmap("activeLeftButton"),
														GameController.assets.getBitmap("activeRightButton"));
		layer.add(toggleButton2);
		
		var tilemap = new TiledMapUI(GameController.assets.getTileset("background"), [[12, 6, 13], [10, 3, 11]]);
		layer.add(tilemap);
		
		screen1.add(layer);
		return screen1;
	}
	
	public override function update() {
		super.update();
		//if (Mouse.isClick()) {
		//	this.nextScreen();
		//}
	}
}