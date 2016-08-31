package  
{
	import gr.ik.messages.Message;
	import gr.ik.messages.IMessageEnabled;
	
	public class ExampleMessageReceiver
	{
		private var sender:ExampleMessageSender;
		
		public function ExampleMessageReceiver() 
		{
			sender = new ExampleMessageSender();
			
			sender.msgc.subscribe(Message.UPDATED, simpleReceiver);
			sender.sendSimple();
			sender.msgc.unsubscribe(Message.UPDATED, simpleReceiver);
			
			sender.msgc.subscribe(Message.UPDATED, receiverWithArgs);
			sender.sendWithArgs();
			sender.msgc.unsubscribe(Message.UPDATED, receiverWithArgs);
			
			sender.msgc.subscribe(Message.UPDATED, onceReceiver, true);
			sender.sendRepeatedly();
		}
		private function simpleReceiver():void
		{
			trace("Received a simple message.");
		}
		private function receiverWithArgs(sender:IMessageEnabled, someDate:Date, someString:String):void
		{
			trace("Received a message with args at: " + someDate);
			trace("The message said: " + someString);
		}
		private function onceReceiver(timesSent:int):void
		{
			trace("Received a repeated message sent " + timesSent + " times.");
		}

	}
	
}
