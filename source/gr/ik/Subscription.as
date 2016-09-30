package gr.rdc.messages 
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
		public function isEqual(subscription:Subscription):Boolean
		{
			if(messageType == subscription.messageType && receiver == subscription.receiver)
				return true;
			return false;
		}
		public function destroy():void
		{
			receiver = null;
		}

	}
	
}
