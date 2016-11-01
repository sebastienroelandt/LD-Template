package ld.core;

import lib.sro.data.StatedAnimationData;
import lib.sro.ui.BasicUI;
import lib.sro.entity.Entity;
import lib.sro.input.Keys;
import lib.sro.effect.TransparencyEffect;
import lib.sro.core.Bezier;
import openfl.ui.Keyboard;


/**
 * ...
 * @author Sebastien roelandt
 */
class Hero extends Entity
{
	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI = null, 
		?deltaUp = 0, ?deltaDown = 0, ?deltaLeft = 0, ?deltaRight = 0) 
	{
		super(statedAnimationData, parent, deltaUp, deltaDown, deltaLeft, deltaRight);
	}
	
	public override	function update(delta:Float)
	{
		super.update(delta);
		
		if (Keys.isClick(Keyboard.SPACE)) {
			new TransparencyEffect(this, 1000, BezierType.In);
		}
		
		if (EntityDirection.Right.equals(this.direction)) {
			this.change("transform_right");
		}
		if (EntityDirection.Left.equals(this.direction) && this.getCurrentAnimationName() != "move_right") {
			this.change("transform_right");
			this.addToQueue("move_right");
		}
	}
	
	
}