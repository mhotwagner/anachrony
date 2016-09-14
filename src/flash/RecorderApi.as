package  {
	
	import flash.external.ExternalInterface;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Recorder;
	import RecorderEvent;
	import org.bytearray.micrecorder.events.RecordingEvent;
	
	public class RecorderAPI extends MovieClip {
		
		private var recorder:Recorder;

		public function RecorderAPI(recorder:Recorder):void {
			this.recorder = recorder;
			registerEventListeners();
			registerJavascriptCallbacks();
		}
			
		function registerEventListeners():void {
			recorder.addEventListener(RecorderEvent.ENABLED, onRecorderEnabled);
			recorder.addEventListener(RecorderEvent.DISABLED, onRecorderDisabled);
			recorder.addEventListener(RecorderEvent.STATUS, onRecorderStatus);
			recorder.addEventListener(RecorderEvent.STARTED, onRecorderStarted);
			recorder.addEventListener(RecorderEvent.RECORDING, onRecorderRecording);
			recorder.addEventListener(RecorderEvent.COMPLETE, onRecorderComplete);
		}
		
		function registerJavascriptCallbacks():void {
			ExternalInterface.addCallback("startRecording", recorder.startRecording);
			ExternalInterface.addCallback("stopRecording", recorder.stopRecording);
			ExternalInterface.addCallback("getVolume", recorder.getActivityLevel);
		}
		
		// Javascript Calls
		function onRecorderEnabled(e:RecorderEvent):void {
			ExternalInterface.call('flashRecorderEnable');
		}
		
		function onRecorderDisabled(e:RecorderEvent):void {
			ExternalInterface.call('flashRecorderDisable');
		}
		
		function onRecorderStatus(e:RecorderEvent):void {
			ExternalInterface.call('flashRecorderUpdateStatus', e.data);
		}
		
		function onRecorderStarted(e:RecorderEvent):void {
			ExternalInterface.call('flashRecorderStarted');
		}
		
		function onRecorderRecording(e:RecorderEvent):void {
			ExternalInterface.call('flashRecorderGetVolume', e.data);
		}
		
		function onRecorderComplete(e:RecorderEvent):void {
			ExternalInterface.call('flashRecorderStopRecording', e.data);
		}
		
	}
	
}
