package ld.ui.entity;

import lib.sro.data.StatedAnimationData;
import lib.sro.ui.BasicUI;
import ld.ui.entity.Body;

/**
 * ...
 * @author Sebastien roelandt
 */
class Player extends BasicUI
{
	var cells		:	Array<Body>;

	public function new(headAnimation:StatedAnimationData, bodyAnimation:StatedAnimationData) 
	{
		super();
		cells = new Array();
		
		addCell(new Head(this, headAnimation));
		for (i in 0...5) {
			addCell(new Body(this, bodyAnimation,getLastCell()));
		}
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
	}
	
	private function addCell(cell:Body)
	{
		if (cell != null) {
			cells.push(cell);
			this.add(cell);
		}
	}
	
	public function getCell(number:Int)
	{
		var cell = null;
		if (cells != null && cells.length != 0) {
			if (number >= cells.length) {
				number = cells.length - 1;
			}
			cell = cells[number];
		}
		return cell;
	}
	
	private function getLastCell():Body 
	{
		var cell = null;
		if (cells != null && cells.length != 0) {
			cell = cells[cells.length - 1];
		}
		return cell;
	}
	
	public function getCells():Array<Body>
	{
		return cells;
	}
	
}