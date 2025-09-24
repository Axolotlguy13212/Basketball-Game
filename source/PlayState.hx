package;

import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxState;
import flixel.FlxG;
import objects.Basketball;
import openfl.system.System;
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

		spawnBasketball();

		// BgColor
		bgColor = 0xFF00AEFF;


		var Difficultytimer = new FlxTimer();

		Difficultytimer.start(5, function(t:FlxTimer):Void {
            DifficultyIncrease();
        }, 0);


		// Score Text
		ScoreText = new FlxText(0, 0, 0, "Score: ", 50, false);
		HealthText = new FlxText(670, 0, 0, "Score: ", 50, false);
		HighScoreText = new FlxText(0, 650, 0, "High Score: ", 50, false);
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
			System.exit(0);
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
