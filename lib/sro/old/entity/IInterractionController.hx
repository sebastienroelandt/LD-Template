package lib.sro.entity;

/**
 * @author Sebastien roelandt
 */
interface IInterractionController 
{
	public function updatePositionDueToInteraction(allEntity:Array<IEntity>):Void;
	public function onInteraction(with :IEntity):Void;
	
	public function getInterractionRadius():Float;
	public function setInterractionRadius(interractionRadius:Float):Void;
	public function getInterractionStrenght():Float;
	public function setInterractionStrenght(interractionRadius:Float):Void;
}