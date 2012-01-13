package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.components.Motion;
	import net.richardlord.asteroids.components.MotionControls;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.MotionControlNode;
	import net.richardlord.input.KeyPoll;

	public class MotionControlSystem extends System
	{
		private var keyPoll : KeyPoll;
		
		private var nodes : NodeList;

		public function MotionControlSystem( keyPoll : KeyPoll )
		{
			this.keyPoll = keyPoll;
			priority = SystemPriorities.update;
		}

		override public function addToGame( game : Game ) : void
		{
			nodes = game.getNodeList( MotionControlNode );
		}
		
		override public function update( time : Number ) : void
		{
			var node : MotionControlNode;
			var control : MotionControls;
			var position : Position;
			var motion : Motion;

			for ( node = nodes.head; node; node = node.next )
			{
				control = node.control;
				position = node.position;
				motion = node.motion;

				if ( keyPoll.isDown( control.left ) )
				{
					position.rotation -= control.rotationRate * time;
				}

				if ( keyPoll.isDown( control.right ) )
				{
					position.rotation += control.rotationRate * time;
				}

				if ( keyPoll.isDown( control.accelerate ) )
				{
					motion.velocity.x += Math.cos( position.rotation ) * control.accelerationRate * time;
					motion.velocity.y += Math.sin( position.rotation ) * control.accelerationRate * time;
				}
			}
		}

		override public function removeFromGame( game : Game ) : void
		{
			nodes = null;
		}
	}
}
