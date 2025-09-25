package;

import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxState;
import flixel.FlxG;
import objects.Basketball;
import openfl.system.System;
import js.Browser; // Note to Self: COMMENT OUT WHEN BUILDING DESKTOP
import flixel.util.FlxSave;

class PlayState extends FlxState
{

	var basketball:Basketball;

	var baskPosX:Float;

	var ScoreText:FlxText;

	public var ScoreValue:Float;

	var HealthText:FlxText;

	public var HealthValue:Float = 5;

	var HighScoreText:FlxText;

	var HighScoreValue:Float;

	var save:FlxSave;

	var SpawnTime:Float = 1;

	//var BasketballSpeed:Float = 10;

	override public function create()
	{
		super.create();

		save = new FlxSave();

		// Basketball code
		var Basketballtimer = new FlxTimer();

		Basketballtimer.start(SpawnTime, function(t:FlxTimer):Void {
            spawnBasketball();
        }, 0);

		if (save.bind("HighScore"))
		{
			HighScoreValue = save.data.HighScore != null ? save.data.HighScore : 0;
		} else {
			HighScoreValue = 0;
		}

		ScoreValue = 0; // Html5 is buggy with this stuff for some reason? So declared the value to be 0 again

		spawnBasketball();

		// BgColor
		bgColor = 0xFF00AEFF;


		var Difficultytimer = new FlxTimer();

		Difficultytimer.start(5, function(t:FlxTimer):Void {
            DifficultyIncrease();
        }, 0);


		// Score Text
		ScoreText = new FlxText(2, 0, 0, "Score: ", 50, false);
		HealthText = new FlxText(1000, 0, 0, "Score: ", 50, false);
		HighScoreText = new FlxText(2, 650, 0, "High Score: ", 50, false);
		add(ScoreText);
		add(HealthText);
		add(HighScoreText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		//trace("Current Score is: " + ScoreValue);

		ScoreText.text = "Score: " + ScoreValue;
		HealthText.text = "Health: " + HealthValue;
		HighScoreText.text = "High Score: " + HighScoreValue;

		if (basketball.overlapsPoint(FlxG.mouse.getViewPosition()))
        {
            if (FlxG.mouse.justPressed)
            {
                trace("Basketball clicked!!!");
				ScoreValue += 10;
				basketball.Speed = -10;
            }
        }

		if (HealthValue < 1)
		{
			// HTML5 NOTE TO SELF: COMMENT WHEN BUILDING DESKTOP
			Browser.alert("You Suck lol\nRefresh the page");
			throw "The FitnessGram Pacer test is a multistage aerobic capacity test that progressively gets more difficult as it continues. The 20 meter Pacer test will begin in 30 seconds. Line up at the start. The running speed starts slowly, but gets faster each minute after you hear this signal *boop*. A single lap should be completed each time you hear this sound *ding*. Remember to run in a straight line, and run as long as possible. The second time you fail to complete a lap before the sound, your test is over. The test will begin on the word start. On your mark, get ready, start.";
			// Desktop, comment out when exporting to html5
			trace ("The FitnessGram Pacer test is a multistage aerobic capacity test that progressively gets more difficult as it continues. The 20 meter Pacer test will begin in 30 seconds. Line up at the start. The running speed starts slowly, but gets faster each minute after you hear this signal *boop*. A single lap should be completed each time you hear this sound *ding*. Remember to run in a straight line, and run as long as possible. The second time you fail to complete a lap before the sound, your test is over. The test will begin on the word start. On your mark, get ready, start.");
			throw "You Suck lol";
		}

		if (ScoreValue > HighScoreValue)
		{
			HighScoreValue = ScoreValue;
			save.data.HighScore = HighScoreValue;
			save.flush();
		}
	}

	function spawnBasketball()
	{
		baskPosX = FlxG.random.float(1, 500);

		basketball = new Basketball(baskPosX, -100, this);

		add(basketball);
	}

	function DifficultyIncrease()
	{
		SpawnTime += -0.1;

		if (SpawnTime == 0)
		{
			ScoreValue += 50;
			SpawnTime = 1;
		}
	}
}
