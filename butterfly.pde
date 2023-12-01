class Butterfly{
    int size;
    PVector wing1;
    PVector wing2;
    int timer = millis();
    boolean wingState = true; //wing is upp or down!
    int wingColor;
    float amplitude; // amplitude of the sine wave
    boolean direction; // direction of movement
    
    // Constructor
    public Butterfly(int size , PVector location , boolean direction, float amplitude) {
        this.size = size;
        this.wing1 = location;
        this.wing2 = new PVector(location.x + 15 * (this.direction ?-  1 : 1), location.y);
        this.wingColor = this.randomVibrantColor();
        this.amplitude = amplitude;
        this.direction = direction;
    }
    
    // Draw the butterfly
    void draw() {
        this.drawWing(this.wing1, this.wingState ?-  120 : 120);
        this.drawWing(this.wing2, this.wingState ?-  100 : 100);
        this.drawBody();
        this.flapWings();
    }
    
    // Rotate a point around a center point
    PVector rotateCordinate(float angle, PVector point , PVector center) {
        float newX = cos(angle) * (point.x - center.x) - sin(angle) * (point.y - center.y) + center.x;
        float newY = sin(angle) * (point.x - center.x) + cos(angle) * (point.y - center.y) + center.y;
        return new PVector(newX, newY);
    }
    
    // Draw a wing using bezier curves
    void drawWing(PVector location , int angle) {
        PVector controlPoint1 = new PVector(location.x + this.size * (this.direction ?-  1 : 1), location.y);
        PVector controlPoint2 = this.rotateCordinate(radians(angle) * (this.direction ?-  1 : 1), controlPoint1, location);
        
        // Draw the wing
        strokeWeight(3);
        fill(color(this.wingColor));
        bezier(location.x, location.y, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, location.x, location.y);
    }
    
    // Draw the body of the butterfly
    void drawBody() {
        stroke(color(0));
        strokeWeight(5);
        if (this.direction)  {
            circle(wing2.x,wing2.y,6);
            line(wing2.x,wing2.y,wing1.x - this.size * 0.4,wing1.y);
            
        }
        else {
            circle(wing1.x,wing1.y,6);
            line(wing1.x,wing1.y,wing2.x + this.size * 0.4,wing2.y);
        }
    }
    
    // Flap the wings
    void flapWings() {
        if (millis() - this.timer > 150) {
            this.timer = millis();
            this.wingState = !this.wingState;
        }
        this.moveAround();
    }
    
    // Generate a random vibrant color
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
    
    // Move the butterfly around (here i am follwoing a +sine and -sine wave to form infinity loop)
    void moveAround() {
        // Move the butterfly in one direction
        if (this.direction) {
            // Calculate the new x position
            this.wing2.x += 0.5;
            
            // Calculate the new y position based on a sine wave
            this.wing2.y = this.amplitude + this.amplitude * 0.8 * sin(TWO_PI * this.wing2.x / width);
            
            // Check if the butterfly has reached one end and needs to change direction
            if (this.wing2.x > width) {
                this.direction = !this.direction;
            }
            
            // Update wing1's position based on wing2
            this.wing1.x = this.wing2.x + 15 * (this.direction ?-  1 : 1);
            this.wing1.y = this.wing2.y;
        }
        // Move the butterfly in the other direction 
        else {
            // Calculate the new x position
            this.wing1.x -= 0.5;
            
            // Calculate the new y position based on a negative sine wave
            this.wing1.y = this.amplitude - this.amplitude * 0.8 * sin(TWO_PI * this.wing1.x / width);
            
            // Check if the butterfly has reached one end and needs to change direction
            if (this.wing1.x < 0) {
                this.direction = !this.direction;
            }
            
            // Update wing2's position based on wing1
            this.wing2.x = this.wing1.x + 15 * (this.direction ?-  1 : 1);
            this.wing2.y = this.wing1.y;
        }
    }     
}