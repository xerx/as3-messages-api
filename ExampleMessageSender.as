package  
{
	import gr.ik.messages.MessageCenter;
	import gr.ik.messages.IMessageEnabled;
	import gr.ik.messages.Message;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	public class ExampleMessageSender implements IMessageEnabled
	{
		private var messageCenter:MessageCenter;
		private var intervalID:int;
		
		public function ExampleMessageSender() 
		{
			messageCenter = new MessageCenter(this);
		}
		public function sendSimple():void
		{
			messageCenter.send(Message.UPDATED);
		}
		public function sendWithArgs():void
		{
			messageCenter.send(Message.UPDATED, false, this, new Date(), "Hello");
		}
		public function sendRepeatedly():void
		{
			var timesSent:int = 0;
			intervalID = setInterval(function()
			{
				messageCenter.send(Message.UPDATED, false, ++timesSent);
				if(timesSent == 3)
				{
					clearInterval(intervalID);
				}
			}, 1000);
		}
		public function get msgc():MessageCenter		
		{
			return messageCenter;
		}

	}
	
}
