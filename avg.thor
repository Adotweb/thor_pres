let current_weights = 0;
let current_points = 0;

let average = 0;

overload + (a, b){
	return stringify(a) + stringify(b);
}

on average {
	print "";
	print "--------------------------";
	print "| current average is: " + average + " |";
	print "--------------------------";
};



while(true){
	
	let new_grade = get_input("any new grades?").parse_number();

	print "";

	let new_weight = get_input("what was the grades weight?").parse_number();	
	

	print "";

	current_weights = current_weights + new_weight;
	current_points = current_points + new_grade * new_weight;

	if(current_weights != 0){
		average = current_points/current_weights;
	}

}

