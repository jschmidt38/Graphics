// Template for 2D projects
// Author: Jarek ROSSIGNAC
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!

//**************************** global variables ****************************
pts P = new pts(); // class containing array of points, used to standardize GUI
float t=0, f=0;
boolean animate=true, fill=false, timing=false;
boolean lerp=true, slerp=true, spiral=true; // toggles to display vector interpoations
int ms=0, me=0; // milli seconds start and end for timing
int npts=20000; // number of points

//**************************** initialization ****************************
void setup()               // executed once at the begining 
  {
  size(800, 800);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
  myFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  P.declare(); // declares all points in P. MUST BE DONE BEFORE ADDING POINTS 
   //P.resetOnCircle(12); // sets P to have 4 points and places them in a circle on the canvas
  P.loadPts("data/pts");  // loads points form file saved with this program
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  
    background(white); // clear screen and paints white background
    pt A1=P.G[0], A2=P.G[1], A3=P.G[2], B1=P.G[3];     // crates points with more convenient names 
    pt B2=P.G[4], B3=P.G[5], C1=P.G[6], C2=P.G[7];
    pt C3=P.G[8], D1=P.G[9], D2=P.G[10], D3=P.G[11];
   //pen(green,3); edge(A,B);  pen(red,3); edge(C,D); 
   //pt F = SpiralCenter1(A,B,C,D);

    pen(black,2); showId(A1,"A1"); showId(B1,"B1"); showId(C1,"C1"); showId(D1,"D1");// showId(F,"F");
    showId(A2,"A2"); showId(B2,"B2"); showId(C2,"C2"); showId(D2,"D2"); showId(A3, "A3"); showId(B3, "B3"); showId(C3, "C3"); showId(D3, "D3");
   // noFill(); 
   // pen(blue,2); show(SpiralCenter2(A,B,C,D),16);
   // pen(magenta,2); show(SpiralCenter3(A,B,C,D),20);
   // pen(cyan,2); showSpiralPattern(A,B,C,D);     
   // pen(blue,2); showSpiralThrough3Points(A,B,D); 

  pen(blue,2); edge(A1,A2); edge(A2,A3); edge(A1,A3); noFill();
  

 pen(cyan,2); showTrianglePattern(A1,A2, A3,B1,B2,B3);
 showTrianglePattern(A1,A2, A3,C1,C2,C3);
 showTrianglePattern(A1,A2, A3,D1,D2,D3);
//pen(blue,2); showSpiralThrough3Points(A1,A2,B3); 
//showSpiralThrough3Points(A1,A3,C3); 
//showSpiralThrough3Points(A3,A2,D2); 


// making the moving interpolated lines
//pt BL1 = L(A1, B1, t); pt BL2 = L(A2, B2, t); pt BL3 = L(A3, B3, t); 
//pt CL1 = L(A1, C1, t); pt CL2 = L(A2, C2, t); pt CL3 = L(A3, C3, t);

//pen(red,1); edge(BL1,BL2);edge(BL2,BL3); edge(BL1,BL3);

pt t1 = L(C1, B1, t); pt t2 = L(C2, B2, t); pt t3 = L(C3, B3, t);
pen(red,1); edge(t1,t2);edge(t2,t3); edge(t1,t3);

pt t21 = L(B1, D1, t); pt t22 = L(B2, D2, t); pt t23 = L(B3, D3, t);
pen(red,1); edge(t21,t22);edge(t22,t23); edge(t21,t23);

pt t31 = L(D1, C1, t); pt t32 = L(D2, C2, t); pt t33 = L(D3, C3, t);
pen(red,1); edge(t31,t32);edge(t32,t33); edge(t31,t33);

f++;
t= (1-cos(2*PI*f/120))/2;



  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(black); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  