package ld.core;

import lib.sro.ui.BasicUI;
import lib.sro.input.Keys;
import openfl.ui.Keyboard;
import lib.sro.core.ResourcesStorage;
import lib.sro.sound.MusicManager;
import lib.sro.sound.SoundManager;

/**
 * ...
 * @author Sebastien roelandt
 */
class MySoundManager extends BasicUI
{
	private var musicManager	: MusicManager;
	private var soundManager	: SoundManager;
	
	public function new(?parent:BasicUI=null) 
	{
		super(parent);
		
		musicManager = MusicManager.getInstance();
		soundManager = SoundManager.getInstance();
	}
	
	override public function update(delta:Float) 
	{
		super.update(delta);
		
		if (Keys.isClick(Keyboard.NUMPAD_1)) {
			musicManager.start(ResourcesStorage.getInstance().getSound("1"));
		} else if (Keys.isClick(Keyboard.NUMPAD_2)) {
			musicManager.start(ResourcesStorage.getInstance().getSound("2"));
		} else if (Keys.isClick(Keyboard.NUMPAD_3)) {
			musicManager.start(ResourcesStorage.getInstance().getSound("3"));
		} else if (Keys.isClick(Keyboard.NUMPAD_4)) {
			musicManager.start(ResourcesStorage.getInstance().getSound("4"));
		} else if (Keys.isClick(Keyboard.NUMPAD_5)) {
			musicManager.changeVolume(musicManager.getVolume() - 10);
		} else if (Keys.isClick(Keyboard.NUMPAD_6)) {
			musicManager.changeVolume(musicManager.getVolume() + 10);
		} else if (Keys.isClick(Keyboard.NUMPAD_7)) {
			soundManager.play(ResourcesStorage.getInstance().getSound("1"));
		} else if (Keys.isClick(Keyboard.NUMPAD_8)) {
			soundManager.play(ResourcesStorage.getInstance().getSound("2"));
		} else if (Keys.isClick(Keyboard.NUMPAD_9)) {
			soundManager.play(ResourcesStorage.getInstance().getSound("3"));
		} 
	}
	
}