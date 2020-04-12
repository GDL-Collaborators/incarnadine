extends ColorRect

var timeForFade : float = 1
var timeRemaining : float = 1
var viewPort : ViewportContainer
var firedOnFaded : bool = false
var fadeIn : bool = false

func _ready():
	_fade(0.5,true,null)

func _fade(time : float,doFadeIn: bool , tex:Texture):
	if(tex != null):
		material.set_shader_param("animTexure",tex)
	
	timeForFade = time
	timeRemaining = time
	firedOnFaded = false

	if(doFadeIn):
		self.fadeIn = doFadeIn
		timeRemaining = 0

func _process(_delta):
	if(fadeIn): timeRemaining += _delta
	else: timeRemaining -= _delta
	material.set_shader_param("progress",timeRemaining/timeForFade)
	#Call on complete event here
	if((timeRemaining <= 0 and !firedOnFaded and !fadeIn) || (timeRemaining >= timeForFade and !firedOnFaded and fadeIn)):pass

