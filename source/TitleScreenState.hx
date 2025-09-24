package;

import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import PlayState;

class TitleScreenState extends FlxState
{

    var PlayButton:FlxSprite;

    var Title:FlxText;

    var DeleteText:FlxText;

    override function create() {
        super.create();

        bgColor = 0xFF00AEFF;

        PlayButton = new FlxSprite(500, 430);

        var filePath:String = "assets/images/PlayButton/PlayButton";
        PlayButton.frames = FlxAtlasFrames.fromSparrow(filePath + ".png", filePath + ".xml");

        PlayButton.animation.addByPrefix("Normal", "Normal", 24, false, false, false);
        PlayButton.animation.addByPrefix("Hover", "Hover", 24, false, false, false);

        PlayButton.scale.set(0.5, 0.5);
        PlayButton.updateHitbox();

        Title = new FlxText(340, 165, 0, "Basketball Game", 54, false);

        DeleteText = new FlxText(980, 705, 0, "Press Q and E at the same time to delete High Score.", 8, false);

        add(PlayButton);
        add(Title);
        add(DeleteText);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);


		if (PlayButton.overlapsPoint(FlxG.mouse.getViewPosition()))
        {

            PlayButton.animation.play("Hover", true, false, 0);

            if (FlxG.mouse.justPressed)
            {
                FlxG.switchState(PlayState.new);
            }
        } else {
            PlayButton.animation.play("Normal", true, false, 0);
        }
    }
}