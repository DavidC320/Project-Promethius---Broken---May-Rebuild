extends AudioStreamPlayer
# Code by Dava

const tracks = [
	"res://Art/Music/Line Noise - Magenta Moon (Part II).mp3",
	"res://Art/Music/Orquestra Popular De Paio Pires - Nothing Happens.mp3",
	"res://Art/Music/Orquestra Popular De Paio Pires - Tragedy.mp3",
	"res://Art/Music/Wolf Asylum - Hubris.mp3",
	"res://Art/Music/Wolf Asylum - Psyche.mp3"
]

func _ready() -> void:
	randomize()
	
	connect("finished", Callable(self, "play_random_song"))
	play_random_song()
	
func play_random_song():
	randomize()
	
	var music = randi() % tracks.size()
	var audio = load(tracks[music])
	stream = audio
	play()
	
