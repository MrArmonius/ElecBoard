
module packBat(x=48, y=160, z=50) {
    difference() {
        
            minkowski() {
                $fn = 50;
                rotate([90,0,0])        cylinder(1,1.5,1.5, false);
                cube([x,y,z], false);    
                }
           
        translate([-50,-21,-3])cube([200,200,3], false);
    }
};

module devant(longueur=75, hauteur=50, longueur2=63, hauteur2=20, extrude=48) {
    rotate([90,0,90]) 
    linear_extrude(height=extrude)
    polygon([[0,0],[longueur,0],[longueur,hauteur],[longueur2,hauteur2],[0,hauteur2]]);
}
module devant_fini(longueur=75, hauteur=50, longueur2=63, hauteur2=20, extrude =48) {
    
        difference() {
            minkowski() {
                $fn = 50;
                rotate([90,0,0])        cylinder(1,1.5,1.5, false);
                devant(longueur, hauteur, longueur2, hauteur2, extrude);
            }
        translate([0,0,-1.5])cube([200,200,3], true);
        }
        
}

module fusion(x=52, y=160, extrude2=52) {
    union() {
        translate([0,75.9,0])packBat(x,y);
        devant_fini(extrude=extrude2);
    }
}




module attache() {
hull() {
        translate([8,0,0]) cube([6,10,1]);
        translate([14,0,0]) cube([1,10,3]);
        }
difference() {
    hull() {
        translate([10,0,0]) cube([2,10,1]);
        translate([5,5,0])cylinder(1,5,5, false, $fn=80);
    }

translate([5,5,-1])cylinder(4,1.5,1.5, false, $fn=80);
}
}


module attaches(x=85,y=55){
translate([x,y,0]) attache();
translate([x,y+110,0]) attache();
    
translate([x+82,y+10,0])
rotate([180,180,0])
    attache();
translate([x+82,y+120,0])
rotate([180,180,0])
    attache();
}

translate([100,0,0]){
    difference() {
        fusion();
        translate([3,3,-3]) fusion(x=46, y=154,extrude2 = 46);
    }
}

attaches();

























