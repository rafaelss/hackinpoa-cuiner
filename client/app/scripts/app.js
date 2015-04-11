(function (console) { "use strict";
var MainClient = function() { };
MainClient.main = function() {
	console.log("Client> Initialize");
};
var q = window.jQuery;
var js = js || {}
js.JQuery = q;
MainClient.main();
})(typeof console != "undefined" ? console : {log:function(){}});
