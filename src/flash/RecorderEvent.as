package {
	
	import flash.events.Event;
	
	public class RecorderEvent extends Event {
		public static const STATUS:String = 'status';
		public static const STARTED:String = 'started';
		public static const RECORDING:String = 'recording';
		public static const COMPLETE:String = 'complete';
		public static const ENABLED:String = 'enabled';
		public static const DISABLED:String = 'disabled';
		
		public var data:*;
		
		public function RecorderEvent($type:String, $data=null, $bubbles:Boolean=false, $cancelable:Boolean=false) {
			super($type, $bubbles, $cancelable);
			this.data = $data;
		}
		
		public override function clone():Event {
			return new RecorderEvent(type, this.data, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString('RecorderEvent', 'data', 'type', 'bubbles', 'cancelable');
		}

	}
	
}
