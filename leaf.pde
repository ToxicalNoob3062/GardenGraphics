class Leaf {
    boolean rightFaced;
    int len;
    int size;
    float angle;
    float timeStamp; //will be used by plant class to redraw the leaf on same stem nodes!
    int timer = millis();
    int maxLength;
    PVector node;
    
    
    Leaf(boolean rightFaced, int len, int size, PVector node, int theta, float timeStamp) {
        this.rightFaced = rightFaced;
        this.len = len;
        this.size = size;
        this.node = node;
        this.timeStamp = timeStamp;
        this.angle = this.rightFaced ? radians( -theta) : radians(theta);
    }
    
    //draws the leaf using bezier curve that i wont explain!
    void draw() {
        strokeWeight(2);
        stroke(0);
        fill(color(52, 235, 97));
        
        int x = (int) this.node.x;
        int y = (int) this.node.y;
        
        int endX = x + (this.rightFaced ? this.len : - this.len);
        
        PVector endPoint = rotateCordinate(angle, new PVector(endX, y));
        PVector cordinatePoint = findCordinatePoint( -1);
        PVector cordinatePoint2 = findCordinatePoint(1);
        
        bezier(x, y, cordinatePoint.x, cordinatePoint.y, cordinatePoint.x, cordinatePoint.y, endPoint.x, endPoint.y);
        bezier(x, y, cordinatePoint2.x, cordinatePoint2.y, cordinatePoint2.x, cordinatePoint2.y, endPoint.x, endPoint.y);
        
        //line vein 40% of the leaf
        float veinLength = this.len * 0.4;
        PVector veinEndPoint = rotateCordinate(angle, new PVector(x + (this.rightFaced ? veinLength : - veinLength), y));
        line(x, y, veinEndPoint.x, veinEndPoint.y);
    }
    
    //rotates a point around a node
    PVector rotateCordinate(float angle, PVector point) {
        float newX = cos(angle) * (point.x - node.x) - sin(angle) * (point.y - node.y) + node.x;
        float newY = sin(angle) * (point.x - node.x) + cos(angle) * (point.y - node.y) + node.y;
        return new PVector(newX, newY);
    }
    
    //finds the cordinate point of the leaf for bezier curve drawing!
    PVector findCordinatePoint(int direction) {
        int Xcon = this.size / 3;
        float corX = this.node.x + (this.rightFaced ? Xcon :-  Xcon);
        float corY = this.node.y + (this.size * direction);
        return rotateCordinate(angle, new PVector(corX, corY));
    }
    
    //grows the leaf
    void grow() {
        if (this.len > this.maxLength) return;
        if (millis() - this.timer > 500) {
            this.timer = millis();
            this.len += 3;
            this.size = Math.round(this.len * 0.3);
        }
    }
}
