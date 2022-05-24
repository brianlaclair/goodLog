// goodLog written by Brian LaClair ( https://brianlaclair.com/ )
// Documentation at: https://github.com/brianlaclair/goodLog
// Contributions Welcome!

/// @function						goodLog([logfile], [writeToFile]);
/// @description					Create a new logging object
/// @param {string} [logfile]		The name of the file to log to
/// @param {string} [writeToFile]	Default True, can be set to false to disable file output
function goodLog(output = "log.txt", toFile = true) constructor {

	config				=	{
								sepChar		: "-",
								sepLength	: 50,
								nlChar		: "\n",
								logTitle	: undefined,
								outputFile	: output,
								toFile		: toFile,
								inGameLog	: false,
								silent		: false
							}
	
	logged				=	[];
	
	/// @function					log(output, [header]);
	/// @description				Add to the log
	/// @param {string} output		The value of what to output
	/// @param {string} [header]	A title to highlight the output with
	static log			=	function (output, header = undefined) {
								var s		= config.nlChar;
								var title	= "";
								
								if (!is_undefined(config.logTitle)) {
									title	= string(config.logTitle) + ": ";
								}
								
								var basicOut	= "[" + __timeStamp() + "] " + title + string(output)
								var trueOut		= s + basicOut;
								
								// if there's a header for the log, this is a special output - treat it as such
								if (!is_undefined(header)) {
									var remove	= ceil(string_length(header) / 2);
									var len		= config.sepLength / 2;
									var top		= __genSep(len - remove) + string(header) + __genSep(len - remove);
									var bottom	= __genSep(config.sepLength);
							
									basicOut	= top + trueOut + s + bottom;
									trueOut		= s + basicOut; 
								}
						
								// Log out to the array in real-time if enabled
								if (config.inGameLog) {
									array_push(logged, basicOut);
								}
						
								// Log out to the file in real-time if enabled
								if (config.toFile) {
									__appFile(trueOut);	
								}
						
								// Output to GM console if enabled
								if (!config.silent) {
									show_debug_message(basicOut);
								}
							}
							
	// generates a timestamp in the style of "MM/DD/YYYY HH:MM:SS" 	
	static __timeStamp	=  function() {
								var dateString = string_format(current_month, 2, 0) + "/" + string_format(current_day, 2, 0) + "/" + string_format(current_year, 2, 0);
								var timeString = string_format(current_hour, 2, 0) + ":" + string_format(current_minute, 2, 0) + ":" + string_format(current_second, 2, 0);
								
								// Adds leading 0's to the output string (ie, [ 5/24/2022  8: 1:16] becomes [05/24/2022 08:01:16]
								dateString	   = string_replace_all(dateString, " ", "0");
								timeString	   = string_replace_all(timeString, " ", "0");
						
								return dateString + " " + timeString;
						   }	
		
	
	// appends the current output to a file			
	static __appFile	=	function(text) {
								var write = file_text_open_append(config.outputFile);
								file_text_write_string(write, text);
								file_text_close(write);
							}
	
	// creates a separator for special output
	static __genSep		=	function (length = 50) {
								var ret = "";
						
								if (length <= 0) {
									return "";
								}
						
								for (var i = 0; i < length; i++) {
									ret += config.sepChar;
								}
								return ret;
							}

}
