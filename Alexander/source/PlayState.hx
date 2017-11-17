package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class PlayState extends FlxState
{
	private var tiles:FlxTilemap;
	private var player:Player;
	private var platform:FlxSprite;
	private var enemigos:FlxTypedGroup<Enemy>;
	private var plataformaSube:FlxTypedGroup<PlatUp>;
	private var plataformaBaja:FlxTypedGroup<PlatDown>;
	override public function create():Void
	{
		super.create();
		
		enemigos = new FlxTypedGroup<Enemy>();
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.LEVLGUAN__oel);
		tiles = loader.loadTilemap(AssetPaths.Nube__png, 32, 32, "TAILS");
		tiles.setTileProperties(0, FlxObject.NONE);
		tiles.setTileProperties(1, FlxObject.ANY);
		tiles.setTileProperties(2, FlxObject.ANY);
		loader.loadEntities(placeEntities, "ENTITI");
		
		add(tiles);
		add(enemigos);
		add(plataformaSube);
		add(plataformaBaja);
		add(player);
		
		player = new Player(300, 100);
		
		platform = new FlxSprite(40, 300);
		platform.makeGraphic(560, 32);
		platform.immovable = true;
		FlxTween.tween(platform, {y:100, alpha:0}, 5, {type: FlxTween.LOOPING, ease: FlxEase.backIn});//JAJA 
		add(platform);
		add(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(platform, player);
		FlxG.collide(player, tiles);
	}
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var X:Int = Std.parseInt(entityData.get("x"));
		var Y:Int = Std.parseInt(entityData.get("y"));
		
		switch (entityName)
		{
			case "Player":
				player = new Player(X, Y);
			case "Enemy":
				var e:Enemy = new Enemy(X, Y);
				e.makeGraphic(32, 32, 0xff00ff00);
				enemigos.add(e);
			case "Plat":
				var p:PlatUp = new PlatUp(X, Y);
				p.makeGraphic(32, 32, 0xff11ff32);
			case "Plat2":
			var t:PlatDown = new PlatDown(X, Y);
			t.makeGraphic(32, 32, 0xff11ff32);
		}	
	}
}