package ld.ui.screen;

import ld.ui.entity.Player;
import lib.sro.debug.ViusalPoint;
import lib.sro.layers.DrawableLayer;
import lib.sro.particles.BasicParticle;
import lib.sro.particles.ParticlesGenerator;
import lib.sro.screen.Screen;
import lib.sro.screen.ScreenController;
import lib.sro.core.GameController;
import lib.sro.ui.ToggleButtonUI;
import lib.sro.ui.ToggleButtonUI.ToggleButtonState;
import lib.sro.input.Mouse;
import lib.sro.core.Bezier.BezierType;


/**
 * ...
 * @author Sebastien roelandt
 */
class PlayScreen extends Screen
{
	private var screenController 	: 	ScreenController;
	
	private var playlayer 			:	DrawableLayer;
	private var debutPoint			:	ViusalPoint;
	private var player 				:	Player;
	
	private var generator			:	ParticlesGenerator;
	
	public function new(screenController:ScreenController) 
	{
		super();
		
		this.screenController = screenController;
		this.playlayer = new DrawableLayer();
		
		this.player = new Player(GameController.assets.getStatedAnimationData("head"), GameController.assets.getStatedAnimationData("body"));
		
		playlayer.add(player);
		
		debutPoint = new ViusalPoint(5, 0x00FF00);
		playlayer.add(debutPoint);
		
		//var toggle = new ToggleButtonUI(10, 10, GameController.assets.getBitmapData("t1"), GameController.assets.getBitmapData("t2"));
		//playlayer.add(toggle);
		
		generator = new ParticlesGenerator(playlayer, BezierType.Random, true, true, 5000);
		generator.getNewParticle = function() {return new BasicParticle(GameController.assets.getStatedAnimationData("bubulle"));}
		playlayer.add(generator);
		
		this.add(playlayer);
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		var cell = player.getCell(0);
		debutPoint.x = cell.getVisualPosition().x + 32;
		debutPoint.y = cell.getVisualPosition().y + 32;
		
		var mouseXY = Mouse.getXY();
		generator.setPosition(mouseXY);
	}
}