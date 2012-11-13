tree =
  init: () ->
    chrome.tabs.getSelected null, (tab) ->
      user = tab.url.split("/")[3]
      repo = tab.url.split("/")[4]

      tree.fetchRoot user, repo, (responseData) ->
        $("#root").append tree.nodeTag(node) for node in responseData

    $("#root").on "click", "a.file", ->
      chrome.tabs.update({url: $(this).attr("href")})

    $("#root").on "click", "a.dir", ->
      el = $(this)

      if el.attr("state") is "open"
        el.attr("state", "closed")
        el.parent().children("div").remove()
      else
        el.attr("state", "open")
        url = el.attr("href")
        tree.fetchContents url, (data) ->
          el.parent().append tree.nodeTag(node) for node in data

  nodeTag: (node) ->
    out = """
          <div class="node #{node.type}">
            <a href="#{if node.type is "dir" then node.url else node.html_url}" class="#{node.type}">#{node.name}</a>
          </div>
          """
  nodeTree: (data) ->
    out = ""
    out += nodeTag(node) for node in data
    out

  fetchRoot: (owner, repo, callback) ->
    results = $.getJSON "https://api.github.com/repos/#{owner}/#{repo}/contents", (data) ->
      callback(data)

  fetchContents: (url, callback) ->
    results = $.getJSON url, (data) ->
      callback(data)

$ ->
  tree.init()
