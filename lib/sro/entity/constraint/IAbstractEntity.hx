package lib.sro.entity.constraint;

import lib.sro.entity.process.constraint.IProcess;

/**
 * @author Sebastien roelandt
 */
interface IAbstractEntity 
{
	public function addProcess(process:IProcess):Void;
	public function removeProcess(process:IProcess):Void;
	public function resetProcesses():Void;
	
	public function entityUpdate(delta:Float):Void;
}