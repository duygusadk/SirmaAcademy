import java.io.*;

public class WordLengths {
    public static void main(String[] args) throws IOException {
        String path = "./src/input.txt";

        try (BufferedReader br = new BufferedReader(new FileReader(path))) {

            String line ;
            while ((line= br.readLine())!=null) {
               String[] words= line.split("\\s+");
               for(var word:words){
                   System.out.print(word.length()+",");
               }
            }
        }

        catch (IOException e) {

            e.printStackTrace();

        }
    }
}
