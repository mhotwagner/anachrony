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
	
	public class Recorder extends Sprite {
		
		private var muted:Boolean = true;
		private var recording:Boolean = false;
		private var mic:Microphone;
		private var wavEncoder:WaveEncoder = new WaveEncoder();
		private var micRecorder:MicRecorder = new MicRecorder(wavEncoder);
		private var fileReference:FileReference = new FileReference();
		
		public function Recorder() {
			muteSpeakers();
			
			mic = Microphone.getMicrophone();
			mic.setSilenceLevel(0);
			mic.gain = 100;
			mic.setLoopBack(true);
			mic.setUseEchoSuppression(true); 
			
			mic.addEventListener(StatusEvent.STATUS, this._statusHandler, false, 0, true);
			
			Security.showSettings("2");
		}
		
		public function getActivityLevel():Number {
			return mic.activityLevel;
		}
		
		public function isMuted():Boolean {
			return muted;
		}
		
		public function getDataURL():String {
			return 'data:audio/wav;base64,' + Base64.encode(micRecorder.output);
		}
		
		public function startRecording():void {
			ExternalInterface.call('flashLog', 'Recorder.startRecording()');
			if (!recording) {
				recording = true;
				micRecorder.record();
			}
		}
		
		public function stopRecording():void {
			ExternalInterface.call('flashLog', 'Recorder.stopRecording()');
			if (recording) {
				recording = false;
				micRecorder.stop();
				mic.setLoopBack(false);
				dispatchEvent(new Event('Recorder.stoppedRecording', true));
			}
		}
		
		/*public function save(filename:String = 'recording'):void {
			fileReference.save(micRecorder.output, filename + '.wav');
		}*/
		
		/*public function isRecording():Boolean {
			return recording;
		}*/
		
		private function _statusHandler(e:StatusEvent):void {
			if (e.code == "Microphone.Unmuted"){
				muted = false;
				mic.removeEventListener(StatusEvent.STATUS, this._statusHandler);
				dispatchEvent(new Event('Recorder.enabled', true));
			} else if (e.code == "Microphone.Muted") {
				muted = true;
				mic.removeEventListener(StatusEvent.STATUS, this._statusHandler);
				dispatchEvent(new Event('Recorder.disabled', true));
			}
		}
		
		// We should try to get rid of this
		private function muteSpeakers():void {
			var transform1:SoundTransform=new SoundTransform();
			transform1.volume=0; // goes from 0 to 1
			flash.media.SoundMixer.soundTransform=transform1;
		}
		
	}
	
}