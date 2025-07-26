import java.io.*;

public class MergeLinesFromTwoFiles {
    public static void main(String[] args) throws FileNotFoundException {
        String path = "./src/input.txt";
        String path2 = "./src/input2.txt";


        try (BufferedReader br1 = new BufferedReader(new FileReader(path));
             BufferedReader br2 = new BufferedReader(new FileReader(path2));
             PrintWriter writer = new PrintWriter(new FileWriter("./src/output"))) {

            String line1, line2 = null;
            while ((line1 = br1.readLine()) != null | (line2 = br2.readLine()) != null) {
                if (line1 != null) {
                    writer.println(line1);
                }
                if (line2 != null) {
                    writer.println(line2);
                }
            }


        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
