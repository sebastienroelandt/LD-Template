package lib.sro.effect;

import lib.sro.effect.Effect;
import openfl.display.Sprite;
import openfl.geom.Matrix;

/**
 * ...
 * @author Sebastien roelandt
 */
class TransparencyEffect extends Effect
{

	private var rotation: Float;
	private var matrix:Matrix;
	
	public function new(applyTo:Sprite) 
	{
		super(applyTo);
		rotation = 0;
		applyTo.x = 100;
		applyTo.y = 100;
		this.matrix = applyTo.transform.matrix;
		
	}
	
	override public function update(delta:Int) {
		rotation = (rotation + delta/30 ) % 360;
		
		var centerX = applyTo.width / 2;
		var centerY = applyTo.height / 2;
		
		matrix.translate(-centerX, -centerY);
		matrix.rotate(rotation * (Math.PI / 180.00));
		matrix.translate(centerX, centerY);
		matrix.concat(applyTo.transform.matrix);
		applyTo.transform.matrix = matrix;
	}
	
}