package {
	
	import Recorder;
	import RecorderAPI;
	import flash.display.MovieClip;

	public class Main extends MovieClip {
		
		var frame:Number = 0;
		var recorder:Recorder = new Recorder();
		var recorderAPI:RecorderAPI;

		public function Main() {
			recorderAPI = new RecorderAPI(recorder);
		}
		
	}
	
}