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

let scale = 1/10;

while(true){
	//get time since last frame
	let delta = m.get_delta_time();

	let plot_point = [unit, screen_size[1] - plot_fn((unit - screen_size[0]/2) * scale)];

	if(unit <= screen_size[0]){
		if(unit >= 0){	
			m.draw_rect([
				plot_point, 
				[plot_point[0] + 1, plot_point[1] + 1]
			]);
		}
	}

	if(unit > screen_size[0]){
		return nil;
	}

	unit = unit + 1;


	let new_screen_size = m.get_screen_dimensions();

	if(new_screen_size != last_screen_size){
		
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

print "done plotting";

while(true){

}
