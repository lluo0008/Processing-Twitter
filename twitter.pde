//http://www.cardatabase.net/search/photo_search.php?id= (insert number here)
//00061567 - 00061576 range for ferrari + skylines
//00061579 - 00061696




//This is a bot that will fetch images from wikepedia that specific car related keywords

//This program is modified from a twitter bot that fetches user's tweets containing specific keywords and also posts onto twitter as well.

import twitter4j.util.*;
import twitter4j.*;
import twitter4j.management.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.auth.*;

ConfigurationBuilder cb;
Twitter twitterInstance;
Query queryForTwitter;

int x, y;

String sequence;

String make;
String model;

String[] lines;
String[] wiki;

ArrayList<String> headlines;

PImage profile;
PImage car;
void setup() 
{
  cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("RsF4puqnbUVQHH9eNQqohaGbv"); 
  cb.setOAuthConsumerSecret("yme3JBSOcZStgBmO3j4AEBb3dLvaqe14nsIzWZiR7h9GABY59n");
  cb.setOAuthAccessToken("2866890737-6My6LYyDMaS2A5Lpjz729VrySZKDT5p8cupo0I1");
  cb.setOAuthAccessTokenSecret("xZitG7YhV6oxS1vTAKz8l7aoiYhRfJBlilSj896jxD667");

  sequence = "000" + int(random(61567, 61696));
  println(sequence);
  headlines = new ArrayList<String>();
  lines = loadStrings("http://www.cardatabase.net/search/photo_search.php?id=" + sequence);

  for (String line : lines)
  {
    if (line.contains("manufacturer=") && line.contains("\""))
    {
      int manuIndex = line.indexOf("manufacturer=");
      int endQuoteIndex = line.lastIndexOf("\"");
      if (manuIndex < 0 || endQuoteIndex < 0) 
      {
        println(line);
      } 
      else 
      {
        fill(255);
        stroke(255);
        textSize(50);
        make = line.substring(manuIndex + 13, endQuoteIndex);
        println(make);
      }
    }
    
    if (line.contains("model=") && line.contains("\""))
    {
      int modelIndex = line.indexOf("model=");
      int endQuoteIndex = line.lastIndexOf("\"");
      if (modelIndex < 0 || endQuoteIndex < 0) 
      {
        println(line);
      } 
      else 
      {
        model = line.substring(modelIndex + 6, endQuoteIndex);
        println(model);
      }
    }
  }
  
  wiki = loadStrings("https://en.wikipedia.org/wiki/" + make + "_" + model);
  
  for (String line : wiki)
  {
    if (line.contains(".jpg\" src=\"") && line.contains(".jpg\""))
    {
      int srcIndex = line.indexOf(".jpg\" src=\"");
      int endQuoteIndex = line.lastIndexOf(".jpg\"");
      if (srcIndex < 0 || endQuoteIndex < 0) 
      {
        println(line);
      } 
      
      else 
      {
        car = loadImage(line.substring(srcIndex + 11, endQuoteIndex + 4));
        car.save("temp.jpg");
        File f = new File("H:\\My Documents\\Processing\\twitter\\temp.jpg");
        
        println(line.substring(srcIndex + 11, endQuoteIndex + 4));
      }
    }
      
  }

  //String headline = headlines.get(4);
  //String[] words = headline.split(":");
  //println(words[0] + " " + words[1] + " " + words[2]);

  twitterInstance = new TwitterFactory(cb.build()).getInstance();
  queryForTwitter = new Query("#r34");

  size (1280, 720);
  background(0);
  //fetchAndDrawTweets();
}

void draw()
{
  background(0);
  text(make, 100, 100);
  text(model, 100, 200);
  
  image(car, 200, 200);
}

//void fetchAndDrawTweets() 
//{
//  try 
//  {
//    QueryResult result = twitterInstance.search(queryForTwitter);

//    ArrayList tweets = (ArrayList) result.getTweets();

//    for (int i = 0; i < tweets.size(); i++) 
//    {
//      Status t = (Status) tweets.get(i);
//      String user = t.getUser().getName();

//      String ppURL = t.getUser().getBiggerProfileImageURL();
//      profile = loadImage(ppURL);
//      String msg = t.getText();


//      image(profile, x, y);
//      if (dist(mouseX, mouseY, x + 40, y + 40) <= 80)
//      {
//        stroke(255);
//        noFill();
//        rect(x, y, 40, 40);
//      }
//      x += 100;
//      if (x >= width)
//      {
//        x = 0;
//        y += 100;
//      }


//      println(user + ": " + msg);
//      println("--------------------------------------------------------------------------------------------------------------------------------");
//    }
//  } 
//  catch (TwitterException te) 
//  {
//    println("Couldn't connect: " + te);
//  }
//}