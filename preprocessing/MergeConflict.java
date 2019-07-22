import java.util.*;
import java.io.*;

public class MergeConflict {
    public static void main(String[] args) {
        if(args.length != 1) {
            System.out.println("File path not specified.");
            System.exit(-1);
        }
        ArrayList<String> lines = new ArrayList<String>();
        try {
            Scanner inFile = new Scanner(new FileReader(args[0]));
            while(inFile.hasNextLine()) {
                lines.add(inFile.nextLine());
            }
            inFile.close();
        } catch(FileNotFoundException ex) {
            System.out.println("File not found.");
        }
        ArrayList<String> fixed = new ArrayList<String>();
        for(int i=0; i<lines.size(); i++) {
            String line = lines.get(i);
            //System.out.println("line: " + line);
            if(line.contains("<<<<")) {
                continue;
            } else if (line.contains("====")) {
                while(!lines.get(i).contains(">>>>")) {
                    i = i + 1;
                }
            } else {
                //System.out.println("i: " + i);
                fixed.add(lines.get(i));
            }
        }
        printlist(fixed);
        /*
        try {
            PrintWriter outFile = new PrintWriter(new File(args[0]));
            for(int i = 0; i < fixed.size(); i++) {
                outFile.print(fixed.get(i));
            }
        } catch(FileNotFoundException ex) {
            System.out.println("out file not found.");
        }
        */


    }

    static void printlist(ArrayList<String> line) {
        for(int i = 0; i < line.size(); i++) {
            System.out.println(line.get(i));
        }
    }
}