$fn=50;
length = 35;
height = 3.5;
width = 17;
handle_r = 15;
module case(bottom, c_z)
{

difference() {
	union() {
		difference() {
			union() {
			cube([length,width,height], center=true);
	
			// head
			difference() {
				translate([length-5, 0, 0])cylinder(r=handle_r, h=height, center=true);
				translate([length-5, 0, 0])cylinder(r=handle_r-1.5, h=height);
	
				}
			}
			translate([0,0,1.5]) cube([length-3,width-3,height+1.5], center=true);
			translate([-length/2,0,1.5]) cube([5,13,2], center=true);
	
		}
		
	
		translate([length+3, 0, -1])cylinder(r=2.5, h=height-1); //hole 
	}
	if (bottom) {
		translate([0, 0, height/2])cube([length+3,width-2,1], center=true); //connector
		
		translate([length-5, 0, height/2])cylinder(r=handle_r-1, h=1, center=true);

	}
	else {
		difference() {
		translate([0, 0, height/2])cube([length+3,width,1], center=true); //connector
		translate([0, 0, height/2])cube([length+3,width-2,1], center=true);
		}
		difference() {
		translate([length-5, 0, height/2])cylinder(r=handle_r, h=1, center=true);
		translate([length-5, 0, height/2])cylinder(r=handle_r-1, h=1, center=true);

		}
	}
	translate([length+3, 0, -3])cylinder(r=2, h=height+3); //hole
	}
	translate([length/2-3, width/2-4, height/2-2])cube([3,0.5,2], center=true);
	translate([length/2-3, -width/2+4, height/2-2])cube([3,0.5,2], center=true);
	
	for (z=[
			[length/2-2, width/2-1.5,c_z],
			[length/2-2, -width/2+1.5,c_z],
			[-length/2+1.1,-width/2+1.5, c_z],
			[-length/2+1.1,width/2-1.5, c_z],

			[length, handle_r-2.5, c_z],
			[length, -handle_r+2.5, c_z]]) {
			if (bottom) {
			translate(z) conn_mother();
			}
			else {
			translate(z) conn_father();

			}
		}
	
}

module conn_mother()
{

difference(){
cylinder(r=1, h=height-0.5);
cylinder(r=0.5, h=height);

}
}

module conn_father()
{
cylinder(r=0.5, h=height+2, center=true);

}

module top()
{

}
translate([0,0,10])
rotate([0, 180, 180]) case(false, 1.5);
case(true, -1,5);

//}