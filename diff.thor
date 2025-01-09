//import animation library 
let m = import_lib("mjolnir.so");


overload + (a, b){
	return stringify(a) + stringify(b);
}

m.create_window();


let unit = 0;

let screen_size = [10000, 10000];

let last_screen_size = [0, 0];

fn plot_fn(x){
	return x * x;
}


let x = 0.5;
let y = 0;

while(true){
	//get time since last frame
	let delta = m.get_delta_time();


	let w = screen_size[0];
	let h = screen_size[1];

	//draw point in center

	let gamma = 0.1;

	let dx = -y - gamma * x;
	let dy = x - gamma * y;

	x = x + dx * delta;
	y = y + dy * delta;

	let p = [x, y];

	let clip_p  = [
		p[0] * w/2 + w/2 - 1,
		-p[1] * h/2 + h/2 - 1
	];

	m.draw_rect([
		clip_p,
		[clip_p[0] + 1, clip_p[1] + 1]
	]);

	let new_screen_size = m.get_screen_dimensions();

	if(new_screen_size != last_screen_size){
	
		x = 0.5;
		y = 0;

		last_screen_size = screen_size;
		screen_size = new_screen_size;	

		print "resize " + screen_size;

		m.flush();
		let unit = 0;
	}		

	//if the frame time is not the desired frame time yet we sleep
	let remaining = 16 - delta;
	if (remaining > 0){
		m.sleep(remaining);
	}




	m.new_frame();
}


while(true){

}
