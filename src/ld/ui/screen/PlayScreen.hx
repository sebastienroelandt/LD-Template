package ld.ui.screen;

import lib.sro.debug.ViusalPoint;
import lib.sro.engine.CollisionBox;
import lib.sro.entity.impl.CollisionableEntity;
import lib.sro.entity.impl.MovableEntity;
import lib.sro.entity.process.impl.BoxCollisionProcess;
import lib.sro.entity.process.impl.FrictionProcess;
import lib.sro.entity.process.impl.GravityProcess;
import lib.sro.entity.process.impl.GridCollisionProcess;
import lib.sro.layers.DrawableLayer;
import lib.sro.particles.BasicParticle;
import lib.sro.particles.ParticlesGenerator;
import lib.sro.screen.Screen;
import lib.sro.screen.ScreenController;
import lib.sro.core.GameController;
import lib.sro.ui.impl.TiledMapUI;
import lib.sro.ui.impl.ToggleButtonUI;
import lib.sro.ui.impl.ToggleButtonUI.ToggleButtonState;
import lib.sro.input.Mouse;
import lib.sro.core.Bezier.BezierType;
import lib.sro.entity.impl.BasicEntity;
import lib.sro.entity.process.impl.MoveProcess;


/**
 * ...
 * @author Sebastien roelandt
 */
class PlayScreen extends Screen
{
	private var screenController 	: 	ScreenController;
	
	private var playlayer 			:	DrawableLayer;
	private var debutPoint			:	ViusalPoint;
	
	private var generator			:	ParticlesGenerator;
	
	public function new(screenController:ScreenController) 
	{
		super();
		
		this.screenController = screenController;
		this.playlayer = new DrawableLayer();
		
		var map = new TiledMapUI(GameController.assets.getTileset("tileset"), [[0, 0, 0, 1], [0, 1, 0, 1], [1, 1, 0, 0], [1, 0, 0, 0]], [1]);
		
		var box = new CollisionBox(0, 0, 10, 10);
		
		var newPlayer = new CollisionableEntity(GameController.assets.getStatedAnimationData("head"));
		newPlayer.addProcess(new GravityProcess(newPlayer));
		newPlayer.addProcess(new FrictionProcess(newPlayer));
		newPlayer.addProcess(new MoveProcess(newPlayer));
		newPlayer.addProcess(new GridCollisionProcess(newPlayer, 50, 50, map.getCollisionGrid()));
		newPlayer.addProcess(new BoxCollisionProcess(newPlayer, box));
		newPlayer.setYy(50);
		
		playlayer.add(map);
		playlayer.add(newPlayer);
		
		this.add(playlayer);
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		//var cell = player.getCell(0);
		//debutPoint.x = cell.getVisualPosition().x + 32;
		//debutPoint.y = cell.getVisualPosition().y + 32;
		
		//var mouseXY = Mouse.getXY();
		//generator.setPosition(mouseXY);
	}
}