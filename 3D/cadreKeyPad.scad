$fn=100;
cadreLargeur=12;
cadreEpaisseur=6;
keypadLargeur=77;
keypadHauteur=65;
ancrageDiametre = 4.3;
ancragelongueur = 5;
bordR1 = 3;
bordR2 = 24;
longueurBordureLongue = keypadLargeur+2*cadreLargeur;
longueurBordureCourte = keypadHauteur+2*cadreLargeur;

difference(){
    cube([keypadLargeur+2*cadreLargeur,
        keypadHauteur+2*cadreLargeur,cadreEpaisseur],true);
    cube([keypadLargeur,keypadHauteur,cadreEpaisseur+2],true);
    

    ancrages();
    bordures();
}

module ancrages(){
    translate([keypadLargeur/2+cadreLargeur*0.6,
            keypadHauteur/2+cadreLargeur*0.6,
            -cadreEpaisseur/2-0.1])
    cylinder(h=ancragelongueur, d=ancrageDiametre);
    
    translate([-keypadLargeur/2-cadreLargeur*0.6,
            keypadHauteur/2+cadreLargeur*0.6,
            -cadreEpaisseur/2-0.1])
    cylinder(h=ancragelongueur, d=ancrageDiametre);

    translate([-keypadLargeur/2-cadreLargeur*0.6,
            -keypadHauteur/2-cadreLargeur*0.6,
            -cadreEpaisseur/2-0.1])
    cylinder(h=ancragelongueur, d=ancrageDiametre);

    translate([keypadLargeur/2+cadreLargeur*0.6,
            -keypadHauteur/2-cadreLargeur*0.6,
            -cadreEpaisseur/2-0.1])
    cylinder(h=ancragelongueur, d=ancrageDiametre);

}

module bordures(){
    translate([0,
        -keypadHauteur/2+bordR1/2-cadreLargeur,
        cadreEpaisseur/2])
    bordure(longueurBordureLongue);

    translate([0,
        keypadHauteur/2-bordR1/2+cadreLargeur,
        cadreEpaisseur/2])
    mirror([0,1,0])
    bordure(longueurBordureLongue);

    translate([-keypadLargeur/2-cadreLargeur+bordR1/2,
        0,
        cadreEpaisseur/2])
    rotate([0,0,-90])
    bordure(longueurBordureCourte);

    translate([keypadLargeur/2+cadreLargeur-bordR1/2,
        0,
        cadreEpaisseur/2])
    rotate([0,0,-90])
    mirror([0,1,0])
    bordure(longueurBordureCourte);
}

module bordure(longueur){
    translate([0,0,-bordR1/2]){
        translate([longueur/2,0,0])
        rotate([90,0,-90]){    
            difference(){
                cube([bordR1/2+0.1,bordR1/2+0.1,longueur]);
                cylinder(h=longueur, d=bordR1);
            }
        
            translate([-11,11,0])
            rotate([0,0,90])
            cylindreBisaute(longueur);
        }
    }    
}


module cylindreBisaute(longueur){
        difference(){
            cylinder(h=longueur, d=bordR2);

            translate([-bordR2,-bordR2/2,0])
            rotate([-45,0,0])
            cube([bordR2*2,bordR2*2,bordR2*2]);
            
            translate([-bordR2,-bordR2/2,longueur])
            rotate([-45,0,0])
            cube([bordR2*2,bordR2*2,bordR2*2]);
        }
}