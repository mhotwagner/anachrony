package {
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
	
	public class Recorder extends Sprite {
		
		private var muted:Boolean = true;
		private var recording:Boolean = false;
		private var mic:Microphone;
		private var wavEncoder:WaveEncoder = new WaveEncoder();
		private var recorder:MicRecorder = new MicRecorder(wavEncoder);
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
		
		/*public function start():void {
			if (!recording) {
				recording = true;
				recorder.record();
			}
		}*/
		
		/*public function stop():void {
			if (recording) {
				recording = false;
				recorder.stop();
				mic.setLoopBack(false);
				save();
			}
		}*/
		
		/*public function save(filename:String = 'recording'):void {
			fileReference.save(recorder.output, filename + '.wav');
		}*/
		
		/*public function isRecording():Boolean {
			return recording;
		}*/
		
		private function _statusHandler(e:StatusEvent):void {
			if (e.code == "Microphone.Unmuted"){
				muted = false;
				mic.removeEventListener(StatusEvent.STATUS, this._statusHandler);
				dispatchEvent(new Event('Recorder.Enabled', true));
			} else if (e.code == "Microphone.Muted") {
				muted = true;
				mic.removeEventListener(StatusEvent.STATUS, this._statusHandler);
				dispatchEvent(new Event('Recorder.Disabled', true));
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