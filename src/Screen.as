package
{
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * Screen
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class Screen extends MovieClip
	{
		protected var S:Salvie;

		/**
		 * Screen
		 */
		public function Screen()
		{
			super();

			S = parent as Salvie;

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		/**
		 * onAddedToStage
		 * @param	e
		 */
		protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
	}
}
