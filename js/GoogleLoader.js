smalltalk.addPackage('GoogleLoader', {});
smalltalk.addClass('GoogleLoader', smalltalk.Object, [], 'GoogleLoader');
smalltalk.GoogleLoader.comment="I am load the Google JSAPI spec\x0a\x0ahttps://developers.google.com/loader/\x0a\x0aUsage:\x0a\x09GoogleLoader onLoadCallback: aBlock\x0a    \x0a    "
smalltalk.addMethod(
"_initialize",
smalltalk.method({
selector: "initialize",
category: 'not yet classified',
fn: function (){
var self=this;
return self},
args: [],
source: "initialize\x0a\x09",
messageSends: [],
referencedClasses: []
}),
smalltalk.GoogleLoader);


smalltalk.addMethod(
"_basicLoad_",
smalltalk.method({
selector: "basicLoad:",
category: 'not yet classified',
fn: function (aBlock){
var self=this;
return smalltalk.withContext(function($ctx1) { $.getScript("https://www.google.com/jsapi",aBlock);;
return self}, function($ctx1) {$ctx1.fill(self,"basicLoad:",{aBlock:aBlock}, smalltalk.GoogleLoader.klass)})},
args: ["aBlock"],
source: "basicLoad: aBlock\x0a\x09\x22Do the callback once jaspi is loaded\x22\x0a\x09<$.getScript(\x22https://www.google.com/jsapi\x22,aBlock);>",
messageSends: [],
referencedClasses: []
}),
smalltalk.GoogleLoader.klass);

smalltalk.addMethod(
"_isLoaded",
smalltalk.method({
selector: "isLoaded",
category: 'not yet classified',
fn: function (){
var self=this;
return smalltalk.withContext(function($ctx1) { return typeof(google) !== 'undefined' && typeof(google.load)  == 'function';
return self}, function($ctx1) {$ctx1.fill(self,"isLoaded",{}, smalltalk.GoogleLoader.klass)})},
args: [],
source: "isLoaded\x0a\x09\x22Test that the google.load() function is defined.\x22\x0a\x09<return typeof(google) !== 'undefined' && typeof(google.load)  == 'function'>",
messageSends: [],
referencedClasses: []
}),
smalltalk.GoogleLoader.klass);

smalltalk.addMethod(
"_load_",
smalltalk.method({
selector: "load:",
category: 'not yet classified',
fn: function (aBlock){
var self=this;
return smalltalk.withContext(function($ctx1) { var $1;
$1=_st(self)._isLoaded();
if(smalltalk.assert($1)){
_st(aBlock)._value();
} else {
_st(self)._basicLoad_(aBlock);
};
return self}, function($ctx1) {$ctx1.fill(self,"load:",{aBlock:aBlock}, smalltalk.GoogleLoader.klass)})},
args: ["aBlock"],
source: "load: aBlock\x0a\x09\x22Do the callback on load or immediately if already loaded.\x22\x0a    \x09self isLoaded \x0a        \x09ifTrue:[aBlock value]\x0a      \x09\x09ifFalse: [self basicLoad:aBlock]",
messageSends: ["ifTrue:ifFalse:", "value", "basicLoad:", "isLoaded"],
referencedClasses: []
}),
smalltalk.GoogleLoader.klass);


