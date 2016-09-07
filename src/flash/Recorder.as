package {
	import flash.display.Sprite;
	import flash.media.Microphone;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.system.Security;
	import org.bytearray.micrecorder.*;
	import org.bytearray.micrecorder.events.RecordingEvent;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import flash.events.Event;
	import flash.events.ActivityEvent;
	import flash.net.FileReference;	
	public class Recorder extends Sprite {
		
		private var initialized:Boolean = false;
		private var recording:Boolean = false;
		private var mic:Microphone;
		private var wavEncoder:WaveEncoder = new WaveEncoder();
		private var recorder:MicRecorder = new MicRecorder(wavEncoder);
		private var fileReference:FileReference = new FileReference();
		
		private var index:Number = 0;
		
		public function Recorder() {
			trace('RECORDER instantiating...');
			muteSpeakers();
			mic = Microphone.getMicrophone();
			trace(mic);
			//addListeners();
		}
		
		public function init():void {
			trace('RECORDER initializing...');
			initialized = true;
			mic.setSilenceLevel(0);
			mic.gain = 100;
			mic.setLoopBack(true);
			mic.setUseEchoSuppression(true);
			
			Security.showSettings("2");
		}
		
		public function start():void {
			if (!initialized) {
				init();
			}
			if (mic != null && !recording) {
				trace('RECORDER beginning capt†ture...');
				recording = true;
				recorder.record();
			}
		}
		
		public function stop():void {
			if (recording) {
				recording = false;
				trace('RECORDER completing capture...');
				recorder.stop();
				mic.setLoopBack(false);
				save();
			}
		}
		
		public function getStatus():Number {
			if (!initialized) {
				init();
			}
			trace('trying to call this?');
			return mic.activityLevel;
		}
		
		public function save(filename:String = 'recording'):void {
			trace('RECORDER saving audio to file...');
			fileReference.save(recorder.output, filename + '.wav');
		}
		
		public function isRecording():Boolean {
			return recording;
		}
		
		private function muteSpeakers():void {
			var transform1:SoundTransform=new SoundTransform();
			transform1.volume=0; // goes from 0 to 1
			flash.media.SoundMixer.soundTransform=transform1;
		}


	}
	
}