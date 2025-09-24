package;

import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxState;
import flixel.FlxG;
import objects.Basketball;
import openfl.system.System;

class PlayState extends FlxState
{

	var basketball:Basketball;

	var baskPosX:Float;

	var ScoreText:FlxText;

	public var ScoreValue:Float;

	var HealthText:FlxText;

	public var HealthValue:Float = 5;

	override public function create()
	{
		super.create();

		// Basketball code
		var timer = new FlxTimer();

		timer.start(1, function(t:FlxTimer):Void {
            spawnBasketball();
        }, 0);

		spawnBasketball();

		// BgColor
		bgColor = 0xFF00AEFF;

		// Score Text
		ScoreText = new FlxText(0, 0, 0, "Score: ", 50, false);
		HealthText = new FlxText(670, 0, 0, "Score: ", 50, false);
		add(ScoreText);
		add(HealthText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		trace("Current Score is: " + ScoreValue);

		ScoreText.text = "Score: " + ScoreValue;
		HealthText.text = "Health: " + HealthValue;

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
	}

	function spawnBasketball()
	{
		baskPosX = FlxG.random.float(1, 500);

		basketball = new Basketball(baskPosX, -100, this);

		add(basketball);
	}
}
