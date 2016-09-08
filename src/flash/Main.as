package {
	
	import Recorder;
	import RecorderApi;
	import flash.display.MovieClip;

	public class Main extends MovieClip {
		
		var frame:Number = 0;
		var recorder:Recorder = new Recorder();
		var recorderApi:RecorderApi;

		public function Main() {
			recorderApi = new RecorderApi(recorder);
		}
		
	}
	
}