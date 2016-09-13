package  {
	
	import flash.external.ExternalInterface;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Recorder;
	
	public class RecorderApi extends MovieClip {
		
		private var recorder:Recorder;

		public function RecorderApi(recorder:Recorder):void {
			this.recorder = recorder;
			registerEventListeners();
			registerJavascriptCallbacks();
		}
			
		function registerEventListeners():void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			recorder.addEventListener('Recorder.enabled', onEnable);
			recorder.addEventListener('Recorder.disabled', onDisable);
			recorder.addEventListener('Recorder.stoppedRecording', onStoppedRecording);
		}
		
		function registerJavascriptCallbacks():void {
			//ExternalInterface.addCallback("initialize", recorder.initialize);
			ExternalInterface.addCallback("startRecording", recorder.startRecording);
			ExternalInterface.addCallback("stopRecording", recorder.stopRecording);
		}
		
		function onEnterFrame(e:Event):void {
			//ExternalInterface.call('flashLog', '<RecorderApi>: ENTER_FRAME)');
			if (!recorder.isMuted()) {
				ExternalInterface.call('flashRecorderGetVolume', recorder.getActivityLevel());
			}
		}
		
		function onEnable(e) {
			ExternalInterface.call('flashRecorderEnable');
			ExternalInterface.call('flashLog', 'flashRecorderEnable()');
		}
		
		function onDisable(e) {
			ExternalInterface.call('flashRecorderDisable');
			ExternalInterface.call('flashLog', 'flashRecordDisable()');
		}
		
		function onStoppedRecording(e) {
			ExternalInterface.call('flashRecorderStoppedRecording', recorder.getDataURL());
			ExternalInterface.call('flashLog', 'flashRecorderStoppedRecording');
		}

	}
	
}
