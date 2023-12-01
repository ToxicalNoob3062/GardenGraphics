

class Stem{
    PVector root;
    PVector apex;
    float  plantHeight;
    //will wave slightly due to wind and gravity in this horizontal range
    float horizontalRange;
    boolean waveState = true;
    int maxHeight = (int)random(180, 301);
    
    Stem(PVector root, float plantHeight) {
        this.root = root;
        this.plantHeight = plantHeight;
        this.apex = new PVector(root.x, root.y - plantHeight);
        this.horizontalRange = (root.y - apex.y) / 8;
    }
    
    //draws the stem and returns the bezier points of the stem
    PVector[] draw() {
        this.apex = new PVector(root.x, root.y - plantHeight);
        PVector cordinatePoint1 = this.findCordinatePoint(1);
        PVector cordinatePoint2 = this.findCordinatePoint( -1);
        
        noFill();
        stroke(26,85,8);
        strokeWeight(6);
        bezier(apex.x, apex.y, cordinatePoint1.x, cordinatePoint1.y, cordinatePoint2.x, cordinatePoint2.y, root.x, root.y);
        this.wavyStem();
        
        return new PVector[]{apex,cordinatePoint1,cordinatePoint2,root};
    }
    
    //finds the cordinate point of the bezier curve to form stem!
    PVector findCordinatePoint(int direction) {
        float xMid = (root.x + apex.x) / 2;
        float yMid = (root.y + apex.y) / 2;
        float xCordinate = xMid + direction * this.horizontalRange;
        
        return new PVector(xCordinate, yMid);
    }
    
    //makes the stem wave slightly within horizontal range
    void wavyStem() {
        float rangeConst = (root.y - apex.y) / 8;
        if (waveState) this.horizontalRange -= 0.25;
        else this.horizontalRange += 0.25;
        if (this.horizontalRange <= -rangeConst) waveState = false;
        if (this.horizontalRange >= rangeConst) waveState = true;
    }
    
    //grows the stem
    void grow() {
        if (this.plantHeight < this.maxHeight) this.plantHeight += 0.5;
    }
}