// Generated by CoffeeScript 1.6.3
(function() {
  var tree;

  tree = {
    init: function() {
      chrome.tabs.getSelected(null, function(tab) {
        var ref, repo, user;
        user = tab.url.split("/")[3];
        repo = tab.url.split("/")[4];
        ref = tree.ref(tab.url);
        $(".repo-name").text("" + user + " / " + repo);
        return tree.fetchRoot(user, repo, ref, function(responseData) {
          var node, _i, _len, _results;
          _results = [];
          for (_i = 0, _len = responseData.length; _i < _len; _i++) {
            node = responseData[_i];
            _results.push($("#root").append(tree.nodeTag(node)));
          }
          return _results;
        });
      });
      $("#root").on("click", "a.file", function() {
        return chrome.tabs.update({
          url: $(this).attr("href")
        });
      });
      return $("#root").on("click", "a.dir", function() {
        var el, url;
        el = $(this);
        if (el.attr("state") === "open") {
          el.attr("state", "closed");
          el.prev().toggleClass("icon-folder-open icon-folder-close");
          return el.parent().children("div").remove();
        } else {
          el.attr("state", "open");
          el.prev().toggleClass("icon-folder-open icon-folder-close");
          url = el.attr("href");
          return tree.fetchContents(url, function(data) {
            var node, _i, _len, _results;
            _results = [];
            for (_i = 0, _len = data.length; _i < _len; _i++) {
              node = data[_i];
              _results.push(el.parent().append(tree.nodeTag(node)));
            }
            return _results;
          });
        }
      });
    },
    ref: function(url) {
      if (url.split("/").length > 7) {
        return url.split("/")[6];
      } else {
        return 'master';
      }
    },
    nodeTag: function(node) {
      var icon, out, url;
      icon = node.type === "dir" ? "icon-folder-close" : "icon-file";
      url = node.type === "dir" ? node.url : node.html_url;
      return out = "<div class=\"node " + node.type + "\">\n  <i class=\"" + icon + "\"></i>\n  <a href=\"" + url + "\" class=\"" + node.type + "\">" + node.name + "</a>\n</div>";
    },
    nodeTree: function(data) {
      var node, out, _i, _len;
      out = "";
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        node = data[_i];
        out += nodeTag(node);
      }
      return out;
    },
    fetchRoot: function(owner, repo, ref, callback) {
      var results;
      return results = $.getJSON("https://api.github.com/repos/" + owner + "/" + repo + "/contents?ref=" + ref, function(data) {
        return callback(data);
      });
    },
    fetchContents: function(url, callback) {
      var results;
      return results = $.getJSON(url, function(data) {
        return callback(data);
      });
    }
  };

  $(function() {
    return tree.init();
  });

}).call(this);