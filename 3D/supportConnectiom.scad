$fn=160;
alimX=9;
alimY=11;

espacementGuideAlim=3.2;//2.8;

guideX=13;
guideY=15;

espacementGuideJack=3.2;//2.8;

sortieJack=6;

threadSize=2.7;
threadInsert=4.5;

//cube([alimX, alimY, 3]);

//translate([alimX+espacementGuideAlim,0.5,0])
//cube([guideX, guideY, 3]);

//translate([alimX+espacementGuideAlim+guideX+espacementGuideJack+sortieJack/2,sortieJack/2,0])
//cylinder(h=3, d=sortieJack);

difference(){
    union(){
        translate([-4,-3,1])
        cube([alimX+espacementGuideAlim+guideX+espacementGuideJack+sortieJack+8,alimY+3,20]);
        
        translate([alimX, alimY, 1])
        cube([18.9,8,10]);

        translate([alimX+espacementGuideAlim,0.5,0])
        cube([guideX, guideY, 3]);
    }
    translate([0,-1,0])
    cube([alimX, alimY+2, 25]);
    
    
translate([alimX+espacementGuideAlim+guideX+espacementGuideJack
    -(7-sortieJack)/2,-1,0])
    cube([7,alimY+2,25]);
    
    translate([alimX+espacementGuideAlim+threadSize/2,threadSize/2+0.5,-1])
    cylinder(h=100, d=threadInsert);

    translate([alimX+espacementGuideAlim-threadSize/2+guideX,-threadSize/2+guideY+0.5,-1])
    cylinder(h=100, d=threadInsert);

}