package lib.sro.info;

/**
 * ...
 * @author Sebastien roelandt
 */
class Signal
{
	private var observers:Array<Observer>;
	private var name:String;
	
	public function new(name:String) 
	{
		observers = new Array<Observer>();
		this.name = name;
	}
	
	public function register(observer:Observer) {
		observers.push(observer);
	}
	
	public function unregister(observer:Observer):Bool {
		return observers.remove(observer);
	}
	
	public function alert() {
		for (Observer observer in observers) {
			observer.alert(name);
		}
	}
	
}