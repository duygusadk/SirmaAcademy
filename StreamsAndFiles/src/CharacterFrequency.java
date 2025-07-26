import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class CharacterFrequency {
    public static void main(String[] args) {
        String path = "./src/input.txt";

        Map<String, Integer> letters = new LinkedHashMap<>();
        try (BufferedReader br = new BufferedReader(new FileReader(path))) {

            String line;
            while ((line = br.readLine()) != null) {
                String[] words = line.split("");

                for (String word : words) {
                    letters.put(word, letters.getOrDefault(word, 0) + 1);
                }

            }

            for (var i : letters.entrySet()) {
                System.out.println(i.getKey() + ":" + i.getValue());
            }


        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
