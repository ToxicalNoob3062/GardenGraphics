class Garden{
    Plant[] plants;
    Butterfly[] butterflies;
    
    Garden(int totalPlants , int totalButterflies) {
        this.generatePlants(totalPlants);
        this.generateButterflies(totalButterflies);
    }
    
    //generate plants using plant class
    void generatePlants(int totalPlants) {
        this.plants = new Plant[totalPlants];
        float gap = width / (totalPlants + 1);
        float startX = gap;
        for (int i = 0; i < plants.length; i++) {
            plants[i] = new Plant(new PVector(startX,height - 3));
            startX += gap;
        }
    }
    
    //generate butterflies using butterfly class
    void generateButterflies(int totalButterflies) {
        this.butterflies = new Butterfly[totalButterflies];
        float gap = width / totalButterflies;
        float startX = 0;
        for (int i = 0; i < butterflies.length; i++) {
            butterflies[i] = new Butterfly((int)random(50,100), new PVector(startX,height / 2),random(1) > 0.5,height / 4);
            startX += gap;
        }
    }
    
    //draw the garden using plants and butterflies
    void draw() {
        background(51,153,255);
        this.drawSun();
        this.drawClouds();
        this.drawGround();
        for (int i = 0; i < this.plants.length; i++) {
            plants[i].grow();
        }
        for (int i = 0; i < this.butterflies.length; i++) {
            butterflies[i].draw();
        }
    }
    
    //draw the sun
    void drawSun() {
        float radius = width * 0.15;
        
        //form the circle
        stroke(0);
        fill(color(255,255, 51));
        circle(width,0,radius * 2);
    }
    
    //draw the ground
    void drawGround() {
        stroke(0);
        fill(color(0,255,0));
        ellipse(50,height,width,height / 3);
        ellipse(width,height,width,height / 3);
    }
    
    //draw the clouds
    void drawClouds() {
        fill(color(255,255,255));
        noStroke(); 
        arc(width * 0.1, height / 2, width * 0.22, width * 0.22, PI, TWO_PI);
        arc(width * 0.5, height / 2, width * 0.62, width * 0.62, PI, TWO_PI);
        arc(width * 0.9, height / 2, width * 0.22, width * 0.22, PI, TWO_PI);
        rect(0, height / 2, width, height / 2);
    };
    
}