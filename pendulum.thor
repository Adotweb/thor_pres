let m = import_lib("mjolnir.so");

let window = m.create_window();


let screen_size = [10000, 10000];
let last_screen_size = [0, 0];

// Constants for pendulum
let g = 9.81;   // gravitational acceleration
let l = 1.0;    // pendulum length
let c = 0.2;    // damping coefficient

// Normalization function
fn norm(value, min_val, max_val, s) {
    return ((value - min_val) / (max_val - min_val) * s).floor();
}

// Initial conditions
let theta = 1.0;    // Initial angle (radians)
let omega = 0.0;    // Initial angular velocity
let color = [255, 0, 0];
window.set_color(color);


let last_point = [
    norm(theta, -3.14, 3.14, screen_size[0]),
    screen_size[1] - norm(omega, -10, 10, screen_size[1]) + screen_size[1] / 2
];


let time_step = 0.01;
let time = 0;

// Integration loop
while (true) {
    let delta = window.get_delta_time();

    // Pendulum differential equations
    let dtheta = omega;
    let domega = -(g / l) * m.sin(theta) - c * omega;

    // Update state variables
    theta = theta + dtheta * 0.01;
    omega = omega + domega * 0.01;

    // Normalize and map to screen
    let clip_point = [
        norm(theta, -3.14, 3.14, screen_size[0]),
        screen_size[1] - norm(omega, -10, 10, screen_size[1])
];

    // Draw line to represent trajectory
    window.set_color(color);
    window.draw_line([last_point, clip_point]);


    last_point = clip_point;

    // Handle screen resize
    let new_screen_size = window.get_screen_dimensions();
    if (new_screen_size != last_screen_size) {
        last_screen_size = screen_size;
        screen_size = new_screen_size;
        window.flush();
	last_point = [
    		norm(theta, -3.14, 3.14, screen_size[0]),
    		screen_size[1] - norm(omega, -10, 10, screen_size[1]) 
	];
    }

    // Sleep to maintain frame rate
    let remaining = 16 - delta;
    if (remaining > 0) {
        window.sleep(remaining);
    }

    window.new_frame();


    time = time + time_step;


}

