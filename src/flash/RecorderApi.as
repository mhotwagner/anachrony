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
			recorder.addEventListener('Recorder.Enabled', onEnable);
			recorder.addEventListener('Recorder.Disabled', onDisable);
		}
		
		function registerJavascriptCallbacks():void {
			//ExternalInterface.addCallback("initialize", recorder.initialize);
			//ExternalInterface.addCallback("start", recorder.start);
			//ExternalInterface.addCallback("stop", recorder.stop);
		}
		
		function onEnterFrame(e:Event):void {
			//ExternalInterface.call('flashLog', '<RecorderApi>: ENTER_FRAME)');
			if (!recorder.isMuted()) {
				ExternalInterface.call('flashRecorderGetVolume', recorder.getActivityLevel());
			}
		}
		
		function onEnable(e) {
			ExternalInterface.call('flashRecorderEnable');
		}
		
		function onDisable(e) {
			ExternalInterface.call('flashRecorderDisable');
		}

	}
	
}
