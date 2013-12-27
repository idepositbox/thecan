
$fn = 100;
$fa = 360;
height=140;
width=60;
cut_angle=25;
mb_h = 85.6;
mb_w = 54;
module ethernet ()
{
//ethernet port
difference() {
color([50,50,50, 0.7])
cube([21.2,16,13.3]);
translate([3,3,2]) cube([23,10,10]);

} 
}

module usb ()
{
//usb port
color("silver")
difference() {
	cube([6,13.3,16], center=true);
	cube([3,10,17], center=true);
}
}

module powersocket ()
{
difference() {
	cube([21.2,8,13.3]);
	for (i=[4,8]) {
		translate([15,4,i]) 
			rotate(a=90, v=[0,1,0]) cylinder(r=3,h=10);
	 	}
	}
for (i=[4,8]) {
	translate([15,4,i]) 
		rotate(a=90, v=[0,1,0]) cylinder(r=1,h=5);
}
}


///
///

module alloy_cylinder() {
	difference() {
		difference() {
				cylinder(r=width/2+1,h=height,center=true);
				cylinder(r=width/2,h=height+1,center=true);
		}
	
	//hole for power/net connectors
	translate([width/2-1,0,-(height/2)+9]) cube([7,30,20], center=true);
	// top cut
	translate([width/2,0,(height/2)+50]) rotate(a=cut_angle, v=[0,-1,0]) 
		cube([300,width+10,100], center=true);

	}
}

module motherboard() {
color("green")
#	translate([0,0,0])
		cube([2, mb_w, mb_h], center=true);
	translate([-5,0,height/2-32]) usb();
	translate([2,0,5]) color("black")
		cube([2, 20, 20], center=true);
	color("black") 
		translate([2,0,-height/2+10]) cube([3,30,5],center=true);
}

module pcb_power() {
	// board
	color("green")
		translate([0,0,-height/2+2]) cylinder(r=width/2-2,h=2,center=true);
	color("red") 
		translate([-10,0,-height/2+7]) cube(10,10,10,center=true);
	color("black") 
		translate([2,0,-height/2+4]) cube([3,30,3],center=true);
	color("red")

	// ports

	translate([width/2-21,-13,-height/2+3]) ethernet();
	translate([width/2-21,5,-height/2+3]) powersocket();

}
module powerboard() {
	// bottom cap
		translate([0,0,-height/2]) cylinder(r=width/2,h=5,center=true);
		translate([0,0,-height/2-1]) cylinder(r=width/2+2,h=3,center=true);
	
difference() {	 
	translate([width/2-4,0,-(height/2)+9]) cube([7,30,20], center=true);
	translate([width/2-21,-13,-height/2+3]) cube([21.2,16,13.3]);
	translate([width/2-21,5,-height/2+3]) cube([21.2,8,13.3]);

}
// connection pads

translate([width/2-3,0,-(height/2)+24]) cube([3,10,10], center=true);
translate([-width/2+2,0,-(height/2)+15]) cube([3,10,30], center=true);

for (i = [20,-20]) {
translate([0,i,-height/2+5]) 
	rotate([0, 0, 90]) pupushka();
	}
}

module pupushka()
{
difference() {
	cylinder(r=5,h=8,center=true);
	translate([-5, -1, 1]) cube([10,2,5]);
	}
}

module cap()
{
// bezel
difference(){
	union() {
	translate([-3,0,height/2-22]) cube([20,16,10], center=true);
	rotate(a=cut_angle,v=[0,-1,0]) translate([12,0,height/2-28]) cube([25,27,8], center=true);
	}
	translate([-7,0,height/2-20]) cube([25,20,10], center=true);
	translate ([-5,0,height/2-20]) cube([6,13.3,50], center=true);
	motherboard();


}
difference() {
	translate([0,0,height/2-20]) cylinder(r=width/2,h=40,center=true);
		difference() {// empty cap, less plastic
		translate([0,0,height/2-20]) cylinder(r=width/2-1,h=36,center=true);
		translate([width/2,0,(height/2)+46]) rotate(a=cut_angle, v=[0,-1,0]) 
			cube([300,width+10,100], center=true);
	
		}
	// cutoff with same angle as tube
	translate([width/2,0,(height/2)+50]) rotate(a=cut_angle, v=[0,-1,0]) 
		cube([300,width+10,100], center=true);
	translate([0,0,(height/2)-43]) rotate(a=cut_angle, v=[0,-1,0]) 
		cube([100,width+10,30], center=true);
    translate([-7,0,height/2-20]) cube([25,17,10], center=true);
	translate ([-5,0,height/2-20]) cube([9,13.3,50], center=true);


  }


}

///
///

//
color("silver", 0.75) alloy_cylinder();

//motherboard();
//powerboard();
//pcb_power();
cap();
