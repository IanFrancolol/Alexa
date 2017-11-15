package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class PlayState extends FlxState
{
	private var player:Player;
	private var platform:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		
		player = new Player(300, 100);
		
		platform = new FlxSprite(40, 300);
		platform.makeGraphic(560, 32);
		platform.immovable = true;
		FlxTween.tween(platform, {y:100, alpha:0}, 5, {type: FlxTween.LOOPING/*sirve para hacer patrones con objetos*/, ease: FlxEase.backIn/*el FlxEase sirve para poner efectos*/});//
		
		add(platform);
		add(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(platform, player);
	}
}