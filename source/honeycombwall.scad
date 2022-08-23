/**
* Honeycombwall.scad
*
* @copyright Didier MATHIEU , 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see 
*
* Build a honeycomb wall, to save materials on your 3D printer
* enter only the size of your cube and and the module calculates the number of hexagons needed 
*
**/ 

/**
*   three arguments 
*   @size : Vectors [x,y,z]
*   @radius : Diameter of the circle that defines a hexagon
*   @border : [x,y] 
*     
**/

module HoneycombWall (
        size=[],
        radius = 100,
        border = [10,10],
    ) {
        
    L = radius;
    width  =  size.x;  
    height =  size.y; 
    depth = size.z;    
        
    l = L/2;
    H = radius*sqrt(3)/2;
    h = H/2;
    e = radius *0.10;
  
   // alculates the number of hexagons     
    nb_x = round (((2*width)/((3*l)+(2*e)))+1) + 1;
    nb_y = round ((height - (h + (e/2))  )/(H +e) + 1) +1;
    
    //echo ("[L,H]",L,H);
        
    width_reel = (nb_x - 1) * ((3 * l/2) + e);    
    height_reel = ((nb_y - 1) *  (H +e )) + (h + (e/2))  ; // 
        
//    echo ("[width,height]",size.x,size.y);        
//    echo ("nb_x", nb_x  );  
//    echo  ("nb_y", nb_y) ; //
    
    
    difference () {        
        cube ([width,height,size.z]);
        for (i = [0:nb_x -1])
            for (j = [0:nb_y -1]) {
                DX= (i * ((3 * l/2) + e)) - l;
                DY = (j * (2*h+e)  + (i%2 * (h+(e/2)))) -h ;
                translate ([DX,DY,0])
                cylinder (r=l,h=size.z,$fn=6);
            }
        }
        
    //}

        difference (){
            cube ([width,height,size.z]);
            translate ([border.x,border.y,0])
            cube ([width-(border.x * 2) ,height-(border.y*2),size.z]);
        }
}

//Exemple  decomment to show
//raduis = 50;
//size =[300,550,2];
//border = [size.x*0.05,size.y*0.05];
//HoneyWall (size=size,radius = raduis,border=border);