package {
	import flash.utils.ByteArray;
	import flash.display.Sprite;
	import flash.media.Microphone;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import org.bytearray.micrecorder.*;
	import org.bytearray.micrecorder.events.RecordingEvent;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import flash.events.Event;
	import flash.events.ActivityEvent;
	import flash.net.FileReference;	
	import flash.external.ExternalInterface;
	import flash.events.StatusEvent;
    import flash.media.Microphone;
	
	import Base64;
	import RecorderEvent;
	
	public class Recorder extends Sprite {
		
		private var muted:Boolean = true;
		private var recording:Boolean = false;
		private var time:int = 0;
		private var duration:int = 0;
		
		private var mic:Microphone;
		private var wavEncoder:WaveEncoder = new WaveEncoder();
		private var micRecorder:MicRecorder = new MicRecorder(wavEncoder, null, 100, 22);
		private var fileReference:FileReference = new FileReference();
		
		public function Recorder() {
			initializeMicRecorder();
			addEventListeners();
			Security.showSettings("2");
		}
		
		private function addEventListeners():void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			mic.addEventListener(StatusEvent.STATUS, onMicStatus, false, 0, true);
			micRecorder.addEventListener(RecordingEvent.RECORDING, onRecording);
			micRecorder.addEventListener(Event.COMPLETE, onComplete);			
		}
		
		// Methods
		public function isMuted():Boolean {
			return muted;
		}
		
		public function getActivityLevel():int {
			return mic.activityLevel;
		}
		
		public function getTime():int {
			return this.time;
		}
		
		public function getDuration():int {
			return this.duration;
		}
		
		public function getDataURL():String {
			return 'data:audio/wav;base64,' + Base64.encode(micRecorder.output);
		}
		
		public function startRecording():void {
			if (!recording) {
				recording = true;
				micRecorder.record();
				dispatchEvent(new RecorderEvent(RecorderEvent.STARTED, {}, true));
			}
		}
		
		public function stopRecording():void {
			if (recording) {
				recording = false;
				micRecorder.stop();
				mic.setLoopBack(false);
			}
		}
		
		// Event Handlers
		private function onEnterFrame(e:Event):void {
			var data:Object = {muted: this.muted, recording: this.recording, volume: mic.activityLevel};
			if (this.time) data.time = this.time;
			dispatchEvent(new RecorderEvent(RecorderEvent.STATUS, data, true));
		}
		
		private function onRecording(e:RecordingEvent):void {
			var data:Object = {time: e.time, volume: mic.activityLevel};
			dispatchEvent(new RecorderEvent(RecorderEvent.RECORDING, data, true));
		}
		
		private function onComplete(e:Event):void {
			var data:Object = {
				dataURL: this.getDataURL(),
				duration: this.duration
			};
			dispatchEvent(new RecorderEvent(RecorderEvent.COMPLETE, data, true));
		}
		
		private function onMicStatus(e:StatusEvent):void {
			if (e.code == "Microphone.Unmuted"){
				muted = false;
				mic.removeEventListener(StatusEvent.STATUS, onMicStatus);
				dispatchEvent(new RecorderEvent(RecorderEvent.ENABLED, true));
			} else if (e.code == "Microphone.Muted") {
				mic.removeEventListener(StatusEvent.STATUS, onMicStatus);
				dispatchEvent(new RecorderEvent(RecorderEvent.DISABLED, true));
			}
		}
		
		// Just Getting things out of the way
		private function muteSpeakers():void {
			var transform1:SoundTransform=new SoundTransform();
			transform1.volume=0; // goes from 0 to 1
			flash.media.SoundMixer.soundTransform=transform1;
		}
		
		private function initializeMicRecorder():void {
			muteSpeakers();
			mic = Microphone.getMicrophone();
			mic.setSilenceLevel(0);
			mic.gain = 100;
			mic.setLoopBack(true);
			mic.setUseEchoSuppression(true); 
		}
		
	}
	
}