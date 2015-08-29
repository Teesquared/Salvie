package 
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * Menu
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class Menu extends Screen 
	{
		/**
		 * Menu
		 */
		public function Menu() 
		{
			super();
		}

		/**
		 * onAddedToStage
		 * @param	e
		 */
		protected override function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);

			stage.addEventListener(MouseEvent.CLICK, onClickStage);
		}

		/**
		 * onClickStage
		 *
		 * @param	e
		 */
		private function onClickStage(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.CLICK, onClickStage);

			S.play();
		}
	}
}
