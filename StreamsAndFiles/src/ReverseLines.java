import java.io.*;

public class ReverseLines {
    public static void main(String[] args) {
        String path = "./src/input.txt";


        try (BufferedReader br = new BufferedReader(new FileReader(path));
             PrintWriter writer = new PrintWriter(new FileWriter("./src/output"))) {

            String line ;


            while ((line = br.readLine()) != null) {

              StringBuilder reversedLine=new StringBuilder(line);
              reversedLine.reverse();

                writer.write(String.valueOf(reversedLine));
                writer.write(System.lineSeparator());
            }




        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }
}
