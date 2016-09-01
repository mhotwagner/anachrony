package {
	import flash.display.Sprite;
	import flash.media.Microphone;
	import flash.system.Security;
	import org.bytearray.micrecorder.*;
	import org.bytearray.micrecorder.events.RecordingEvent;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import flash.events.Event;
	import flash.events.ActivityEvent;
	import flash.net.FileReference;	
	public class Recorder extends Sprite {
		
		private var mic:Microphone;
		private var wavEncoder:WaveEncoder = new WaveEncoder();
		private var recorder:MicRecorder = new MicRecorder(wavEncoder);
		private var fileReference:FileReference = new FileReference();
		
		private var index:Number = 0;
		
		public function Recorder() {
			trace('RECORDER initializing...');
			mic = Microphone.getMicrophone();
			trace(mic)
			mic.setSilenceLevel(0);
			mic.gain = 100;
			mic.setLoopBack(true);
			mic.setUseEchoSuppression(true);
			
			Security.showSettings("2");
			//addListeners();
		}
		
		public function start():void {
			if (mic != null) {
				trace('RECORDER beginning capt†ture...');
				recorder.record();
			}
		}
		
		public function stop():void {
			trace('RECORDER completing capture...');
			recorder.stop();
			mic.setLoopBack(false);
			save();
		}
		
		public function getStatus():Number {
			return mic.activityLevel;
		}
		
		public function save(filename:String = 'recording'):void {
			trace('RECORDER saving audio to file...');
			fileReference.save(recorder.output, filename + '.wav');
		}

	}
	
}