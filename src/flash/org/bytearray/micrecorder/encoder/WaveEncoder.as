package org.bytearray.micrecorder.encoder
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import org.bytearray.micrecorder.IEncoder;
	
	public class WaveEncoder implements IEncoder
	{
		private static const RIFF:String = "RIFF";	
		private static const WAVE:String = "WAVE";	
		private static const FMT:String = "fmt ";	
		private static const DATA:String = "data";	
		
		private var _bytes:ByteArray = new ByteArray();
		private var _buffer:ByteArray = new ByteArray();
		private var _volume:Number;
		private var _channels:int;
		private var _bits:int;
		private var _rate:int;
		/**
		 * 
		 * @param volume
		 * 
		 */		
		public function WaveEncoder( volume:Number=1, channels:int=1, bits:int=16, rate:int=22050 )
		{
			_volume = volume;
			_channels = channels;
			_bits = bits;
			_rate = rate;
		}
		
		/**
		 * 
		 * @param samples
		 * @param channels
		 * @param bits
		 * @param rate
		 * @return 
		 * 
		 */		
		public function encode( samples:ByteArray, channels:int=2, bits:int=16, rate:int=44100 ):ByteArray
		{
			var data:ByteArray = create( samples );
			
			_bytes.length = 0;
			_bytes.endian = Endian.LITTLE_ENDIAN;
			
			_bytes.writeUTFBytes( WaveEncoder.RIFF );
			_bytes.writeInt( uint( data.length + 44 ) );
			_bytes.writeUTFBytes( WaveEncoder.WAVE );
			_bytes.writeUTFBytes( WaveEncoder.FMT );
			_bytes.writeInt( uint( 16 ) );
			_bytes.writeShort( uint( 1 ) );
			_bytes.writeShort( _channels );
			_bytes.writeInt( _rate );
			_bytes.writeInt( uint( _rate * _channels * ( _bits >> 3 ) ) );
			_bytes.writeShort( uint( _channels * ( _bits >> 3 ) ) );
			_bytes.writeShort( _bits );
			_bytes.writeUTFBytes( WaveEncoder.DATA );
			_bytes.writeInt( data.length );
			_bytes.writeBytes( data );
			_bytes.position = 0;
			
			return _bytes;
		}
				
		private function create( bytes:ByteArray ):ByteArray
		{
			_buffer.endian = Endian.LITTLE_ENDIAN;
			_buffer.length = 0;
			bytes.position = 0;
			
			while( bytes.bytesAvailable ) 
				_buffer.writeShort( bytes.readFloat() * (0x7fff * _volume) );
			return _buffer;
		}
	}
}