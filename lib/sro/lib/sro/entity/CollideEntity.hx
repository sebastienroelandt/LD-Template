package lib.sro.entity;

import lib.sro.data.StatedAnimationData;
import lib.sro.ui.BasicUI;

/**
 * ...
 * @author Sebastien roelandt
 */
class CollideEntity extends Entity
{

	public function new(statedAnimationData:StatedAnimationData, ?parent:BasicUI=null, ?deltaUp=0, ?deltaDown=0, ?deltaLeft=0, ?deltaRight=0) 
	{
		super(statedAnimationData, parent, deltaUp, deltaDown, deltaLeft, deltaRight);
		
	}
	
}