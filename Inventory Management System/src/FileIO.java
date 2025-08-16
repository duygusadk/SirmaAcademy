import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileIO {
    static String inputPath = "C:\\Users\\duygu\\Desktop\\sirma\\Lesson 15-Inheritance & Interfaces\\Abstraction & Encapsulation\\Abstraction-Encapsulation\\src\\items.csv";
    static String outputPath = "C:\\Users\\duygu\\Desktop\\sirma\\Lesson 15-Inheritance & Interfaces\\Abstraction & Encapsulation\\Abstraction-Encapsulation\\src\\output.txt";

    public static List<InventoryItem> loadFile() {

        List<InventoryItem> items = new ArrayList<>();
        try (BufferedReader in = new BufferedReader(new FileReader(inputPath))) {

            String line = in.readLine();

            while (line != null) {
                line = in.readLine();
                if (line != (null)) {
                    String[] data = line.split(",");
                    InventoryItem item = new InventoryItem(data[0],
                            data[1],
                            Double.parseDouble(data[2]),
                            Integer.parseInt(data[3]),
                            Boolean.parseBoolean(data[4]),
                            Boolean.parseBoolean(data[5]), data[6]);
                    items.add(item);
                }


            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        return items;

    }


}


