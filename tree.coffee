# tree.init() is called as a $(document).ready() callback

tree =
  init: () ->
    tree.fetch "thmzlt", "github-tree", "", (responseData) ->
      $("#root").append tree.nodeTag(node) for node in responseData
      #$ ->
      #  $(".tree .node a.dir").on "click", ->
      #    it = $(@)

      #    if it.attr("state") == "open"
      #      it.attr("state", "closed")
      #      it.parent().children("div").remove()
      #    else
      #      it.attr("state", "open")
      #      it.after("<div class='tree'>#{nodeTree(moreData)}</ul>")

      #  $(".tree .node a.file").on "click", ->
      #    # do nothing yet

  nodeTag: (node) ->
    out = """
          <div class="node #{node.type}">
            <a href="#{node.url}" class="#{node.type}">#{node.name}</a>
          </div>
          """
  nodeTree: (data) ->
    out = ""
    out += nodeTag(node) for node in data
    out

  fetch: (owner, repo, path, callback) ->
    results = $.getJSON "https://api.github.com/repos/#{owner}/#{repo}/contents/#{path}", (data) ->
      callback(data)

$ ->
  tree.init()
