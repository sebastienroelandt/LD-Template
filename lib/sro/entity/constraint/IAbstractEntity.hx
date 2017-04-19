package lib.sro.entity.constraint;

import lib.sro.entity.process.constraint.IProcess;
import lib.sro.ui.constraint.IAnimatedSprite;

/**
 * @author Sebastien roelandt
 */
interface IAbstractEntity extends IAnimatedSprite
{
	public function addProcess(process:IProcess):Void;
	public function removeProcess(process:IProcess):Void;
	public function resetProcesses():Void;
	
	public function entityUpdate(delta:Float):Void;
}