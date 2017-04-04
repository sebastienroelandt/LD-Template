package lib.sro.entity.process.impl;

import lib.sro.entity.process.constraint.IProcess;

/**
 * ...
 * @author Sebastien roelandt
 */
class RotationProcess implements IProcess
{
	private var priority			: Int;

	public function new() 
	{
		this.priority = ProcessesOrder.ROTATION_PRIORITY;
	}
	
	public function beforeEntityUpdate(delta:Float):Void 
	{

	}
	
	public function afterEntityUpdate(delta:Float):Void 
	{
		
	}
	
	public function stop():Void 
	{
		
	}
	
	public function getPriority():Int 
	{
		return priority;
	}
	
	public function setPriority(priority:Int):Void 
	{
		this.priority = priority;
	}
	
}