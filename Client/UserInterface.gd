extends VBoxContainer

var _USER = preload("res://Client/User/User.tscn");
var socket = WebSocketMultiplayerPeer.new();
var known_clients: Array = [];
# Called when the node enters the scene tree for the first time.
func _ready():
	socket.connect("peer_connected", Callable(self, "_on_peer_connected"));
	socket.connect("peer_disconnected", Callable(self, "_on_peer_disconnected"));
	pass # Replace with function body.

func handleProcess(obj):
	print(get_instance_id(), "GOT: ", obj, "\n");
	
	match obj.action:
		"UPDATE_USER":
			
			known_clients = obj.data;
			
			for user in obj.data: # user means any known device
				var _user: User = _USER.instantiate();
#				_user.position = Vector2(user.position.x, user.position.y);
				_user.ip_addr = user.ip_addr;
				_user.position = _user.addressToPosition();
				_user.modulate = Color(user.color.r, user.color.g, user.color.b, user.color.a);
				%MiniMap.add_child(_user);
				%ItemList.clear()
				%ItemList.add_item(_user.ip_addr);
			pass;
		_:
			pass;
	
	return true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	socket.poll();
	var packets = socket.get_available_packet_count();
	if(packets):
		var raw = socket.get_packet();
		var text = raw.get_string_from_utf8();
		var obj = JSON.parse_string(text);
		var result = handleProcess(obj);
		pass;

func connectTo(host: String, port: int, tls_options = null):
	var status = socket.create_client(str("ws://", host, ":", port), tls_options); # somehow I can't see if I am connected or not :(
	return status;
	
func _on_peer_connected(peerId):
	print("Peer Connected ", peerId);
	
func _on_peer_disconnected(peerId):
	print("Peer DisConnected ", peerId);

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	print("Clicked on computer index=", index);
	%RemoteTitle.text = str("Remote Computer ID: ", known_clients[index].ip_addr);
	pass # Replace with function body.
