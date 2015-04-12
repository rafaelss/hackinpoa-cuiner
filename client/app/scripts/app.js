(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var CuinerApplication = function() {
	CuinerApplication.instance = this;
};
CuinerApplication.prototype = {
	Run: function() {
		console.log("CuinerApplication> Run");
		this.view = new cnr.view.CuinerView();
		this.controller = new cnr.controller.CuinerController();
		this.controller.LoadUserData();
	}
};
var CuinerEntity = function() {
};
CuinerEntity.prototype = {
	get_application: function() {
		return CuinerApplication.instance;
	}
};
var HxOverrides = function() { };
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
Main.main = function() {
	cnr.model.CuinerModel.Local = true;
	window.onload = function(ev) {
		console.log("Cuiner> Initialize root[" + cnr.model.CuinerModel.get_Root() + "] path[" + cnr.model.CuinerModel.get_Path() + "]");
		Main.app = new CuinerApplication();
		Main.app.Run();
	};
};
var StringTools = function() { };
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
};
var cnr = {};
cnr.controller = {};
cnr.controller.CuinerController = function() {
	CuinerEntity.call(this);
};
cnr.controller.CuinerController.__super__ = CuinerEntity;
cnr.controller.CuinerController.prototype = $extend(CuinerEntity.prototype,{
	LoadUserData: function() {
		console.log("CuinerController> LoadUserData [" + cnr.model.CuinerWS.UserInit + "]");
		cnr.core.Web.LoadJSON(cnr.model.CuinerWS.UserInit,$bind(this,this.OnUserDataLoad));
	}
	,OnUserDataLoad: function(p_data,p_progress) {
		if(p_progress >= 1) {
			if(p_data != null) {
				console.log("CuinerController> LoadUserData Success");
				cnr.model.CuinerModel.UserLoginData = p_data;
			} else console.log("CuinerController> LoadUserData Failed");
		}
	}
	,ProcessLogin: function(p_data) {
		var _g = this;
		this.get_application().view.home.modal.SetLoginError("");
		cnr.core.Web.Send(cnr.model.CuinerWS.UserLogin,p_data,function(r,p) {
			if(p >= 1) {
				if(r == null) {
					console.log("CuinerController> Login Error");
					_g.get_application().view.home.modal.SetLoginError("Erro Desconhecido!");
				} else {
					console.log("CuinerController> Login Success");
					_g.get_application().view.home.modal.SetLoginError("Sucesso!");
					console.log(r);
				}
			}
		});
	}
});
cnr.core = {};
cnr.core.Web = function() { };
cnr.core.Web.Process = function(p_url,p_method,p_data,p_callback) {
	var url = StringTools.replace(p_url,"./",cnr.core.Web.Root);
	var ld = new XMLHttpRequest();
	ld.open(p_method,url,true);
	ld.onprogress = function(p_ev) {
		var ev = p_ev;
		var bl = ev.loaded;
		var bt = ev.total;
		var r;
		if(bt <= 0.0) r = 0.0; else r = 0.9999 * (bl / (bt + 5));
		if(ld.status == 200) p_callback(null,r);
	};
	ld.onload = function(p_ev1) {
		var ev1 = p_ev1;
		if(ld.status == 404) p_callback(null,1.0);
		if(ld.status == 200) p_callback(ld.responseText,1.0);
	};
	ld.onerror = function(p_ev2) {
		p_callback(null,1.0);
	};
	if(p_data != null) ld.send(p_data); else ld.send();
};
cnr.core.Web.Load = function(p_url,p_callback) {
	cnr.core.Web.Process(p_url,"GET",null,p_callback);
};
cnr.core.Web.LoadJSON = function(p_url,p_callback) {
	cnr.core.Web.Load(p_url,function(s,p) {
		if(s != null) p_callback(s == ""?null:JSON.parse(s),p); else p_callback(null,p);
	});
};
cnr.core.Web.Send = function(p_url,p_data,p_callback,p_method) {
	if(p_method == null) p_method = "POST";
	var o = p_data;
	var d = new FormData();
			
			for (var s in o) d[s] = o[s];
		;
	console.log(d);
	cnr.core.Web.Process(p_url,p_method,d,p_callback);
};
cnr.model = {};
cnr.model.CuinerWS = function() { };
cnr.model.CuinerModel = function() { };
cnr.model.CuinerModel.get_Root = function() {
	if(cnr.model.CuinerModel.Local) return "http://localhost:3000/"; else return "http://cuiner.herokuapp.com/";
};
cnr.model.CuinerModel.get_Path = function() {
	var s = window.location.pathname;
	return HxOverrides.substr(s,1,null);
};
cnr.model.CuinerModel.get_Page = function() {
	var p = cnr.model.CuinerModel.get_Path().toLowerCase();
	if(p == "") return "home";
	if(p.indexOf("dashboard/user") >= 0) return "register-user";
	if(p.indexOf("dashboard/menu") >= 0) return "register-menu";
	return "";
};
cnr.view = {};
cnr.view.CuinerView = function() {
	CuinerEntity.call(this);
	console.log("CuinerView> ctor page[" + cnr.model.CuinerModel.get_Page() + "]");
	var _g = cnr.model.CuinerModel.get_Page();
	switch(_g) {
	case "home":
		this.home = new cnr.view.home.HomeView();
		break;
	}
};
cnr.view.CuinerView.__super__ = CuinerEntity;
cnr.view.CuinerView.prototype = $extend(CuinerEntity.prototype,{
});
cnr.view.home = {};
cnr.view.home.HomeModalView = function() {
	var _g = this;
	CuinerEntity.call(this);
	this.element = window.document.getElementById("modal");
	var bkg = this.element.children[0];
	bkg.onclick = function(ev) {
		console.log("HomeModalView> Background Click");
		_g.Hide();
	};
};
cnr.view.home.HomeModalView.__super__ = CuinerEntity;
cnr.view.home.HomeModalView.prototype = $extend(CuinerEntity.prototype,{
	get_RegisterData: function() {
		var res = { };
		var f;
		f = window.document.getElementById("field-register-name");
		res.name = f.value;
		f = window.document.getElementById("field-register-surname");
		res.surname = f.value;
		f = window.document.getElementById("field-register-email");
		res.email = f.value;
		f = window.document.getElementById("field-register-password");
		res.password = f.value;
		return res;
	}
	,get_LoginData: function() {
		var res = { };
		var f;
		f = window.document.getElementById("field-login-email");
		res.email = f.value;
		f = window.document.getElementById("field-login-password");
		res.password = f.value;
		return res;
	}
	,Show: function(p_mode) {
		var _g = this;
		this.element.style.display = "block";
		haxe.Timer.delay(function() {
			_g.element.style.opacity = "1.0";
		},100);
		if(p_mode == "modal-login") window.document.getElementById("modal-login").style.display = "block"; else window.document.getElementById("modal-login").style.display = "none";
		if(p_mode == "modal-register") window.document.getElementById("modal-register").style.display = "block"; else window.document.getElementById("modal-register").style.display = "none";
	}
	,Hide: function() {
		var _g = this;
		this.element.style.opacity = "0.0";
		haxe.Timer.delay(function() {
			_g.element.style.display = "none";
		},402);
	}
	,SetLoginError: function(p_msg) {
		var el = window.document.getElementById("lb-login-error");
		el.innerHTML = p_msg;
	}
	,SetRegisterError: function(p_msg) {
		var el = window.document.getElementById("lb-register-error");
		el.innerHTML = p_msg;
	}
});
cnr.view.home.HomeView = function() {
	CuinerEntity.call(this);
	console.log("HomeView> ctor");
	this.modal = new cnr.view.home.HomeModalView();
	var bt;
	var btl = ["bt-location","bt-register","bt-login","bt-search","bt-form-login","bt-form-register","bt-publish"];
	var _g1 = 0;
	var _g = btl.length;
	while(_g1 < _g) {
		var i = _g1++;
		bt = window.document.getElementById(btl[i]);
		if(bt == null) {
			console.log("[" + btl[i] + "]");
			continue;
		}
		bt.onclick = $bind(this,this.OnButtonClick);
	}
};
cnr.view.home.HomeView.__super__ = CuinerEntity;
cnr.view.home.HomeView.prototype = $extend(CuinerEntity.prototype,{
	OnButtonClick: function(p_event) {
		var ev = p_event;
		var el = ev.currentTarget;
		console.log("HomeView> Clicked [" + el.id + "]");
		var _g = el.id;
		switch(_g) {
		case "bt-location":
			break;
		case "bt-register":
			this.modal.Show("modal-register");
			break;
		case "bt-login":
			this.modal.Show("modal-login");
			break;
		case "bt-search":
			break;
		case "bt-form-register":
			console.log(this.modal.get_RegisterData());
			break;
		case "bt-form-login":
			console.log(this.modal.get_LoginData());
			this.get_application().controller.ProcessLogin(this.modal.get_LoginData());
			break;
		}
	}
});
var haxe = {};
haxe.Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe.Timer.delay = function(f,time_ms) {
	var t = new haxe.Timer(time_ms);
	t.run = function() {
		t.stop();
		f();
	};
	return t;
};
haxe.Timer.prototype = {
	stop: function() {
		if(this.id == null) return;
		clearInterval(this.id);
		this.id = null;
	}
	,run: function() {
	}
};
var js = {};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
var q = window.jQuery;
js.JQuery = q;
cnr.core.Web.Root = "";
cnr.model.CuinerWS.UserInit = "./init";
cnr.model.CuinerWS.UserLogin = "http://cuiner.herokuapp.com/user/authenticate";
cnr.model.CuinerWS.UserRegister = "./register";
cnr.model.CuinerModel.Logged = false;
cnr.model.CuinerModel.Local = true;
cnr.model.CuinerModel.UserLoginData = { };
Main.main();
})();
