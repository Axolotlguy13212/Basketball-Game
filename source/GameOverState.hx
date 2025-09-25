package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;

class GameOverState extends FlxState
{

    var RetryButton:FlxSprite;

    override function create() {
        super.create();

        RetryButton = new FlxSprite(440, 430);

        RetryButton.frames = FlxAtlasFrames.fromSparrow("assets/images/RetryButton.png", "assets/images/RetryButton.xml");

        RetryButton.animation.addByPrefix("Normal", "Normal", 24, false, false, false);
        RetryButton.animation.addByPrefix("Hover", "Hover", 24, false, false, false);

        add(RetryButton);
    }


    override function update(elapsed:Float) {
        super.update(elapsed);

		if (RetryButton.overlapsPoint(FlxG.mouse.getViewPosition()))
        {

            RetryButton.animation.play("Hover", true, false, 0);

            if (FlxG.mouse.justPressed)
            {
                FlxG.switchState(PlayState.new);
            }
        } else {
            RetryButton.animation.play("Normal", true, false, 0);
        }
    }
}