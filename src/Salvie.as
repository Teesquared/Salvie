package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	
	/**
	 * Salvie
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class Salvie extends MovieClip 
	{
		private static var soundTheme:Sound = new SoundTheme() as Sound;

		public function Salvie() 
		{
			super();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		/**
		 * onAddedToStage
		 * @param	e
		 */
		protected function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			soundTheme.play(0, 9999);
		}
	}
}
