package  {
	
	import flash.external.ExternalInterface;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Recorder;
	import RecorderEvent;
	import org.bytearray.micrecorder.events.RecordingEvent;
	
	public class RecorderApi extends MovieClip {
		
		private var recorder:Recorder;

		public function RecorderApi(recorder:Recorder):void {
			this.recorder = recorder;
			registerEventListeners();
			registerJavascriptCallbacks();
		}
			
		function registerEventListeners():void {
			recorder.addEventListener(RecorderEvent.ENABLED, onRecorderEnabled);
			recorder.addEventListener(RecorderEvent.DISABLED, onRecorderDisabled);
			recorder.addEventListener(RecorderEvent.STATUS, onRecorderStatus);
			recorder.addEventListener(RecorderEvent.RECORDING, onRecorderRecording);
			recorder.addEventListener(RecorderEvent.COMPLETE, onRecorderComplete);
		}
		
		function registerJavascriptCallbacks():void {
			ExternalInterface.addCallback("startRecording", recorder.startRecording);
			ExternalInterface.addCallback("stopRecording", recorder.stopRecording);
			ExternalInterface.addCallback("getVolume", recorder.getActivityLevel);
		}
		
		function onRecorderStatus(e:RecorderEvent):void {
			ExternalInterface.call('flashRecorderUpdateStatus', e._params);
		}
		
		function onRecorderRecording(e:RecorderEvent):void {
			//if (!recorder.isMuted()) ExternalInterface.call('flashRecorderGetVolume', e._params.volume);
		}
		
		function onRecorderEnabled(e:RecorderEvent):void {
			ExternalInterface.call('flashRecorderEnable');
		}
		
		function onRecorderDisabled(e:RecorderEvent):void {
			ExternalInterface.call('flashRecorderDisable');
		}
		
		function onRecorderComplete(e:RecorderEvent):void {
			ExternalInterface.call('flashRecorderStopRecording', e._params);
		}
		
	}
	
}
