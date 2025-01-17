let mjolnir = import_lib("mjolnir.so");

let reacthor = import_lib("reacthor.so");


overload + (a, b){

	return stringify(a) + stringify(b);

}


overload | (a){

	return "return :" + a + ";";
}


let plot_function = :x -> mjolnir.sin(x);

let plot_functions = [
	:x -> mjolnir.sin(x)
];

//animation loop function
//will run in seperate thread so main thread can handle io input;


fn clip_to_screen(point, s_w, s_h){
	return [
		(point[0] + 1) * s_w/2, 
		(1 - point[1]) * s_h/2
	];	
}

let scale = 3.14;


let window = mjolnir.create_window();
fn animation(){	

	let last_point = [-scale, plot_function(-scale)];

	let last_points = [];

	for pf in plot_functions{
		last_points.push([-scale, pf(-scale)]);
	}


	let dx = 0.1;	

	let dimensions = window.get_screen_dimensions();

	
	
	window.set_color([255, 255, 255]);

	let last_plot_fn_len = plot_functions.len();

	while(true){

		
		let new_dimensions = window.get_screen_dimensions();
		
		if(plot_functions.len() != last_plot_fn_len){
			last_plot_fn_len = plot_functions.len();
				
			last_points.push([-scale, plot_functions[plot_functions.len() - 1](-scale)]);

		}

		if(new_dimensions != dimensions){
			dimensions = new_dimensions;


			last_points = [];
				
			for pf in plot_functions{
				last_points.push([
					-scale, 
					pf(-scale)
				]);
			}

			window.flush();
		}
	
		let delta_time = window.get_delta_time();

		for pf in 0 to plot_functions.len() - 1{
		
			let plot_function = plot_functions[pf];
			let last_point = last_points[pf];


			let new_point = [
				(last_point[0] + dx),
				plot_function((last_point[0] + dx))
			];
				
			if(new_point[0]*new_point[0] < scale*scale){	
				window.draw_line([
					clip_to_screen([last_point[0]/scale, last_point[1]/scale], dimensions[0], dimensions[1]), 
					clip_to_screen([new_point[0]/scale, new_point[1]/scale], dimensions[0], dimensions[1])
				]);				
			}


			last_points[pf] = new_point;
		}

		


		let remaining = 16 - delta_time;
		if(delta_time < 16){
			window.sleep(remaining);
		}

		window.new_frame();	
	}
}

reacthor.start_thread(animation);

while(true){
	let tr = try {
		let new_function = eval(|get_input("new function? (has to have the form :(a) -> f(a))"));

		plot_functions.push(new_function);
	};

	if(type_of(tr) == "error"){
		print tr;
	}else{
		print "added your function successfully";
	}
}
