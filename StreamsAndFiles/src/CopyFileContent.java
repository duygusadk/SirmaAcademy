import java.io.*;

public class CopyFileContent {
    public static void main(String[] args) throws FileNotFoundException {
        String path = "C:\\Users\\duygu\\Desktop\\sirma\\Lesson 13-Streams and Files\\StreamsAndFiles\\src\\input.txt";
        String outputPath = "C:\\Users\\duygu\\Desktop\\sirma\\Lesson 13-Streams and Files\\StreamsAndFiles\\src\\output.txt";


        try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(path)); BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(outputPath))) {

            int oneByte = 0;

            while ((oneByte = in.read()) >= 0) {

                out.write(oneByte);
            }

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }
}
