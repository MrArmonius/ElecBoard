
module packBat() {
    difference() {
        difference() {
            minkowski() {
                $fn = 50;
                rotate([90,0,0])        cylinder(1,1.5,1.5, false);
                cube([48,160,50], false);    
                }
            translate([0,0,-3]){cube([48,158,51.5],false);}
            }
        translate([-50,-21,-3])cube([200,200,3], false);
    }
}

module devant(longueur=75, hauteur=50, longueur2=63, hauteur2=20 ) {
    rotate([90,0,90]) 
    linear_extrude(height=48)
    polygon([[0,0],[longueur,0],[longueur,hauteur],[longueur2,hauteur2],[0,hauteur2]]);
}
module devant_fini() {
    difference() {
        difference() {
            minkowski() {
                $fn = 50;
                rotate([90,0,0])        cylinder(1,1.5,1.5, false);
                devant();
            }
        translate([0,0,-1.5])cube([200,200,3], true);
        }
        translate([0,0,-3]) devant(75.1, 50, 60, 17);
    }
}

*devant_fini();
*packBat();
difference() {
    union() {
        translate([0,76,0])packBat();
        devant_fini();
    }
    translate([0,75,0]) cube([48,10,48.5]);
}