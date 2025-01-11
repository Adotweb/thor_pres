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

let x = 0.5;
let y = 0;
let z = 0;

let sigma = 10;
let rho = 28;
let beta = 8/3;

print m;


let color = [255, 0, 0];
m.set_color(color);
let last_point = [x, y];


let x2 = 1;
let y2 = 0;
let z2 = 0;


let color2 = [0, 255, 0];
let last_point2 = [x2, y2];

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

   	let dx2 = (sigma - 0.1) * (y2 - x2);
    	let dy2 = x2 * (rho + 0.1 - z2) - y2;
    	let dz2 = x2 * y2 - (beta - 0.1) * z2;

	x = x + dx * delta;
	y = y + dy * delta;
	z = z + dz * delta;

	x2 = x2 + dx2 * delta;
	y2 = y2 + dy2 * delta;
	z2 = z2 + dz2 * delta;


	let p = [x, y];

	let clip_p  = [
		norm(x, x_min, x_max, screen_size[0]),
		screen_size[1] - norm(z, y_min, y_max, screen_size[1]) + screen_size[1]/2
	];

	let p2 = [x2, y2];


	let clip_p2 = [
		norm(x2, x_min, x_max, screen_size[0]),
		screen_size[1] - norm(z2, y_min, y_max, screen_size[1]) + screen_size[1]/2
	];
	let s = 1;

	

	m.set_color(color);
	m.draw_line([
		last_point, 
		clip_p
	]);
	last_point = clip_p;


	m.set_color(color2);
	m.draw_line([
		last_point2, 
		clip_p2
	]);

	last_point2 = clip_p2;



	let new_screen_size = m.get_screen_dimensions();

	if(new_screen_size != last_screen_size){
	
		x = 0.5;
		y = 0;

		x2 = 0.5;
		y2 = 0;

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
