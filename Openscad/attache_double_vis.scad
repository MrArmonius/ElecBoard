
module packBat(x=48, y=165, z=55) {
    difference() {


                cube([x,y,z], false);


        translate([-50,-21,-3])cube([200,200,3], false);
    }
};

module devant(longueur=75, hauteur=50, longueur2=63, hauteur2=20, extrude=48, hauteur3=20, longueur3=63) {
    rotate([90,0,90])
    linear_extrude(height=extrude)
    polygon([[6,0],[longueur,0],[longueur,hauteur],[longueur2,hauteur2],[longueur3,hauteur2],[6,hauteur3]]);
};
module devant_fini(longueur=70-0.69, hauteur=55, longueur2=58-0.69, hauteur2=18, extrude =48, hauteur3=18, longueur3=58-0.69) {
        
        difference() {

                devant(longueur, hauteur, longueur2, hauteur2, extrude, hauteur3, longueur3);

        translate([0,0,-1.5])cube([200,200,3], true);
        }
    
       

};

module fusion(x=80, y=165, extrude2=80, hauteur2bis=18, longueur3=58-0.69, hauteur4=55) {
    minkowski(){
            rotate([90,0,0])cylinder(1,1.5,1.5, $fn=20);
    difference() {
    translate([-extrude2/2,0,0]) {
        hull(){
        translate([0,70-0.001,0])packBat(x,y,hauteur4);
        translate([-4,158-0.69-5.8,28]) cube([0.1,0.1,0.1]);

        }
        
        devant_fini(hauteur2=hauteur2bis, extrude=extrude2, longueur3=longueur3);
    }
    translate([0,-10,-10])cube([100,300,100]);
            }
        }
};






module attache() {
hull() {
        translate([8,0,0]) cube([6,10,2]);
        translate([14,0,0]) cube([1,10,14]);
        }
difference() {
    hull() {
        translate([10,0,0]) cube([2,10,4]);
        translate([5,5,0])cylinder(4,5,5, false, $fn=80);
    }

translate([5,5,-1])cylinder(8,1.5,1.5, false, $fn=80);
}
};


module attaches(x=85,y=55){
translate([x,y,0]) attache();
translate([x,y+110,0]) attache();
};

module embout(d=8.5) {
    cylinder(6, d/2, d/2, false, $fn=50);
};


module er(hauteur=18, longueur3=58-0.69) {
    
union() {

        difference() {
            fusion(extrude2 = 100, hauteur2bis=hauteur, longueur3=longueur3);
            translate([3,3,-3]) fusion(x=100, y=159,extrude2 = 100, hauteur2bis=hauteur-3, longueur3=longueur3-3, hauteur4 = 50);
        }
    }

    attaches(x=-65);
};

module clipAttache() {
      difference() {
    rotate([0,0,90]){
        
   
    difference() {
        
        translate([0,8,1.5])cube([140,69.5,3], true);
        translate([0,0,1.2])linear_extrude(height=2) text("ElecBoard",font="Liberation Sans:style=Bold Italic", halign="center",size=18, $fn=80);
        }
        
    }
    translate([-8,68,0])cube([72,2,3], true);
    }
    
    translate([0,-77.5,-1.5]){
        translate([10,0,0])cube([8,8,2]);
         translate([-36,0,0])cube([8,8,2]);
    }
    
    hull(){
        translate([10,-70,-1.5])cube([8,3,2]);
    translate([14,-65,1.5])cube([8,10,2], true);
}

    hull(){
        translate([-36,-70,-1.5])cube([8,3,2]);
    translate([-32,-65,1.5])cube([8,8,2], true);
}
translate([-8,70,0])rotate([15,0,0]){
    cube([70,1.25,6], true);
    difference() {
        translate([0,1.4,-3])rotate([0,90,0])cylinder(70,2,2,true, $fn=50);
        translate([0,1.45,-2.4])rotate([0,90,0])cylinder(72,1,1,true, $fn=70);
        cube([72,10,5.8], true);
        translate([0,6.3845,-1])rotate([-35,0,0])cube([72,2,10], true);
    }
    translate([0,4.4,-1])rotate([-35,0,0])cube([70,1.25,6], true);
    
}
translate([-8,77.45,2.75])cube([70,5,1], true);
translate([-8,67.5,3])cube([70, 5, 2], true);
};

module final(){
difference(){

union(){
    difference() {
            union(){

               er();



            translate([-0.1,0,0])mirror([1,0,0]){

                    er(30, 20);


        }
    }
difference () {
    translate([5,153,53.6]){
        
        union() {
            
                clipAttache();
                
            difference() {
                translate([-8,68,1.5])cube([70,2,3], true);
                translate([-8,68.25,1])cube([72,1.5,3], true);
            }
        }
        
            
        translate([-8,2.5,0])cube([62.5,125,15], true);
        translate([-8,72.45,1])cube([70,5,12],true);
    }
    translate([-3,228.75,52])cube([71,2.5,8.5],true);
     }
     
     translate([0,0,-2])cube([110,600,4], true);
    }
    translate([-1.60,60,16])rotate([0,0,270]){
        cube([40,3.1,10]);
        translate([39.99,0,0]){cube([8.5,3.1,9.5]);
            translate([8.49,0,1])cube([6.4,3.1,4.5]);
        }
    }
        
}




translate([40.25,50.75,25.42])rotate([180,180,0]){
    cube([30.5,30.5,4.5]);
    translate([2.5,2.5,0])cylinder(20,1.5,1.5,false, $fn=50);
    translate([2.5,27.5,0])cylinder(20,1.5,1.5,false, $fn=50);
    translate([27.5,27.5,0])cylinder(20,1.5,1.5,false, $fn=50);
    translate([27.5,2.5,0])cylinder(20,1.5,1.5,false, $fn=50);
    translate([15,15,0])cylinder(20,15,15, false, $fn=50);
}
translate([48.25,25,4])rotate([90,0,90]){
    union(){
        cube([21,11,10]);
        translate([-2.4,5.5,0])cylinder(10,1.4,1.4, $fn=50);
        translate([-4,0,0])cube([23,11,1.8]);
    }
}

translate([10.5,12.5,21])rotate([30,0,0]){
    embout();
    translate([14,0,0])embout();
    translate([28,0,0])embout();
}

translate([-3,233,57.3])cube([70,3,3],true);
}


};

final();
*clipAttache();

