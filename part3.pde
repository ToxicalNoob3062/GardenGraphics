Garden garden;

void setup() {
    size(800, 600);
    garden = new Garden(8,6);
}

void draw() {
    garden.draw();
}