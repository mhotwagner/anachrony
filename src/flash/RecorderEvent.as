package {
	
	import flash.events.Event;
	
	public class RecorderEvent extends Event {
		public static const STATUS:String = 'status';
		public static const RECORDING:String = 'recording';
		public static const COMPLETE:String = 'complete';
		public static const ENABLED:String = 'enabled';
		public static const DISABLED:String = 'disabled';
		
		public var _params:*;
		
		public function RecorderEvent($type:String, $params=null, $bubbles:Boolean=false, $cancelable:Boolean=false) {
			super($type, $bubbles, $cancelable);
			this._params = $params;
		}
		
		public override function clone():Event {
			return new RecorderEvent(type, this._params, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString('RecorderEvent', '_params', 'type', 'bubbles', 'cancelable');
		}

	}
	
}
