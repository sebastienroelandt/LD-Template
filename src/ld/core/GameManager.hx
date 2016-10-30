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
import lib.sro.entity.Entity;

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
		
		var animatedText = new TextAnimation("Hello World !", Text.createText("fonts/AAAA.TTF"));
		animatedText.start();
		animatedText.x = 400;
		animatedText.y = 10;
		layer.add(animatedText);
		
		var button = new ButtonUI(100, 10, GameController.assets.getBitmap("defaultButton"),
			GameController.assets.getBitmap("hoverButton"),
			GameController.assets.getBitmap("clickButton"));
		layer.add(button);
		
		var toggleButton = new ToggleButtonUI(30, 10,	GameController.assets.getBitmap("defaultLeftButton"),
														GameController.assets.getBitmap("defaultRightButton"),
														GameController.assets.getBitmap("activeLeftButton"),
														GameController.assets.getBitmap("activeRightButton")
														, 20);
		layer.add(toggleButton);
		
		var toggleButton2 = new ToggleButtonUI(5, 10,GameController.assets.getBitmap("activeLeftButton"),
														GameController.assets.getBitmap("activeRightButton"));
		layer.add(toggleButton2);
		
		var layer2 = new DrawableLayer();
		var tilemap = new TiledMapUI(GameController.assets.getTileset("background"), [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,12,7,7,13,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,12,0,0,0,9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,10,0,0,0,0,7,7,7,7,13,1,1,1,1,1,12,5,13,1,1,1,1],
								[1,1,1,1,10,0,0,0,0,0,0,0,9,1,1,1,1,12,0,0,9,1,1,1,1],
								[1,1,1,1,1,8,0,0,0,0,0,0,0,13,1,1,1,8,0,17,9,1,1,1,1],
								[1,1,1,1,1,10,4,0,0,0,0,2,3,11,1,1,1,10,4,16,11,1,1,1,1],
								[1,1,1,1,1,1,1,10,3,3,11,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]], [1]);
		layer2.add(tilemap);
		
		var animatedSprite = new Entity(GameController.assets.getStatedAnimationData("fish"), null, 5, 5, 5, 5); 
		animatedSprite.x = i; 
		animatedSprite.y = i; 
		animatedSprite.addCollideTo(tilemap);
		i += 10;
		layer2.y = 70;
		
		layer2.add(animatedSprite);
		
		screen1.add(layer);
		screen1.add(layer2);
		return screen1;
	}
	
	public override function update() {
		super.update();
		//if (Mouse.isClick()) {
		//	this.nextScreen();
		//}
	}
}