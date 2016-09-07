package {
	
	import flash.external.ExternalInterface;
	import Recorder;
	import RecorderApi;
	import flash.display.MovieClip;
	//import fl.events.Event;
	import flash.events.Event;
	import fl.events.*;

	public class Main extends MovieClip {
		
		var frame:Number = 0;
		var recorder:Recorder = new Recorder();
		var recorderApi:RecorderApi;

		public function Main() {
			ExternalInterface.call('flashLog', '<RecorderApplication> Initializing...');
			recorderApi = new RecorderApi(recorder);
		}
		
		//private function onEnterFrame(e:Event):void {
		//	//this.recorder.update();
		//	switch (frame) {
		//		case 0:
		//			recorder.start();
		//			break;
		//		case 600:
		//			recorder.stop();
		//			break;
		//		default:
		//			trace(frame, ': ', recorder.getStatus());
		//	}
		//	frame++;
		//}
		//
		//private function registerListeners():void {
		//	addEventListener(Event.ENTER_FRAME, onEnterFrame);
		//	//trace('whatever')
		//}

	}

}