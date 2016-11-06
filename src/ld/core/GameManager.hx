package ld.core;

import lib.sro.layers.DebugLayer;
import lib.sro.layers.ZoomLayer;
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
import lib.sro.engine.CollisionBox;
import lib.sro.info.Script;
import lib.sro.ui.BasicUI;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.filters.BlurFilter;
import openfl.filters.DropShadowFilter;
import openfl.filters.GlowFilter;

/**
 * ...
 * @author Sebastien roelandt
 */
class GameManager extends GameController
{
	public function new()
	{
		var assets = ResourcesStorage.getInstance();
		MyResourcesLoader.load(assets);
		GameController.assets = assets;
		
		super();
		
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
		
		var layer2 = new ZoomLayer();
		
		var tilemap = new MyMap(GameController.assets.getTileset("background"), 
			[[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,12,6,5,6,5,13,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,12,5,6,7,5,0,0,0,0,0,0,13,1,1,1,1,1,1,1,1,1],
			[1,1,1,12,0,0,0,0,0,0,0,0,0,0,0,0,13,1,1,1,1,1,1,1,1],
			[1,1,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,1,1,1,1,1,1,1],
			[1,1,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,1,1,1,1,1,1],
			[1,1,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,13,1,1,1,1],
			[1,1,1,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,1,1,1,1],
			[1,1,1,1,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,9,1,1,1,1],
			[1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,11,1,1,1,1],
			[1,1,1,1,1,10,0,0,0,0,0,0,0,0,0,0,0,0,11,1,1,1,1,1,1],
			[1,1,1,1,1,1,10,3,0,0,0,0,0,0,0,0,3,11,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,10,2,3,3,4,2,3,11,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]], [1]);
		layer2.add(tilemap);
		
		
		var block = new Sprite();
		block.graphics.beginFill(0xFFFFFF, 0.5);
		block.graphics.drawRect(210, 200, 190, 30);
		block.graphics.drawRect(300, 280, 10, 70);
		block.graphics.drawRect(220, 380, 10, 10);
		block.graphics.endFill();
		tilemap.addChild(block);
		
		var collideBox = new CollisionBox(210, 200, 400, 230);
		var collideBox2 = new CollisionBox(300, 280, 310, 350);
		var collideBox3 = new CollisionBox(220, 380, 230, 390);
		
		var animatedSprite = new Hero(GameController.assets.getStatedAnimationData("fish"), null, 5, 5, 5, 5); 
		animatedSprite.setPosition(200, 200);
		animatedSprite.addCollideTo(tilemap);
		animatedSprite.addCollideTo(collideBox);
		animatedSprite.addCollideTo(collideBox2);
		animatedSprite.addCollideTo(collideBox3);

		layer2.y = 70;
		
		tilemap.addHero(animatedSprite);
		tilemap.add(animatedSprite);
		tilemap.add(collideBox);
		tilemap.add(collideBox2);
		tilemap.add(collideBox3);
		/*
		//Bitmap effect
		var fishes = new Array();
		for (i in 0...5) {
			var fish = new BasicUI();
			fish.addChild(new Bitmap(GameController.assets.getTileset("fish")[0]));
			fish.x = 200 + i * 50;
			fish.y = 300;
			fishes.push(fish);
			tilemap.add(fish);
		}
		
		fishes[1].filters = [new GlowFilter(0x343F50, 0.7, 2 ,2,10, 1,true)];
		fishes[2].filters = [new DropShadowFilter(2,90, 0xFFFFFF,0.15, 0,0,1, 1,true)];
		fishes[3].filters = [new BlurFilter()];
		fishes[4].filters = [new GlowFilter(0xFFFF00, 0.1, 2, 2, 5, 1, true) ];*/
		
		//Ombre
		var ombre = new BasicUI();
			ombre.graphics.beginFill(0x000000, 0.2);
			ombre.graphics.drawRoundRect(10, 0, 28, 10, 20);
			ombre.graphics.endFill();
			ombre.filters = [new GlowFilter(0xFFFFFF,0.15, 0,0,1, 1,false)];
			ombre.x = 0;
			ombre.y = 48;
		animatedSprite.add(ombre);
		
		screen1.add(layer);
		screen1.add(layer2);
		
		var script = new Script();
		
		var mySoundPlayer = new MySoundManager();
		screen1.add(mySoundPlayer);
		
		return screen1;
	}
	
	public override function update() {
		super.update();
		//if (Mouse.isClick()) {
		//	this.nextScreen();
		//}
	}
}