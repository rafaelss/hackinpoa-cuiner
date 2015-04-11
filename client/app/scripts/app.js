(function () { "use strict";
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	CuinerFlags.Local = true;
	console.log("Cuiner> Initialize logged[" + Std.string(CuinerFlags.Logged) + "] root[" + CuinerFlags.get_Root() + "] path[" + CuinerFlags.get_Path() + "]");
	cnr.core.Web.LoadJSON("data/mockup-user.json",function(d,p) {
		if(p >= 1) console.log(d);
	});
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
var StringTools = function() { };
StringTools.__name__ = true;
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
};
var cnr = {};
cnr.core = {};
cnr.core.Web = function() { };
cnr.core.Web.__name__ = true;
cnr.core.Web.Load = function(p_url,p_callback) {
	var url = StringTools.replace(p_url,"./",cnr.core.Web.Root);
	var ld = new XMLHttpRequest();
	ld.open("GET",url,true);
	ld.onprogress = function(p_ev) {
		var ev = p_ev;
		var bl = ev.loaded;
		var bt = ev.total;
		var r;
		if(bt <= 0.0) r = 0.0; else r = 0.9999 * (bl / (bt + 5));
		p_callback(null,r);
	};
	ld.onload = function(p_ev1) {
		var ev1 = p_ev1;
		p_callback(ld.responseText,1.0);
	};
	ld.onerror = function(p_ev2) {
		p_callback(null,1.0);
	};
	ld.send();
};
cnr.core.Web.LoadJSON = function(p_url,p_callback) {
	cnr.core.Web.Load(p_url,function(s,p) {
		if(s != null) p_callback(s == ""?null:JSON.parse(s),p); else p_callback(null,p);
	});
};
var CuinerFlags = function() { };
CuinerFlags.__name__ = true;
CuinerFlags.get_Root = function() {
	if(CuinerFlags.Local) return "http://localhost:3000/"; else return "http://cuiner.herokuapp.com/";
};
CuinerFlags.get_Path = function() {
	var s = window.location.pathname;
	return HxOverrides.substr(s,1,null);
};
CuinerFlags.get_Page = function() {
	var p = CuinerFlags.get_Path().toLowerCase();
	if(p == "") return "home";
	if(p.indexOf("dashboard/user") >= 0) return "register-user";
	if(p.indexOf("dashboard/menu") >= 0) return "register-menu";
	return "";
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
String.__name__ = true;
Array.__name__ = true;
var q = window.jQuery;
js.JQuery = q;
cnr.core.Web.Root = "";
CuinerFlags.Logged = false;
CuinerFlags.Local = true;
Main.main();
})();
