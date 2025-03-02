//import animation library 
let m = import_lib("mjolnir.so");

let reacthor = import_lib("reacthor.so");



overload + (a, b){
	return stringify(a) + stringify(b);
}

let window = m.create_window();


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



let color = [255, 0, 0];
window.set_color(color);
let last_point = [x, y];


let x2 = 1;
let y2 = 0;
let z2 = 0;


let color2 = [0, 255, 0];
let last_point2 = [x2, y2];

let time = 0;
let time_step = 0.1;


let plot_fn = "hello_func";



while(true){
	print plot_fn;	

	//get time since last frame
	let delta = window.get_delta_time();


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

	

	window.set_color(color);
	window.draw_line([
		last_point, 
		clip_p
	]);
	last_point = clip_p;


	window.set_color(color2);
	window.draw_line([
		last_point2, 
		clip_p2
	]);

	last_point2 = clip_p2;



	let new_screen_size = window.get_screen_dimensions();

	if(new_screen_size != last_screen_size){
	
		x = 0.5;
		y = 0;

		x2 = 0.5;
		y2 = 0;

		last_screen_size = screen_size;
		screen_size = new_screen_size;	


		window.flush();


	
		let unit = 0;
	}		

	//if the frame time is not the desired frame time yet we sleep
	let remaining = 16 - delta;
	if (remaining > 0){
		window.sleep(remaining);
	}

	time = time + time_step;


	color = [
		127 + 127 * m.sin(time),
		127 + 127 * m.sin(time - 3.14/3),
		127 + 127 * m.sin(time - 3.14 * 2/3)
	];


	color2 = [
		127 + 127 * m.sin(time - 3.14 * 2/3),
		127 + 127 * m.sin(time - 3.14/3),
		127 + 127 * m.sin(time - 3.14)
	];


	window.new_frame();

}


