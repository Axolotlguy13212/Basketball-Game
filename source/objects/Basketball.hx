package objects;

import flixel.FlxSprite;
import flixel.FlxG;
import PlayState;

class Basketball extends FlxSprite
{

    public var Speed:Float = 10;

    var playState:PlayState;

    public function new(x:Float, y:Float, state:PlayState)
    {
        super(x, y);

        this.loadGraphic("assets/images/Basketball.png");

        this.scale.set(0.5, 0.5);

        this.updateHitbox();

        playState = state;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        this.y += Speed;

        //trace(this.y);

        if (this.y < -1580) // If the basketball goes off the screen, destroy so memory doesn't explode
        {
            this.destroy();
        }
		if (this.y > 800)
		{
            playState.ScoreValue += -10;
            playState.HealthValue += -1;
            trace("Basketball X is greater than 800!");
		}
        if (this.y > 805)
        {
            this.destroy();
            trace("Basketball has been destroyed");
        }
    }
}