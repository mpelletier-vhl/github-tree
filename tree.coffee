
tree =
  init: () ->
    chrome.tabs.getSelected null, (tab) ->
      user = tab.url.split("/")[3]
      repo = tab.url.split("/")[4]
      ref = tree.ref tab.url

      $(".repo-name").text("#{user} / #{repo}")

      tree.fetchRoot user, repo, ref, (responseData) ->
        $("#root").append tree.nodeTag(node) for node in responseData

    $("#root").on "click", "a.file", ->
      chrome.tabs.update({url: $(this).attr("href")})

    $("#root").on "click", "a.dir", ->
      el = $(this)

      if el.attr("state") is "open"
        el.attr("state", "closed")
        el.prev().toggleClass("icon-folder-open icon-folder-close")
        el.parent().children("div").remove()
      else
        el.attr("state", "open")
        el.prev().toggleClass("icon-folder-open icon-folder-close")
        url = el.attr("href")
        tree.fetchContents url, (data) ->
          el.parent().append tree.nodeTag(node) for node in data

  ref: (url) ->
    if url.split("/").length > 7
      url.split("/")[6]
    else
      'master'

  nodeTag: (node) ->
    icon = if node.type is "dir" then "icon-folder-close" else "icon-file"
    url = if node.type is "dir" then node.url else node.html_url
    out = """
          <div class="node #{node.type}">
            <i class="#{icon}"></i>
            <a href="#{url}" class="#{node.type}">#{node.name}</a>
          </div>
          """
  nodeTree: (data) ->
    out = ""
    out += nodeTag(node) for node in data
    out

  fetchRoot: (owner, repo, ref, callback) ->
    results = $.getJSON "https://api.github.com/repos/#{owner}/#{repo}/contents?ref=#{ref}", (data) ->
      callback(data)

  fetchContents: (url, callback) ->
    results = $.getJSON url, (data) ->
      callback(data)

$ ->
  tree.init()
