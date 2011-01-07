import org.json.*;
import processing.opengl.*;
import toxi.processing.*;
import toxi.physics.behaviors.*;
import toxi.physics.*;

import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;

PFont font;
JSONArray current;

VerletPhysics physics;
ToxiclibsSupport gfx;

PGraphics tex;

TriangleMesh mesh;
//texturedMesh texMesh;

String baseURL = "http://api.pachube.com/v2/feeds/11323.json";
String apiKey = "c01095f0f2480607c8313765e486333c42bfcfd0a4583c575ac366506b3a4fe1";


///////////////////////////////////////
//SETUPSETUPSETUPSETUPSETUPSETUPSETUP//
///////////////////////////////////////
void setup() {
  size(800,600,OPENGL);
  gfx=new ToxiclibsSupport(this);
  background(0);
  fill(255);
  frameRate(60);
  // dataIn = new DataIn(this,baseURL, apiKey, 15000);

  font = createFont("Helvetica", 32, true);
  textFont(font);
  tex = createGraphics( width, height, P2D); 
  initPhysics();
}


////////////////////////////////////////////
//MAINLOOPMAINLOOPMAINLOOPMAINLOOPMAINLOOP//
////////////////////////////////////////////
void draw() {
  physics.update();
  checkUpdate();



  //  for (Iterator<JSONArray> i = current.iterator(); i.hasNext(); ) {
  tex.beginDraw();
  tex.background(0);
  tex.fill(255);
  for( int i = 0; i < current.length(); i++) {
    try {
      //    JSONArray entry = i.next();
      JSONObject entry = (JSONObject)current.get(i);
      tex.text( entry.getString( "tags" ), 50, 50*i );
    } 
    catch (JSONException e) {
      println( "Had a problem with results: " + e );
    }
  }
  tex.endDraw();

  image( tex.get( 0, 0, tex.width, tex.height), random(width), random(height) );

//box

}  


////////////////////////////////////////
//FUNCFUNCFUNCFUNCFUNCFUNCFUNCFUNCFUNC//
////////////////////////////////////////
/*
void onReceiveEEML(DataIn d){ 
 float myVariable = d.getValue(1);
 println(myVariable);
 } */
/*
void onReceiveEEML(DataIn d) { 
 float firstString = d.getValue(1);
 println("Got firstString: " +  firstString);
 //  return firstString;
 text( firstString,0,0 );
 }
 */

JSONArray getDataUpdate(String url, String apikey) { //http://blog.blprnt.com/blog/blprnt/processing-json-the-new-york-times
  String request = url + "?key=" + apikey;
  String result = join( loadStrings( request ), "");
  try {
    JSONObject pachube = new JSONObject(join(loadStrings(request), ""));
    JSONArray results = pachube.getJSONArray("datastreams");
    int total = pachube.length();
    println ("There are " + total + " objects associated with this stream");
    return results;
  }
  catch (JSONException e) {
    println ("There was an error parsing the JSONObject:" + e);
    return null;
  }
}

void getDataStream(JSONArray array, String key) {
}


void checkUpdate() {
  if( frameCount == 1 % 900) {
    current = getDataUpdate(baseURL, apiKey);
  }
}



