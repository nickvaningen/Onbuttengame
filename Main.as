package {
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;

	public class Main extends MovieClip {


		const gravity: Number = 4;
		const dist_btw_obstacles: Number = 200;
		const ob_speed: Number = 7;
		const jump_force: Number = 27;

		
		var player: Player = new Player();
		var lastob: Obstacle = new Obstacle();
		var obstacles: Array = new Array();
		var yspeed: Number = 0;
		var score: Number = 0;
		var space: Boolean = false;
		var start: Start = new Start();

		public function Main() {
			init();
		}

		function init(): void {

			player = new Player();
			lastob = new Obstacle();
			obstacles = new Array();
			yspeed = 0;
			score = 0;


			player.x = stage.stageWidth / 4;
			player.y = stage.stageHeight / 4;
			addChild(player);


			createObstacle();
			createObstacle();
			createObstacle();
			createObstacle();
			createObstacle();

			addChild(start);


			addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down);
		}

		private function key_down(event: KeyboardEvent) {
			if (event.keyCode == Keyboard.SPACE && !space) {

				space = true;
				yspeed = -jump_force;
				if (contains(start))
					removeChild(start);

			}

			if (space) {
				space = false;
			}
		}


		function restart() {
			if (contains(player))
				removeChild(player);
			for (var i: int = 0; i < obstacles.length; ++i) {
				if (contains(obstacles[i]) && obstacles[i] != null)
					removeChild(obstacles[i]);
				obstacles[i] = null;
			}
			obstacles.slice(0);
			init();
		}

		function onEnterFrameHandler(event: Event) {

			yspeed += gravity;
			player.y += yspeed;


			if (player.y + player.height / 2 > stage.stageHeight) {
				restart();
			}


			if (player.y - player.height / 2 < 0) {
				player.y = player.height / 2;
			}


			for (var i: int = 0; i < obstacles.length; ++i) {
				updateObstacle(i);
			}


			scoretxt.text = String(score);
		}


		function updateObstacle(i: int) {
			var ob: Obstacle = obstacles[i];

			if (ob == null)
				return;
			ob.x -= ob_speed;

			if (ob.x < -ob.width) {
				changeObstacle(ob);
			}


			if (ob.hitTestPoint(player.x + player.width / 2, player.y + player.height / 2, true) || ob.hitTestPoint(player.x + player.width / 2, player.y - player.height / 2, true) || ob.hitTestPoint(player.x - player.width / 2, player.y + player.height / 2, true) || ob.hitTestPoint(player.x - player.width / 2, player.y - player.height / 2, true)) {
				restart();
			}


			if ((player.x - player.width / 2 > ob.x + ob.width / 2) && !ob.covered) {
				++score;
				ob.covered = true;
			}
		}


		function changeObstacle(ob: Obstacle) {
			ob.x = lastob.x + dist_btw_obstacles;
			ob.y = 100 + Math.random() * (stage.stageHeight - 150);
			lastob = ob;
			ob.covered = false;
		}


		function createObstacle() {
			var ob: Obstacle = new Obstacle();
			if (lastob.x == 0)
				ob.x = 800;
			else
				ob.x = lastob.x + dist_btw_obstacles;
			ob.y = 100 + Math.random() * (stage.stageHeight - 150);
			addChild(ob);
			obstacles.push(ob);
			lastob = ob;
		}


	}
}