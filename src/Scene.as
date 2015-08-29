package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Video;
	import flash.text.TextField;

	/**
	 * Scene
	 *
	 * Copyright (C) 2015, Twisted Words, LLC
	 *
	 * @author Tony Tyson (teesquared@twistedwords.net)
	 */
	public class Scene extends Screen 
	{
		CONFIG::FLASH_VAR {
			var player:MovieClip;

			var title:TextField;

			var action1:TextField;
			var action2:TextField;
			var action3:TextField;
			var action4:TextField;
			var action5:TextField;
			var action6:TextField;

			var scene1:TextField;
			var scene2:TextField;
			var scene3:TextField;
			var scene4:TextField;
			var scene5:TextField;
			var scene6:TextField;
			
			var story:MovieClip;
		}
		
		private var currentSceneName:String = "Drawing";
		
		private const sceneConfigs:Array = [
			{
				title: "Drawing",
				video: "assets/videos/TheDrawing.flv",
				label: "Drawing",
				locked: false,
				completed: false,
				showEnding: false,
				actions: [
					{
						text: "Make birds chirp",
						label: "Birds"
					},
					{
						text: "Knock on window",
						label: "Knock"
					},
					{
						text: "Make wind blow",
						label: "Wind"
					},
					{
						text: "Do nothing",
						label: "Nothing"
					}
				],
				scenes: [
					"ThePark",
					"SoProud"
				]
			},
			{
				title: "The Park",
				video: "assets/videos/ThePark.flv",
				label: "ThePark",
				locked: false,
				completed: false,
				showEnding: false,
				actions: [
					{
						text: "Father",
						label: "Father",
						unlocks: ["SoProud"]
					},
					{
						text: "Sadness",
						label: "Sadness",
						unlocks: ["SoProud"]
					},
					{
						text: "Life",
						label: "Life",
						unlocks: ["SoProud"]
					}
				],
				scenes: [
					"Drawing",
					"SoProud"
				]
			},
			{
				title: "So Proud",
				video: "assets/videos/Twirling.flv",
				label: "SoProud",
				locked: true,
				completed: false,
				showEnding: false,
				actions: [
					{
						text: "Her Mind",
						label: "Mind",
						completes: ["Drawing"],
						unlocks: ["FamilyRoom"]
					},
					{
						text: "Her Heart",
						label: "Heart",
						completes: ["Drawing"],
						unlocks: ["FamilyRoom"]
					}
				],
				scenes: [
					"Drawing",
					"ThePark",
					"FamilyRoom"
				]
			},
			{
				title: "Family Room",
				video: "assets/videos/FamilyRoom.flv",
				label: "FamilyRoom",
				locked: true,
				completed: false,
				showEnding: false,
				actions: [
					{
						text: "Hide Remote",
						label: "Remote"
					},
					{
						text: "Hide Phone",
						label: "Phone"
					}
				],
				scenes: [
					"Nightmare"
				]
			},
			{
				title: "Nightmare",
				video: "assets/videos/Nightmare.flv",
				label: "Nightmare",
				locked: false,
				completed: false,
				showEnding: false,
				actions: [
					{
						text: "Forgive Me",
						label: "Forgive",
						completes: ["FamilyRoom"],
						unlocks: ["HerEyes"]
					},
					{
						text: "Help Me",
						label: "Help",
						completes: ["FamilyRoom"],
						unlocks: ["HerEyes"]
					}
				],
				scenes: [
					"FamilyRoom",
					"HerEyes"
				]
			},
			{
				title: "Her Eyes",
				video: "assets/videos/HerEyes.flv",
				label: "HerEyes",
				locked: true,
				completed: false,
				showEnding: false,
				actions: [
					{
						text: "Salvation",
						label: "Salvation"
					}
				],
				scenes: []
			},
			{
				title: "Close Your Eyes",
				label: "TheEnd",
				locked: false,
				completed: false,
				showEnding: true,
				actions: [],
				scenes: []
			}
		];

		private var configMap:Object = { };
		private var sceneMap:Object = { };
		private var actionMap:Object = { };

		private var actionText:Vector.<TextField>;
		private var sceneText:Vector.<TextField>;
		
		private var gameOver:Boolean = false;

		/**
		 * Scene
		 */
		public function Scene() 
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

			actionText = new <TextField> [
				action1,
				action2,
				action3,
				action4,
				action5,
				action6
			];

			sceneText = new <TextField> [
				scene1,
				scene2,
				scene3,
				scene4,
				scene5,
				scene6
			];

			for each (var action:TextField in actionText) {
				action.addEventListener (MouseEvent.CLICK, onClickAction);
			}

			for each (var scene:TextField in sceneText) {
				scene.addEventListener (MouseEvent.CLICK, onClickScene);
			}

			for each (var config:Object in sceneConfigs) {
				configMap[config.label] = config;
			}

			setScene("Drawing");
		}

		/**
		 * setScene
		 * 
		 * @param	int n
		 */
		private function setScene(sceneName:String):void
		{
			var config:Object = configMap[sceneName];
			
			if (config.showEnding) {
				S.play();
				return;
			}

			currentSceneName = sceneName;

			title.text = config.title;

			updateActions(sceneName);

			updateScenes(sceneName);

			story.gotoAndStop(config.label);

			player.gotoAndStop(config.label);
		}

		/**
		 * updateActions
		 */
		private function updateActions(sceneName:String):void
		{
			var config:Object = configMap[sceneName];
			
			var a:int = 0;
			
			actionMap = { };
			
			hideActions();
			
			for each (var action:Object in config.actions) {
				actionText[a].visible = true;
				actionText[a].text = action.text;
				actionMap[actionText[a].name] = action;
				++a;
			}
		}

		/**
		 * updateScenes
		 */
		private function updateScenes(sceneName:String):void
		{
			var config:Object = configMap[sceneName];
			
			var s:int = 0;
			
			hideScenes();

			sceneMap = { };

			for each (var scene:String in config.scenes) {

				if (configMap[scene].completed || configMap[scene].locked)
					continue;

				sceneText[s].visible = true;
				sceneText[s].text = configMap[scene].title;
				sceneMap[sceneText[s].name] = scene;
				++s;
			}
			
			gameOver = s == 0;
		}

		/**
		 * hideActions
		 */
		private function hideActions():void
		{
			for each (var action:TextField in actionText) {
				action.visible = false;
			}
		}

		/**
		 * hideScenes
		 */
		private function hideScenes():void
		{
			for each (var scene:TextField in sceneText) {
				scene.visible = false;
			}
		}

		/**
		 * hideAll
		 */
		private function hideAllText():void
		{
			hideActions();
			hideScenes();
		}

		/**
		 * onClickAction
		 * 
		 * @param	e
		 */
		private function onClickAction(e:MouseEvent):void 
		{
			var actionText:TextField = e.target as TextField;

			if (actionText == null)
				return;

			//trace("onClickAction", e.target.name, e);

			hideActions();

			var action:Object = actionMap[actionText.name];
			var config:Object = configMap[currentSceneName];

			config.completed = true;

			var storyLabel:String = config.label + action.label;

			story.gotoAndStop(storyLabel);
			
			var sceneName:String
			
			if (action.unlocks) {
				for each (sceneName in action.unlocks)
					configMap[sceneName].locked = false;
			}

			if (action.completes) {
				for each (sceneName in action.completes)
					configMap[sceneName].completed = true;
			}

			updateScenes(currentSceneName);

			if (gameOver) {
				var scene:String = "TheEnd";
				scene1.visible = true;
				scene1.text = configMap[scene].title;
				sceneMap[scene1.name] = scene;
			}
			
		}

		/**
		 * onClickScene
		 * 
		 * @param	e
		 */
		private function onClickScene(e:MouseEvent):void 
		{
			var sceneText:TextField = e.target as TextField;

			if (sceneText == null)
				return;

			//trace("onClickScene", scene.name, e);

			setScene(sceneMap[sceneText.name]);
		}
	}
}
