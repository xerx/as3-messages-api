﻿package gr.ik.messages 
{
	
	internal class Subscription 
	{
		public var messageType:String;
		public var receiver:Function;
		public var once:Boolean;
		
		public function Subscription(messageType:String, 
									 receiver:Function, 
									 once:Boolean = false) 
		{
			this.messageType = messageType;
			this.receiver = receiver;
			this.once = once;
		}
		public function destroy():void
		{
			receiver = null;
		}

	}
	
}
