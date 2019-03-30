module packBat(x=48, y=165, z=50) {
    difference() {


                cube([x,y,z], false);


        translate([-50,-21,-3])cube([200,200,3], false);
    }
};

module devant(longueur=70, hauteur=50, longueur2=58, hauteur2=20, extrude=48, hauteur3=20, longueur3=58) {
    rotate([90,0,90])
    linear_extrude(height=extrude)
    polygon([[0,0],[longueur,0],[longueur,hauteur],[longueur2,hauteur2],[longueur3,hauteur2],[0,hauteur3]]);
};
module devant_fini(longueur=65-0.69, hauteur=50, longueur2=53-0.69, hauteur2=18, extrude =48, hauteur3=18, longueur3=53-0.69) {
        
        difference() {

                devant(longueur, hauteur, longueur2, hauteur2, extrude, hauteur3, longueur3);

        translate([0,0,-1.5])cube([200,200,3], true);
        }
    
       

};

module fusion(x=65, y=165, extrude2=65, hauteur2bis=18, longueur3=58-0.69) {
    minkowski(){
            rotate([90,0,0])cylinder(1,1.5,1.5, $fn=20);
    difference() {
    translate([-40,0,0]) {
        hull(){
        translate([0,65-0.001,0])packBat(x,y);
        translate([-4,158-0.69-5.8,25]) cube([0.1,0.1,0.1]);

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
        translate([14,0,0]) cube([1,10,4]);
        }
difference() {
    hull() {
        translate([10,0,0]) cube([2,10,2]);
        translate([5,5,0])cylinder(2,5,5, false, $fn=80);
    }

translate([5,5,-1])cylinder(4,1.5,1.5, false, $fn=80);
}
};


module attaches(x=85,y=55){
translate([x,y,0]) attache();
translate([x,y+110,0]) attache();
};




module er(hauteur=18, longueur3=58-0.69) {
    
union() {

        difference() {
            fusion(hauteur2bis=hauteur, longueur3=longueur3);
            translate([3,3,-3]) fusion(x=40, y=159,extrude2 = 40, hauteur2bis=hauteur-3, longueur3=longueur3-3);
        }
    }

    attaches(x=-55);
};

module emboitage(x=0.3){
rotate([270,0,0])translate([20,0,0]){
    difference() {
        hull(){
            translate([0,0,7.5])resize([2.5,2.5,5])sphere(1.25,$fn=80);
            cylinder(7,1.25,1.25,false, $fn=80);
        }
        translate([0,0,8.5]){
            cube([5,x,3],true);
            rotate([0,0,90])cube([5,x,3],true);
        }
    }
}
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

    translate([5,153,50.5]){
     linear_extrude(height=1.5) rotate([0,0,90])text("ElecBoard",font="Liberation Sans:style=Bold Italic", halign="center",size=20, $fn=80);}
     
     translate([0,0,-2])cube([100,600,4], true);
    }
    translate([-1.60,60,16])rotate([0,0,270]){
        cube([40,3.1,10]);
        translate([39.99,0,0]){cube([8.5,3.1,9.5]);
            translate([8.49,0,1])cube([6.4,3.1,4.5]);
        }
    }
        
}




translate([35.25,50.75,25.42])rotate([180,180,0]){
    cube([30.5,30.5,4.5]);
    translate([2.5,2.5,0])cylinder(20,1.5,1.5,false, $fn=50);
    translate([2.5,27.5,0])cylinder(20,1.5,1.5,false, $fn=50);
    translate([27.5,27.5,0])cylinder(20,1.5,1.5,false, $fn=50);
    translate([27.5,2.5,0])cylinder(20,1.5,1.5,false, $fn=50);
    translate([15,15,0])cylinder(20,15,15, false, $fn=50);
}
translate([38.25,25,10])rotate([90,0,90]){
    union(){
        cube([19,10,10]);
        translate([-2.4,5,0])cylinder(10,1.4,1.4, $fn=50);
        translate([-4,0,0])cube([23,10,1.8]);
    }
}

}
};

!difference() {
translate([0,-70,0])final();
    //translate([-100,-75,-1])cube([200,75,55],false);
    translate([0,-0.1,49.75]){emboitage(0);
    mirror([1,0,0])emboitage(0);}
}

translate([0,0,0]){
difference(){
    translate([100,0,0])final();
    translate([54,70,-1])cube([110,166,55]);
    translate([40,160,-1])cube([20,20,5]);
}


translate([100,69,49.75]){
emboitage();
mirror([1,0,0])emboitage();
}    
}