//import animation library 
let m = import_lib("mjolnir.so");


overload + (a, b){
	return stringify(a) + stringify(b);
}

m.create_window();

let rect_pos = [0, 0];


//1 is right -1 is left
let direction = 1;
let direction_y = 1;

while(true){
		
	//get time since last frame
	let delta = m.get_delta_time();
	let screen_size = m.get_screen_dimensions();


	//draw rectangle with top left and bottom right corner
	m.draw_rect([
		[rect_pos[0], rect_pos[1]],
		[rect_pos[0] + 200, rect_pos[1] + 200]
	]);


	print "" + screen_size[0] + " " + rect_pos[0];

	//update the position of the rectangle
	rect_pos[0] = rect_pos[0] + 500 * delta * direction;
	

	rect_pos[1] = rect_pos[1] + 500 * delta * direction_y;

	//when right edge hits window border we set the direction to -1
	if(screen_size[0] <= rect_pos[0] + 200)	{
		direction = -1;
	}

	//same for left side
	if(0 >= rect_pos[0]){
		direction = 1;
	}

	//when right edge hits window border we set the direction to -1
	if(screen_size[1] <= rect_pos[1] + 200)	{
		direction_y = -1;
	}

	//same for left side
	if(0 >= rect_pos[1]){
		direction_y = 1;
	}
	


	//if the frame time is not the desired frame time yet we sleep
	let remaining = 16 - delta;
	if (remaining > 0){
		m.sleep(remaining);
	}

	//clear the canvas
	m.flush();
}
