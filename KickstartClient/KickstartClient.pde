import processing.net.*;
import java.util.Date;
import java.awt.Robot;
import java.awt.AWTException;

Client c;
String input;
String data[];
JSONObject json;
String JSONPath = "C:\\Users\\SMA\\Dropbox\\kickstart\\TestData";
Robot robot;

String videoPath = "C:\\Users\\SMA\\Dropbox\\kickstart\\TestData\\output";
File newestFile;
long lastModified = 0;
String latestName;

void setup() 
{
  size(500, 300);
  background(204);
  stroke(0);

  json = new JSONObject();

  // Connect to the server's IP address and port
  c = new Client(this, "192.168.1.3", 12345); // Replace with your server's IP and port

  //Start ze Robot!!
  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    println("Robot class error");
    exit();
  }
}

void draw() 
{
  // Receive data from server
  if (c.available() > 0) {
    if (c != null) {
      input = c.readString();
      input = input.substring(0, input.indexOf("\n")); // Only up to the newline
      data = split(input, ' '); // Split values into an array
      println(data[0]);
      println(data[1]);
      println("---");

      if (data[1].equals("badge") == true) {
        updateBadgeID();
      }

      if (data[1].equals("scan") == true) {
        println("Received Scan Command");
        scanForChanges();
      }

      if (data[1].equals("control") == true) {
        controlRecord(data[0]);
      }

      if (data[1].equals("charsel") == true) {
        characterSelect(data[0]);
      }
    }
  }
}

void characterSelect(String character) {
  if (character.equals("0") == true) {
    robot.keyPress(48); //Press "0" key
    robot.delay(10);
    robot.keyRelease(48); //Releases "0" key
    println("Selecting character 0");
  }
  if (character.equals("1") == true) {
    robot.keyPress(49); //Press "1" key
    robot.delay(10);
    robot.keyRelease(49); //Releases "1" key
    println("Selecting character 1");
  }
  if (character.equals("2") == true) {
    robot.keyPress(50); //Press "2" key
    robot.delay(10);
    robot.keyRelease(50); //Releases "2" key
    println("Selecting character 2");
  }
  if (character.equals("3") == true) {
    robot.keyPress(51); //Press "3" key
    robot.delay(10);
    robot.keyRelease(51); //Releases "3" key
    println("Selecting character 3");
  }
  if (character.equals("4") == true) {
    robot.keyPress(52); //Press "4" key
    robot.delay(10);
    robot.keyRelease(52); //Releases "4" key
    println("Selecting character 4");
  }
  if (character.equals("5") == true) {
    robot.keyPress(53); //Press "5" key
    robot.delay(10);
    robot.keyRelease(53); //Releases "5" key
    println("Selecting character 5");
  }
  if (character.equals("6") == true) {
    robot.keyPress(54); //Press "6" key
    robot.delay(10);
    robot.keyRelease(54); //Releases "6" key
    println("Selecting character 6");
  }
}

void controlRecord(String control) {
  if (control.equals("start") == true) {
    robot.keyPress(119); //Press "F8" key
    robot.delay(10);
    robot.keyRelease(119); //Releases "F8" key
    println("Sent F8 to start recording...");
  }

  if (control.equals("stop") == true) {
    robot.keyPress(119); //Press "F8" key
    robot.delay(10);
    robot.keyRelease(119); //Releases "F8" key
    println("Sent F8 to stop recording...");
  }

  if (control.equals("clear") == true) {
    robot.keyPress(65); //Press "A" key
    robot.delay(10);
    robot.keyRelease(65); //Releases "A" key
    println("Toggling Clear...");
  }
}

void updateBadgeID() {
  json.setString("badgeID", data[0]);
  println("Received: " + data[0] + " as badgeID");
}

void writeJSONFile() {
  println("Saving new JSON file...");
  saveJSONObject(json, JSONPath+ "\\" + latestName+".json");
}

void scanForChanges() {

  ArrayList<File> allFiles = listFilesRecursive(videoPath);
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
  println("New File Found: " + latestName);

  json.setString("Guid", latestName);
  json.setString("MediaFileName", latestName+".mp4");

  writeJSONFile(); //Write the JSON
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