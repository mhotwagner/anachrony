package  {
	
	import flash.external.ExternalInterface;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Recorder;
	
	public class RecorderApi extends MovieClip {
		private var recorder:Recorder;

		public function RecorderApi(recorder:Recorder):void {
			// constructor code
			this.recorder = recorder;
			trace(recorder);
			registerListenersAndHandlers();
			//ExternalInterface.addCallback("recorderStop", stopRecorder);
			
		}
		
		private function onEnterFrame(e:Event):void {
			ExternalInterface.call('flashLog', '<RecorderApi>: ENTER_FRAME)');
			if (recorder.isRecording()) {
				ExternalInterface.call('flashLog', '<Recorder>: Recording!');
				jsUpdateRecorderStatus();
			}
		}
			
		private function registerListenersAndHandlers():void {
			ExternalInterface.addCallback("flashRecorderStart", startRecorder);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			//trace('whatever')
		}
		
		// JS Hooks into Recorder
		
		function startRecorder():void {
			recorder.start();
			ExternalInterface.call("flashLog", '<RecorderApi>: calling recorder.start()');
		}
		
		
		function stopRecorder():void {
			recorder.stop();
		}
		
		// AS3 Calls out ot JS
		function jsUpdateRecorderStatus():void {
			var data:Object = {'activityLevel': recorder.getStatus()};
			trace(data);
			ExternalInterface.call("recorderStatus", data);
		}
		

	}
	
}
