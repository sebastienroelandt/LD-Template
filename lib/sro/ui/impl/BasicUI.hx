package lib.sro.ui.impl;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import lib.sro.ui.constraint.IBasicUI;
import Sys;

/**
 * ...
 * @author Sebastien roelandt
 */
class BasicUI extends Sprite implements IBasicUI
{
	private var _parent:IBasicUI;
	private var _childs:List<IBasicUI>;
	
	public var pause:Bool;

	public function new(?parent:IBasicUI = null) 
	{
		super();
		this._parent = parent;
		this._childs = new List<IBasicUI>();
		this.pause = false;
	}
	
	public function add(child:IBasicUI) {
		this.addChild(child.getDisplayObject());
		_childs.add(child);
	}
	
	public function remove(child:IBasicUI) {
		_childs.remove(child);
	}
	
	public function removeAll() {
		_childs = new List<IBasicUI>();
	}
	
	public function updateAll(delta:Float) {
		if (!pause) {
			for (child in _childs) {
				child.updateAll(delta);
			}
			update(delta);
		}
	}
	
	public function update(delta:Float) {
		// update actions
	}
	
	public function setPause(pause:Bool) {
		if (this.pause != pause) {
			for (child in _childs) {
				child.setPause(pause);
			}
			this.pause = pause;
		}
	}
	
	public function getDisplayObject() : DisplayObject {
		return this;
	}
}