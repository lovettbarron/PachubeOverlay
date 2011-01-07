/////////////////
///initPhysics///
/////////////////


// create the physical world by constructing all
// obstacles/constraints, particles and connecting them
// in the correct order using springs
void initPhysics() {
  physics=new VerletPhysics();
  physics.addBehavior(new GravityBehavior(new Vec3D(0,0.1,0)));
  //ground.setRestitution(0);
  //VerletPhysics.addConstraintToAll(ground,physics.particles);
}



void createBoard() {

}

void createMesh() {
  
  
  
}
