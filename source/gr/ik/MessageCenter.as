package gr.ik.messages 
{
	import flash.utils.Dictionary;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.DisplayObject;
	
	public class MessageCenter 
	{
		private var _owner:Object;
		private var messengers:Dictionary;
		
		public function MessageCenter(owner:Object) 
		{
			_owner = owner;
			messengers = new Dictionary();
		}
		public function subscribe(messageType:String, 
								  receiver:Function, 
								  once:Boolean = false):void
		{
			var subscription:Subscription = new Subscription(messageType, receiver, once);
			if(messengers[messageType])
			{
				messengers[messageType].addSubscription(subscription);
				return;
			}
			
			var messenger:Messenger = new Messenger(messageType, this);
			messengers[messageType] = messenger;
			messenger.addSubscription(subscription);
		}
		public function unsubscribe(messageType:String, receiver:Function):void
		{
			if(messengers[messageType] == undefined)
				return;
			
			messengers[messageType].removeSubscriptionWithReceiver(receiver);
		}
		internal function removeMessengerForType(type:String):void
		{
			if(messengers[type] == undefined)
				return;
			
			messengers[type].destroy();
			delete messengers[type];
		}
		public function send(messageType:String, bubbles:Boolean = false, ...args):void
		{
			if(messengers[messageType] == undefined)
			{
				if(!bubbles)return;
				
				if(_owner is DisplayObject)
				{
					var parent:DisplayObjectContainer = (_owner as DisplayObject).parent;
					if(!parent || !(parent is IMessageEnabled))return;
					
					args.unshift(messageType, bubbles);
					(parent as IMessageEnabled).msgc.send.apply(null, args);				
				}
				return;
			}
			
			messengers[messageType].deliver(args);
		}
		public function clearSubscriptions():void
		{
			for(var type:String in messengers)
				removeMessengerForType(type);
		}
		public function destroy():void
		{
			clearSubscriptions();
			messengers = null;
			_owner = null;
		}
	}
	
}
