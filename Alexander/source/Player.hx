package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Nai
 */
enum Estado{
	IDLE;
	RUN;
	JUMP;
}
class Player extends FlxSprite
{
	private var state:Estado = Estado.IDLE;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);

		loadGraphic(AssetPaths.Gris2__png,true,32, 32);

		scale.set(2, 2);
		updateHitbox();

		animation.add("idle", [0,1,2], 4, false);
		animation.add("run", [0,1,2], 8, true);
		animation.add("jump", [0,1,2],8, false);
		animation.play("idle");

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		acceleration.y = 1500;
	}
	override public function update(elapsed:Float):Void
	{
		stateMachine();
		super.update(elapsed);
	}
	private function stateMachine()
	{
		switch(state)
		{
			case Estado.IDLE:
				jump();
				hMove();
				if (velocity.y != 0)
				{
					state = Estado.JUMP;
				}
				else if (velocity.x != 0)
				{
					state = Estado.RUN;
				}
			case Estado.JUMP:
				hMove();
				if (velocity.y == 0)
				{
					if (velocity.x != 0)
					{
						state = Estado.RUN;
					}
					else
					{
						state = Estado.IDLE;
					}
				}
			case Estado.RUN:
				jump();
				hMove();
				if (velocity.y != 0)
				{
					state = Estado.JUMP;
				}
				else if (velocity.x == 0)
				{
					state = Estado.IDLE;
				}
		}
	}
	private function jump():Void
	{
		if (FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR))
		{
			velocity.y -= 500;
			animation.play("jump");
			state = Estado.JUMP;
		}
	}

	private function hMove():Void
	{
		velocity.x = 0;

		if (FlxG.keys.pressed.RIGHT)
			velocity.x += 300;
		if (FlxG.keys.pressed.LEFT)
			velocity.x -= 300;

		if (isTouching(FlxObject.FLOOR) && velocity.y == 0)
		{
			if (velocity.x != 0)
			{
				animation.play("run");
				facing = (velocity.x > 0) ? FlxObject.RIGHT : FlxObject.LEFT;
			}
			else
				animation.play("idle");
		}
	}

}