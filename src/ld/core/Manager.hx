package ld.core;

import lib.sro.core.ResourcesStorage;

/**
 * ...
 * @author Sebastien roelandt
 */
class Manager
{
	private static var isInited:Bool = false;
	
	//Models
	public static var assets:ResourcesStorage;
	
	public static function init()
	{
		if (isInited) {
			throw "Manager is already inited and started !";
		}
		isInited = true;
		
		assets = ResourcesStorage.getInstance();
		MyResourcesLoader.load(assets);
		
	}
}