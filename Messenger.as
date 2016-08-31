package  gr.ik.messages
{
	
	internal class Messenger 
	{
		private var _type:String;
		private var _owner:MessageCenter;
		private var subscriptions:Vector.<Subscription>;
		
		public function Messenger(type:String, owner:MessageCenter) 
		{
			_type = type;
			_owner = owner;
			subscriptions = new <Subscription>[];
		}
		public function addSubscription(subscription:Subscription):void
		{
			if(subscriptions.indexOf(subscription) > -1)
				return;
			
			subscriptions.push(subscription);
		}
		public function deliver(args:Array):void
		{
			var subscription:Subscription;
			var receiver:Function;
			for(var i:int = 0; i < subscriptions.length; i++)
			{
				subscription = subscriptions[i];
				receiver = subscription.receiver;
				
				if(subscription.once)
					removeSubscriptionWithIndex(i--);
				
				receiver.apply(null, args);
				
				if(!subscriptions)
					return;
			}
		}
		public function removeSubscriptionWithReceiver(receiver:Function):void
		{
			for(var i:int = 0; i < subscriptions.length; i++)
			{
				if(receiver == subscriptions[i].receiver)
				{
					removeSubscriptionWithIndex(i);
					return;
				}
			}
		}
		private function removeSubscriptionWithIndex(index:int):void
		{
			var subscription:Subscription = subscriptions.splice(index, 1)[0];
			subscription.destroy();
			
			if(subscriptions.length == 0)
				_owner.removeMessengerForType(_type);			
		}
		public function destroy():void
		{
			_owner = null;
			
			for(var i:int = 0; i < subscriptions.length; i++)
				subscriptions[i].destroy();
			
			subscriptions = null;
		}
		public function get type():String
		{
			return _type;
		}
	}
	
}
