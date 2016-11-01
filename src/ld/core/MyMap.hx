package ld.core;

import lib.sro.ui.TiledMapUI;
import openfl.display.BitmapData;

/**
 * ...
 * @author Sebastien roelandt
 */
class MyMap extends TiledMapUI
{
	private var hero:Hero;

	public function new(tileset:Array<BitmapData>, values:Array<Array<Int>>, ?collisionId:Array<Int>=null) 
	{
		super(tileset, values, collisionId);
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (hero != null) {
			if (hero.x + this.x < 100) {
				this.x = - (hero.x - 100) ;
			} else if (hero.x + this.x > 700){
				this.x = - (hero.x - 700) ;
			}
		}
	}
	
	public function addHero(hero:Hero) {
		this.hero = hero;
	}
	
}