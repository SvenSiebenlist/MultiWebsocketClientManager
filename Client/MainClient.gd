extends Control

var UserClient = preload("res://Client/UserClient.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	get_window().size = Vector2(380,128);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;


func _on_button_pressed():
	var host = %ConnectHost.text;
	var port = int(%ConnectPort.text);
	
	get_window().set_embedding_subwindows(false);
	var userWindow:UserClient = UserClient.instantiate();
	userWindow.visible = true;
	userWindow.position = get_screen_position();
	
	userWindow.size = Vector2(1150,650);
	userWindow.position.x -= userWindow.size.x + 10;
	userWindow.title = str("WebSocket CLIENT ", host, ":", port);
	
	var networking = userWindow.getNetworkHandler();
	
	var status = networking.connectTo(host, port);
	print("ERROR: ", status);
	
	
	add_child(userWindow);
	
	pass # Replace with function body.
