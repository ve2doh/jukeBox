$fn=150;

pcbArduinoLargeur= 18;
pcbArduinoLongueur= 44;
pcbArduinoEpaisseur= 1.5;

pcbMp3Largeur= 41;
pcbMp3Longueur= 41;
pcbMp3Epaisseur= 1.5;
percage=4.3;

espacement = 10;


largeur = 2*espacement+max(pcbArduinoLongueur, pcbMp3Largeur);
longueur = 3*espacement+pcbArduinoLargeur+pcbMp3Longueur;
epaisseur = 9;

//    translate([-10,-10, epaisseur])
//    encavure(pcbMp3Longueur, pcbMp3Largeur, 10, pcbMp3Epaisseur,3);

difference() {
    cube([longueur, largeur, epaisseur]);
    
    translate([espacement,espacement, epaisseur])
    encavure(pcbMp3Longueur, pcbMp3Largeur, 6, pcbMp3Epaisseur,3);

    translate([2*espacement+pcbMp3Longueur,10, epaisseur])
    encavure(pcbArduinoLargeur, pcbArduinoLongueur, 6, pcbArduinoEpaisseur, 3);
}


module encavure(longueurEncavure, largeurEncavure, epaisseurEncavure, epaisseurPCB, chanfrein){
    
    translate([0,0, -epaisseurPCB+0.1])
    cube([longueurEncavure, largeurEncavure, epaisseurPCB]);

    translate([0,0, -epaisseurEncavure+0.1])
    difference() {
        cube([longueurEncavure, largeurEncavure, epaisseurEncavure]);
        translate([0,3,0])
        
        rotate([0,0,-135])
        cube([longueurEncavure, largeurEncavure, epaisseurEncavure]);

        translate([0,largeurEncavure-chanfrein,0])
        rotate([0,0,45])
        cube([longueurEncavure, largeurEncavure, epaisseurEncavure]);

        translate([longueurEncavure-chanfrein,largeurEncavure,0])
        rotate([0,0,-45])
        cube([longueurEncavure, largeurEncavure, epaisseurEncavure]);
        
        translate([longueurEncavure-chanfrein,0,0])
        rotate([0,0,-45])
        cube([longueurEncavure, largeurEncavure, epaisseurEncavure]);

    }

    deplacementPercage = sin(45)*percage/2;

    translate([-deplacementPercage,-deplacementPercage,-epaisseur])
    cylinder(h=100, d=percage);

    translate([longueurEncavure+deplacementPercage,-deplacementPercage,-epaisseur])
    cylinder(h=100, d=percage);

    translate([longueurEncavure+deplacementPercage,largeurEncavure+deplacementPercage,-epaisseur])
    cylinder(h=100, d=percage);

    translate([-deplacementPercage,largeurEncavure+deplacementPercage,-epaisseur])
    cylinder(h=100, d=percage);

}