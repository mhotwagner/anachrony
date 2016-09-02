package  {
	
	import flash.external.ExternalInterface;
	import Recorder;
	
	public class Api {
			var recorder:Recorder;

		public function Api(recorder:Recorder):Void {
			// constructor code
			recorder = recorder;
		}
		
		
		
		// JS Hooks into Recorder
		public function start():void {
			recorder.start();
		}
		ExternalInterface.addCallback('start', start);
		
		public function stop():void {
			recorder.stop();
		}
		ExternalInterface.addCallback('stop', stop);

	}
	
}
