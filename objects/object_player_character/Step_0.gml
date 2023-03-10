/// @description Insert description here
// You can write your code in this editor

//Get Player Input
left = keyboard_check(vk_left) || (gamepad_axis_value(0, gp_axislh) < 0);
right = keyboard_check(vk_right) || (gamepad_axis_value(0, gp_axislh) > 0);
jump = keyboard_check_pressed(vk_space) || (gamepad_button_check_pressed(0, gp_face1));

//Calculate Movement
var move = right - left;
hsp = move * walk_speed;
vsp = vsp + grv;

if (place_meeting(x, y + 1, object_wall) && jump) {
	vsp = -7;
}

//Horizontal Collision
if (place_meeting(x + hsp, y, object_wall)) {
	while (!place_meeting(x + sign(hsp), y, object_wall)) {
		x = x + sign(hsp);
	}
	hsp = 0;
}
x = x + hsp;

//Vertical Collision
if (place_meeting(x, y + vsp, object_wall)) {
	while (!place_meeting(x, y + sign(vsp), object_wall)) {
		y = y + sign(vsp);
	}
	vsp = 0;
}
y = y + vsp;

//Animation
image_xscale = -1;
if (!place_meeting(x, y + 1, object_wall)) {
	sprite_index = sprite_player_character_jumping;
	image_speed = 1;
} else {
	image_speed = 1;
	if (left) {
		sprite_index = sprite_player_character_running2;
		image_xscale = 1;
	} else if (right) {
		sprite_index = sprite_player_character_running2;
		image_xscale = -1;
	} else {
		sprite_index = sprite_player_character;
	}
}