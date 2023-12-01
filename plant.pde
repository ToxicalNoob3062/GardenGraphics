import java.text.DecimalFormat;

class Plant {
    Stem stem;
    Flower flower;
    Leaf[] leaves;
    int activeLeaves = 0;
    float timeInterval = 0;
    int  leafLength = 35;
    float currentTimeStamp = 0.25;
    int petalColor;
    int receptacleColor;
    
    Plant(PVector root) {
        this.stem = new Stem(root, 50);
        int totalLeaves = (int)this.stem.maxHeight / 50;
        this.flower = new Flower(stem.apex, 5, 3);
        this.leaves = new Leaf[totalLeaves];
        
        //calculate time interval for nodes of stem
        this.timeInterval = 1.0 / (totalLeaves);
        this.timeInterval = float(nf(this.timeInterval, 0, 2));  
        
        //flower decoration
        // Generate a random, light, and vibrant color for the petals
        this.petalColor = this.randomVibrantColor();
        
        // Generate a complementary color for the receptacle
        this.receptacleColor = this.randomVibrantColor();
        
    }
    
    //add leaf to given node of stem!
    void addLeaf(PVector[] points, float time) {
        //points are beziers points here to find a specific point on bezier curve
        if (this.activeLeaves == this.leaves.length) {
            return;
        }
        
        boolean leafFace = (this.activeLeaves % 2 == 0) ? true : false;
        this.leaves[this.activeLeaves] = new Leaf(leafFace,20,6,this.calculateBezierPoint(time,points),45,time);
        
        //keep track of how many leaves have i drawn!
        this.leaves[this.activeLeaves].maxLength = this.leafLength;
        this.leafLength += 5;
        this.activeLeaves++;
    }
    
    //calculate bezier point (maths)  from a bezier curve takiing time between 0 and 1 and 
    //return a point or a leaf node where leaf should be placed
    PVector calculateBezierPoint(float t, PVector[] points) {
        float u = 1 - t;
        float tt = t * t;
        float uu = u * u;
        float uuu = uu * u;
        float ttt = tt * t;
        
        // Linear interpolation between control points
        PVector p = PVector.lerp(points[0], points[1], t);
        PVector q = PVector.lerp(points[1], points[2], t);
        PVector r = PVector.lerp(points[2], points[3], t);
        
        // Second level of linear interpolation
        PVector s = PVector.lerp(p, q, t);
        PVector k = PVector.lerp(q, r, t);
        
        // Final point on the Bezier curve
        PVector finalPoint = PVector.lerp(s, k, t);
        return finalPoint;
    }
    
    
    //draw the plant
    void draw() {
        PVector[] points = stem.draw();
        for (int i = 0; i < this.activeLeaves; i++) {
            leaves[i].node = this.calculateBezierPoint(leaves[i].timeStamp,points);
            leaves[i].draw();
            leaves[i].grow();
        }
        flower.center = stem.apex;
        flower.draw(this.receptacleColor, this.petalColor);
    }
    
    //grow the plant
    void grow() {
        this.stem.grow();
        this.flower.grow();
        
        if (this.stem.plantHeight % 50 ==  0) {
            this.addLeaf(this.stem.draw(),this.currentTimeStamp);
            this.currentTimeStamp += this.timeInterval;
            this.flower.increasePetals();
        }
        
        this.draw();
    }
    
    // Generate a random, light, and vibrant color
    int randomVibrantColor() {
        float r = random(100, 255);
        float g = random(100, 255);
        float b = random(100, 255);
        
        // To ensure we have at least one high and one low component,
        // we can adjust the lowest component to be lower and the highest to be higher
        float minColor = min(r, min(g, b));
        float maxColor = max(r, max(g, b));
        
        if (r == minColor) r = random(0, 100);
        else if (r == maxColor) r = random(200, 255);
        
        if (g == minColor) g = random(0, 100);
        else if (g == maxColor) g = random(200, 255);
        
        if (b == minColor) b = random(0, 100);
        else if (b == maxColor) b = random(200, 255);
        
        return color(r, g, b);
    };
}
