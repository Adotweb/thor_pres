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


let x_min = -30;
let x_max = 30;
let y_min = -30;
let y_max = 30;

fn norm(value, min_val, max_val, s){
	return ((value - min_val) / (max_val - min_val) * s).floor(); //+ s/2;
}

let x = 1;
let y = 0;
let z = 0;

let sigma = 10;
let rho = 28;
let beta = 8/3;


while(true){
	//get time since last frame
	let delta = m.get_delta_time();


	let w = screen_size[0];
	let h = screen_size[1];

	//draw point in center

	let gamma = 0.1;

    	let dx = sigma * (y - x);
    	let dy = x * (rho - z) - y;
    	let dz = x * y - beta * z;

	x = x + dx * delta;
	y = y + dy * delta;
	z = z + dz * delta;

	let p = [x, y];

	let clip_p  = [
		norm(x, x_min, x_max, screen_size[0]),
		norm(z, y_min, y_max, screen_size[1]) - screen_size[1]/2
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
