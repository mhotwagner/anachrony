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
	import flash.external.ExternalInterface;
	public class Recorder extends Sprite {
		
		private var initialized:Boolean = false;
		private var listening:Boolean = false;
		private var recording:Boolean = false;
		private var mic:Microphone;
		private var wavEncoder:WaveEncoder = new WaveEncoder();
		private var recorder:MicRecorder = new MicRecorder(wavEncoder);
		private var fileReference:FileReference = new FileReference();
		
		private var index:Number = 0;
		
		public function Recorder() {
			ExternalInterface.call('flashLog', '<Recorder> Instantiating...');
			trace('RECORDER instantiating...');
			muteSpeakers();
			mic = Microphone.getMicrophone();
			trace(mic);
			//addListeners();
		}
		
		public function init():void {
			ExternalInterface.call('flashLog', '<Recorder> Initializing');
			trace('RECORDER initializing...');
			initialized = true;
			mic.setSilenceLevel(0);
			mic.gain = 100;
			mic.setLoopBack(true);
			mic.setUseEchoSuppression(true); 
			
			Security.showSettings("2");
			listening = true;
		}
		
		public function start():void {
			if (!initialized) {
				init();
			}
			if (mic != null && !recording) {
				ExternalInterface.call('flashLog', '<Recorder> Starting');
				trace('RECORDER beginning capt†ture...');
				recording = true;
				recorder.record();
			}
		}
		
		public function stop():void {
			if (recording) {
				recording = false;
				ExternalInterface.call('flashLog', '<Recorder> Stopping');
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
			ExternalInterface.call('flashLog', '<Recorder> Reporting Status { activityLevel: ' + mic.activityLevel.toString() + '}');
			trace('trying to call this?');
			return mic.activityLevel;
		}
		
		public function save(filename:String = 'recording'):void {
			ExternalInterface.call('flashLog', '<Recorder> Saving');
			trace('RECORDER saving audio to file...');
			fileReference.save(recorder.output, filename + '.wav');
		}
		
		public function isRecording():Boolean {
			return recording;
		}
		
		public function isListening():Boolean {
			return listening;
		}
		
		private function muteSpeakers():void {
			var transform1:SoundTransform=new SoundTransform();
			transform1.volume=0; // goes from 0 to 1
			flash.media.SoundMixer.soundTransform=transform1;
		}


	}
	
}