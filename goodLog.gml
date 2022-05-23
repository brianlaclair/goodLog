function goodLog(output = "log.txt", toFile = true) constructor {

	config				=	{
								stringSep	: "-",
								sepLength	: 50,
								sepChar		: "\n",
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
								var trueOut	= "[" + __timeStamp() + "]: " + string(output);
								var s		= config.sepChar;
						
								// if there's a header for the log, this is a special output - treat it as such
								if (!is_undefined(header)) {
									var remove	= ceil(string_length(header) / 2);
									var len		= config.sepLength / 2;
									var top		= __genSep(len - remove) + string(header) + __genSep(len - remove);
									var bottom	= __genSep(config.sepLength);
							
									trueOut		= s + top + s + trueOut + s + bottom + s; 
								}
						
								// Log out to the array in real-time if enabled
								if (config.inGameLog) {
									array_push(logged, trueOut);
								}
						
								// Log out to the file in real-time if enabled
								if (config.toFile) {
									__appFile(trueOut);	
								}
						
								// Output to GM console if enabled
								if (!config.silent) {
									show_debug_message(trueOut);
								}
							}
							
	// generates a timestamp in the style of "MM/DD/YYYY HH:MM:SS" 	
	static __timeStamp	=  function() {
								var dateString = string(current_month) + "/" + string(current_day) + "/" + string(current_year);
								var timeString = string(current_hour) + ":" + string(current_minute) + ":" + string(current_second);
						
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
									ret += config.stringSep;
								}
								return ret;
							}

}
