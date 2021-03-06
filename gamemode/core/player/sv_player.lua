
function GM:PlayerSpawn(Player)
	if Player.m_ShouldSpawnAsSpectator then
		Player.m_ShouldSpawnAsSpectator = nil
		return Player:KillSilent()
	end
	hook.Call( "ChoosePlayerClass", GAMEMODE, Player )
	player_manager.OnPlayerSpawn( Player )
	player_manager.RunClass( Player, "Spawn" )
	hook.Call( "PlayerSetModel", GAMEMODE, Player )
	hook.Call( "PlayerLoadout", GAMEMODE, Player )
	hook.Call("Lava.PostPlayerSpawn", nil, Player )
	Player:Extinguish()
	Player:SetCustomCollisionCheck( true )
	Player:CollisionRulesChanged()
end

function GM:ChoosePlayerClass( Player )
	player_manager.SetPlayerClass( Player, "lava_default" )
end

function GM:PlayerLoadout( Player )
	Player:Give("lava_fists")
end

function GM:PlayerSetModel( Player )
	if Player:IsLavaCreator() then
		Player:SetModel( "models/player/monk.mdl" )
		Player:SetPlayerColor( Vector( 0.75, 0, 0 ) )
		Player:SetupHands()
		return
	end
	Player:SetModel(("models/player/Group01/male_0${1}.mdl"):fill(math.random(1, 9)))
	Player:SetPlayerColor(Vector((1):random(255) / 255, (1):random(255) / 255, (1):random(255) / 255))
	Player:SetupHands()
end

function GM:PlayerInitialSpawn( Player )
	if Rounds.CurrentState ~= "Preround" then
		Player.m_ShouldSpawnAsSpectator = true
	end
end