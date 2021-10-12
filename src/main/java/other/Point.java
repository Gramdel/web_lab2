package other;

import java.util.Date;

public class Point {
    int x;
    double y;
    double r;
    boolean isInArea;
    Date date;

    public Point(int x, double y, double r, boolean isInArea) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.isInArea = isInArea;
        this.date = new Date();
    }

    public int getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public boolean isInArea() {
        return isInArea;
    }

    public Date getDate() {
        return date;
    }
}
