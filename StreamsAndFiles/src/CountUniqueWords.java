import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

public class CountUniqueWords {
    public static void main(String[] args) {
        String path = "./src/input.txt";

        Set<String>uniqueWords= new HashSet<>();
        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;
            while((line=br.readLine())!=null){
                String[] words=line.split("\\s+");
                for (var i:words){

                    uniqueWords.add(i.replaceAll("[^a-zA-Z]", "").toLowerCase());
                }

            }
            System.out.println("Unique words: "+uniqueWords.size());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
