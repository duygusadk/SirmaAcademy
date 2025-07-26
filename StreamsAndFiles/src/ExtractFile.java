import java.io.File;

public class ExtractFile {
    public static void main(String[] args) {

        String path="C:\\Users\\duygu\\Desktop\\sirma\\Lesson 13-Streams and Files\\StreamsAndFiles\\src\\input.txt";
        File file = new File(path);

        if(file.exists()){

            int dotIndex =file.getName().lastIndexOf('.');
            String name=file.getName().substring(0,dotIndex);
            String extension= file.getName().substring(dotIndex+1);
            long size= file.length();
            System.out.println("File name: " + name);
            System.out.println("File extension: " + extension);
            System.out.println("File size: " + size + " bytes");
        }
    }
}
