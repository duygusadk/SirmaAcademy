import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class CountLinesWordsAndCharacters {
    public static void main(String[] args) {
        String path = "./src/input.txt";


        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;

            int countLines = 0;
            int countWords = 0;
            int countCharacter = 0;

            while ((line = br.readLine()) != null) {
                countLines++;
                countCharacter += line.length();
                String[] wordsInLine = line.split("\\s+");
                countWords += wordsInLine.length;

            }
            System.out.println("Number of lines: " + countLines);
            System.out.println("Number of words: " + countWords);
            System.out.println("Number of character: " + countCharacter);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

}
