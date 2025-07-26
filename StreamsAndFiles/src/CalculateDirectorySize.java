import java.io.File;

public class CalculateDirectorySize {
    public static void main(String[] args) {
        String path="C:\\Users\\duygu\\Desktop\\sirma\\Lesson 13-Streams and Files\\StreamsAndFiles\\src";
        File file = new File(path);

        long sum=0;
        if(file.exists()&& file.isDirectory()){
            File[] files=file.listFiles();

            for(File f:files){
                sum+=f.length();
            }
        }

        System.out.println("Total sum:"+sum);
    }
}
