
/*
 Copyright (C) <2012> <haithem bel haj>
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

(function() {
  window.Router = (function() {
    Router.namedParam = /:\w+/g
    Router.splatParam = /\*\w+/g

    function Router(routes) {
      var _this = this
      this.routes = routes != null ? routes : {}
    }

    Router.prototype.route = function(route, callback) {
      route = route.replace(Router.namedParam, '([^\/]+)').replace(Router.splatParam, '(.*?)')
      return this.routes["^" + route + "$"] = callback
    }

    Router.prototype.checkRoutes = function(state) {
      var callback, regex, regexText, elem, _ref;
      _ref = this.routes;
      for (regexText in _ref) {
        callback = _ref[regexText]
        regex = new RegExp(regexText)
        elem = document.createElement('a')
        elem.href = state.hash
        if (regex.test(elem.pathname))
          callback.apply(window, regex.exec(elem.pathname).slice(1))
      }

      return true
    }

    Router.prototype.navigate = function(url) {
      return this.checkRoutes({ hash: url })
    }

    Router.prototype.start = function() {
      return this.checkRoutes({ hash: window.location.href })
    }

    return Router
  })()
}).call(this)
