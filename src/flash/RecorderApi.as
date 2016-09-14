package  {
	
	import flash.external.ExternalInterface;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Recorder;
	import org.bytearray.micrecorder.events.RecordingEvent;
	
	public class RecorderApi extends MovieClip {
		
		private var recorder:Recorder;

		public function RecorderApi(recorder:Recorder):void {
			this.recorder = recorder;
			registerEventListeners();
			registerJavascriptCallbacks();
		}
			
		function registerEventListeners():void {
			recorder.addEventListener('Recorder.enabled', onRecorderEnabled);
			recorder.addEventListener('Recorder.disabled', onRecorderDisabled);
			recorder.addEventListener('Recorder.recording', onRecorderRecording);
			recorder.addEventListener('Recorder.complete', onRecorderComplete);
		}
		
		function registerJavascriptCallbacks():void {
			ExternalInterface.addCallback("startRecording", recorder.startRecording);
			ExternalInterface.addCallback("stopRecording", recorder.stopRecording);
			ExternalInterface.addCallback("getVolume", recorder.getActivityLevel);
		}
		
		
		function onRecorderRecording(e:Event):void {
			if (!recorder.isMuted()) ExternalInterface.call('flashRecorderGetVolume', recorder.getActivityLevel());
		}
		
		function onRecorderEnabled(e:Event):void {
			ExternalInterface.call('flashRecorderEnable');
		}
		
		function onRecorderDisabled(e:Event):void {
			ExternalInterface.call('flashRecorderDisable');
		}
		
		function onRecorderComplete(e:Event):void {
			var data:Object = {dataURL: recorder.getDataURL()}
			ExternalInterface.call('flashRecorderStopRecording', data);
		}
		
	}
	
}
