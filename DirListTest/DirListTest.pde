import java.util.Date;

String compDir = "C:\\Users\\seanp\\Documents\\Processing\\Kickstart\\DirListTest\\data";
File newestFile;
long lastModified = 0;
String latestName;

void setup() {
  
  ArrayList<File> allFiles = listFilesRecursive(compDir);
  for (File f : allFiles) {
    long lastModifiedNew = new Date(f.lastModified()).getTime();
    if (lastModifiedNew > lastModified) {
      newestFile = f;
      lastModified = lastModifiedNew;
    }
  }
  
  /* DEBUG OUTPUT
  
  long displayDate = new Date(newestFile.lastModified()).getTime();
  println("Last Modified File in Directory:");
  println("Name: " + newestFile.getName());
  println("Last Modified: " + displayDate);
  
  */
  
  latestName = newestFile.getName(); //Get the Name of the latest file in directory
  latestName = latestName.substring(0, latestName.indexOf(".")); //Grabs just the filename, and throws out extension
  println(latestName);

}

void draw() {
}

// Function to get a list of all files in a directory as an ArrayList
ArrayList<File> listFilesRecursive(String dir) {
  ArrayList<File> fileList = new ArrayList<File>(); 
  recurseDir(fileList, dir);
  return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList<File> a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    // a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } else {
    a.add(file);
  }
}