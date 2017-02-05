package ld.ui.screen;

import ld.ui.entity.Player;
import lib.sro.debug.ViusalPoint;
import lib.sro.layers.DrawableLayer;
import lib.sro.screen.Screen;
import lib.sro.screen.ScreenController;
import lib.sro.core.GameController;


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
	
	public function new(screenController:ScreenController) 
	{
		super();
		
		this.screenController = screenController;
		this.playlayer = new DrawableLayer();
		
		this.player = new Player(GameController.assets.getStatedAnimationData("head"), GameController.assets.getStatedAnimationData("body"));
		
		playlayer.add(player);
		
		debutPoint = new ViusalPoint(5, 0x00FF00);
		playlayer.add(debutPoint);
		
		this.add(playlayer);
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		var cell = player.getCell(0);
		debutPoint.x = cell.getVisualPosition().x + 32;
		debutPoint.y = cell.getVisualPosition().y + 32;
	}
}