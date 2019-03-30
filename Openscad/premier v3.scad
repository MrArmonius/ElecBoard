
module packBat(x=48, y=165, z=50) {
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
module devant_fini(longueur=75-0.69-5.3, hauteur=50, longueur2=63-0.69, hauteur2=15, extrude =48) {
    
        difference() {
            minkowski() {
                $fn = 50;
                rotate([90,0,0])        cylinder(1,1.5,1.5, false);
                devant(longueur, hauteur, longueur2, hauteur2, extrude);
            }
        translate([0,0,-1.5])cube([200,200,3], true);
        }
        
}

module fusion(x=80, y=165, extrude2=80) {
    union() {
        hull(){
        translate([0,75-0.691-5.3,0])packBat(x,y);
        translate([-4,158-0.69-8.3,25]) cube([0.1,0.1,0.1]);
        
        }
        devant_fini(extrude=extrude2);
    }
}




module attache() {
hull() {
        translate([8,0,0]) cube([6,10,2]);
        translate([14,0,0]) cube([1,10,4]);
        }
difference() {
    hull() {
        translate([10,0,0]) cube([2,10,2]);
        translate([5,5,0])cylinder(2,5,5, false, $fn=80);
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


module er() {
union() {
    translate([-40,0,0]){
        difference() {
            fusion();
            translate([3,3,-3]) fusion(x=46, y=154,extrude2 = 46);
        }
    }
    
    attaches(x=-55);
}
}



union(){
    difference() {
        union() {
            difference() {
                er();
                translate([0,-20,-10])cube([300,300,100]);    
            }
            translate([-0.1,0,0])mirror([1,0,0]){
                difference() {
                    er();
                    translate([0,-20,-10])cube([300,300,100]);    
                }
            }
        }
     
    translate([5,158,50]){
     linear_extrude(height=1.5) rotate([0,0,90])text("ElecBoard",font="Liberation Sans:style=Bold Italic", halign="center", $fn=80);} 
    }
}    

 
 


















