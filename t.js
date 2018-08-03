//// For discussion and comments, see: http://remysharp.com/2009/01/07/html5-enabling-script/
//(
//    function()
//    {
//        if(!/*@cc_on!@*/0)
//            return;
        
//        var e = "abbr,article,aside,audio,bb,canvas,datagrid,datalist," +
//            "details,dialog,eventsource,figure,footer,header,hgroup,mark," +
//            "menu,meter,nav,output,progress,section,time,video".split(',');
//        for(var i=0; i < e.length; i++)
//        {
//            document.createElement(e[i]);
//        }
//    }
//)()

var declaredVariable = 1;

function scoppedVariables() {
    undeclaredVariable = 10;
    var declaredVariable = 2;
    console.log("declaredVariable : " + declaredVariable); // 2
}

scoppedVariables();

console.log("undeclaredVariable but defined: " + undeclaredVariable); // 1
console.log("declaredVariable : " + declaredVariable); // 1


var undefinedVariable; // undefined
console.log("1. typeof undefinedVariable : " + typeof undefinedVariable); // "undefined"
console.log("2. undefinedVariable : " + undefinedVariable); // "undefined"
console.log("typeof eeee : " + typeof eeee); // "undefined"
//console.log("eeee : " + eeee); // "Uncaught ReferenceError: eeee is not defined at t.js: 36"

//undefinedFunction(); // undefined t.js:34 Uncaught ReferenceError: undefinedFunction is not defined at t.js: 34
typeof undefinedFunction; // "undefined"
console.log("typeof undefinedFunction : " + typeof undefinedFunction); // "undefined"

var definedVariable = 'test';
console.log("typeof definedVariable : " + typeof definedVariable); // "string"

function definedFunction(){
    return "I'm defined!"
}
console.log("typeof definedFunction : " + typeof definedFunction); // "string"


if (typeof(variable) !== "undefined") {
    console.log('variable is not undefined');
} else {
    console.log('variable is undefined');
}
console.log("typeof variable : " + typeof variable); // "object"

var nullVariable = null; // null
console.log("typeof nullVariable : " + typeof nullVariable); // "object"

if( variable === null ) {
    console.log('variable is null');
} else {
    console.log('variable is not null');
}