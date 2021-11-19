public class Multiply {

    public static void main(String[] args) {

        System.out.print("product = " + multiply(1, 321) );
    }

    public static int multiply(int x, int y) {
        System.out.println("Multiply called: x = " + x + ", y = " + y);

        if (x == 0 || y == 0) {
            System.out.println("Zero case: x = " + x + ", y = " + y);
            return 0;
        }

        else if (x == 1 && y > 0) {
            return y;
        }

        else if (y == 1 && x > 0) {
            return x;
        }

        else if ( x == -1 && y > 0) {
            return -y;
        }

        else if ( y == -1 && x > 0) {
            return -x;
        }

        else if( y == -1 ) {
            System.out.println("y is == -1");
            return -x;
        }

        else if( x == -1 ) {
            System.out.println("x is == -1");
            return -y;
        }

        else if( y < 0 ) {
            System.out.println("y is < 0");
            return -x + multiply(x, y + 1);
        }

        else { 
            System.out.println("Last case: x = " + x + ", y = " + y);
            return x + multiply(x, y - 1);
        }
    }
}