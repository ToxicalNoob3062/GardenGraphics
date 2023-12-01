class Flower {
    PVector center;
    int timer = millis();
    int receptacleSize;
    int totalPetals;
    int petalLength;
    int maxPetals = (int)random(5,10);
    
    Flower(PVector center, int receptacleSize, int totalPetals) {
        this.center = center;
        this.receptacleSize = receptacleSize;
        this.totalPetals = totalPetals;
        this.petalLength = this.receptacleSize * 3;
    }
    
    //draws the flower using bazieri curves by rotating the cordinates of the petals
    void draw(int receptacleColor, int petalColor) {
        // draw petals
        strokeWeight(2);
        stroke(0);
        fill(petalColor);
        float angleInterval = radians(360 / this.totalPetals);
        
        //basier curve -- will not explain maths!
        PVector basePoint = new PVector(center.x, center.y - receptacleSize / 2);
        PVector controlPoint = new PVector(center.x, center.y - receptacleSize / 2 - this.petalLength);
        for (int i = 0; i < this.totalPetals; i++) {    
            PVector basePoint2 = rotateCordinate(angleInterval , basePoint);
            PVector controlPoint2 = rotateCordinate(angleInterval, controlPoint);
            bezier(basePoint.x, basePoint.y, controlPoint.x, controlPoint.y, controlPoint2.x, controlPoint2.y, basePoint2.x, basePoint2.y);
            basePoint = basePoint2;
            controlPoint = controlPoint2;
        };
        
        // draw receptacle
        fill(receptacleColor);
        circle(center.x, center.y, receptacleSize);
    }
    
    //rotates a point around the center of the flower
    PVector rotateCordinate(float angle, PVector point) {
        float newX = cos(angle) * (point.x - center.x) - sin(angle) * (point.y - center.y) + center.x;
        float newY = sin(angle) * (point.x - center.x) + cos(angle) * (point.y - center.y) + center.y;
        return new PVector(newX, newY);
    }
    
    //grows the flower
    void grow() {
        if (this.receptacleSize > 25) {
            return;
        }
        if (millis() - this.timer > 300) {
            this.receptacleSize += 1;
            this.petalLength += 1;
            this.timer = millis();
        }
    }
    
    //increases the number of petals
    void increasePetals() {
        if (this.totalPetals < this.maxPetals) {
            this.totalPetals += 1;
        }
    }
}
