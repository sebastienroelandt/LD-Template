package lib.sro.info;

/**
 * ...
 * @author Sebastien roelandt
 */
class Bus
{
	public signals:Map<String,Signal>;
	
	public function new() 
	{
			signals = new Map();
	}
	
	public function addSignal(name:String):Signal {
		var signal = new Signal(name);
		signals.set(name, signal);
		return signal;
	}
	
	public function register(observer:Observer, signalName:String) {
		var signal:Signal = signals.get(signalName);
		if (signal != null) {
			signal.register(observer);
		}
	}
	
	public function unregister(observer:Observer, signalName:String) {
		var signal:Signal = signals.get(signalName);
		if (signal != null ) {
			signal.unregister(observer);
		}
	}
	
	public function unregisterAll(observer:Observer) {
		var iterator:Iterator = signals.iterator();
		while (iterator.hasNext()) {
			var signal:Signal = iterator.next();
			if (signal != null) {
				signal.unregister(observer);
			}
		}
	}
	
	public function alert(signalName:String) {
		var signal:Signal = signals.get(signalName);
		if (signal != null ) {
			signal.alert(signalName);
		}
	}
	
}