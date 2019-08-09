(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['groceries'] = template({"1":function(container,depth0,helpers,partials,data) {
    return "    <div class='grocery-item'>\r\n    <p>Item: "
    + container.escapeExpression(container.lambda((depth0 != null ? depth0.item : depth0), depth0))
    + " </p>\r\n    </div>\r\n";
},"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var stack1;

  return "﻿"
    + ((stack1 = helpers.each.call(depth0 != null ? depth0 : (container.nullContext || {}),(depth0 != null ? depth0.groceries : depth0),{"name":"each","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "");
},"useData":true});
})();