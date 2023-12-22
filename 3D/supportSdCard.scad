$fn=150;

paroi=3;
connecteurLargeur=25;
connecteurEpaisseur=8;
connecteurProfondeur=33;

SDLargeur=22;
SDEpaisseur=2;
SDProfondeur=33;

ouvertureLargeur=16;
ouvertureHauteur=13;


percage=4.3;

epaulement=12;
triangleEpaule= [[0,0],[0,connecteurProfondeur*0.5],[epaulement,0]];


translate([epaulement,30,-30])
support();

//translate([paroi,40+paroi,0])
gabarit();

module support(){
    difference(){
        connecteur();
        translate([paroi,paroi,paroi])
        percage();
    }
}

module gabarit(){
    
    difference(){
        
        cube([connecteurLargeur+2*paroi+2*epaulement,
        connecteurEpaisseur+2*paroi,paroi]);
        
        translate([epaulement+paroi,-connecteurEpaisseur/2+paroi+connecteurEpaisseur/2,0])
        percageGabarit();
    }
    
    translate([-ouvertureLargeur/2+connecteurLargeur/2+paroi+epaulement,
        -ouvertureHauteur/2+connecteurEpaisseur/2+paroi,
        paroi])
    cube([ouvertureLargeur,ouvertureHauteur,paroi]);
}

module percageGabarit(){
    translate([-epaulement/2-paroi,connecteurEpaisseur/2,1]){
        cylinder(h=paroi, d1=percage, d2=1);
        cylinder(h=paroi*2, d=1);
        translate([0,0,-paroi+0.01])
        cylinder(h=paroi, d=percage);
    }
    
    translate([connecteurLargeur+epaulement/2+paroi,connecteurEpaisseur/2,1]){
        cylinder(h=paroi, d1=percage, d2=1);
        cylinder(h=paroi*2, d=1);
        translate([0,0,-paroi+0.01])
        cylinder(h=paroi, d=percage);
    }
}

module percage(){
    cube([connecteurLargeur,
          connecteurEpaisseur,
          connecteurProfondeur+1]);

    translate([(connecteurLargeur-SDLargeur)/2,
                (connecteurEpaisseur-SDEpaisseur)/2,
                -SDProfondeur+1])
    cube([SDLargeur,
          SDEpaisseur,
          SDProfondeur+1]);
    
    translate([-epaulement/2-paroi,connecteurEpaisseur/2,1])
    cylinder(h=connecteurProfondeur, d=percage);

    translate([connecteurLargeur+epaulement/2+paroi,connecteurEpaisseur/2,1])
    cylinder(h=connecteurProfondeur, d=percage);

    
    translate([connecteurLargeur/2,
        -ouvertureHauteur/2+connecteurEpaisseur/2,
        connecteurProfondeur])
    rotate([-90,0,0])
    scale([1,0.3,1])
    cylinder(h=ouvertureHauteur, d=ouvertureLargeur);
}

module connecteur(){
    cube([connecteurLargeur+2*paroi,
          connecteurEpaisseur+2*paroi,
          connecteurProfondeur+paroi]);

    translate([connecteurLargeur+2*paroi,0,connecteurProfondeur+paroi-epaulement])
    epaule();

    translate([0,connecteurEpaisseur+2*paroi,connecteurProfondeur+paroi-epaulement])
    rotate([0,0,180])
    epaule();

}

module epaule(){
    cube([epaulement, connecteurEpaisseur+2*paroi,epaulement]);
    
    rotate([-90,0,0])
    linear_extrude(connecteurEpaisseur+2*paroi)
    polygon(triangleEpaule);
}