# goodLog🪵 
### **easy logging for GameMaker projects**


## Features 🌟
 - Plug and Play (will not interfere with existing log systems)
 - Time-formatted logging both inside of GameMaker and to files
 - Highlight any given log output
 - Infinite number of simultaneous individual log files as desired
 - Supports the conversion of data types as expected with `show_debug_message()`
 - Highly customizable

## Setup 🛠️
1. Import the current release package from the [Releases Tab](https://github.com/brianlaclair/goodLog/releases) into your project.
2. You're ready to log anything!

## Logging 📝
The easy log script is set up in an object-oriented style, meaning that you can create new instances of logs anytime.
### Basic Usage 🐣 
In it's most basic use-case, you can create a globally accessible instance of goodLog by typing: 

    global.myLog = new goodLog();
Now, any time you want to log something:

    global.myLog.log("This is my first log!");

By default, this will be output into your GameMaker console as well as to a file called log.txt in your game's user directory.
The expected output would look something like:

    [05/24/2022 10:27:03] This is my first log!

**You can also highlight any log by giving it a title!** As an example, a modification to our initial log could look like:

    global.myLog.log("This is my first log!", "First Log!");

and would output:

    --------------------First Log!--------------------
    [05/24/2022 10:30:05] This is my first log!
    --------------------------------------------------


### Advanced Usage 👩‍🎓
As shown in the previous section, you can create instances of goodLog - as many as you want, in fact!
We can use this to do some awesome things - like write out to individual files for separate instances, name each individual log, and customize highlighted output.

Let's say we have two objects - in both object's Create Event's we'll create a new goodLog instance called "myLog".

*Note:*
`new goodLog` accepts two arguments: 
`new goodLog([log file, default "log.txt"], [output, default True to write out to a file]);`

**Object 1:**

    myLog = new goodLog("obj1.txt");
    myLog.log("Hello World!");

**Object 2:**
   

     myLog = new goodLog("obj2.txt");
     myLog.log("Hello World, again!");

Now both of these objects write to their defined output text file (as well as the GM console) without overlapping each other.
We can actually disable logging to a file when creating our new goodLog instance by using the arguments it accepts:

    myLog = new goodLog("", false);

You can also write to the same log that another instance of goodLog is using without any issue (for example, both writing to "obj1.txt") - but you may want to set  the title of the goodLog instance!

### goodLog Configuration Properties 🌟

To set the title of the log, you'd do something like this:

    myLog = new goodLog("log1.txt");
    myLog.config.logTitle = "Specific Title";
    myLog.log("This is my first log!");
Which would prepend the title to any log line using this instance of goodLog like:

    [05/24/2022 10:27:03] Specific Title: This is my first log!
You can adjust the title of any goodLog instance by changing `[goodLog Instance].config.logTitle` at any time.

But there are more properties to explore that can be controlled per goodLog instance!
Each of these can be accessed and modified by typing `[goodLog Instance].config.[property name]`

| Property | Default | What does it do? |
|--|--|--|
| logTitle | none | defines the name of the log within the entry |
| toFile | true | defines whether or not to output to a file |
| outputFile | "log.txt" | defines the file to log to (also set during instance creation) |
| silent | false | if set to true, will disable output to the GM console |
| inGameLog | false | if set to true, will save log output to the [goodLog Instance].logged array for your use in-game |
| sepChar | "-" | the character to use in separating highlighted messages from regular ones |
| sepLength | 50 | the number of sepChar's used to border highlighted messages |
| nlChar | "\n" | the character to denote new lines

As mentioned in the table, you can save logs in-game by turning on `[goodLog Instance].config.inGameLog = true;` this will write all entries to that instance (while inGameLog is set to true) to an array, accessible with `[goodLog Instance].logged`
  
## Contributing 🤝
If there are contributions you'd like to make to this project - open a pull request here!

**Potential Improvements you could work on:**

 - Easily customizable date formatting, i.e. `[goodLog Instance].config.timeFormat = "DD/MM/YY HH:mm:SS`
- ???