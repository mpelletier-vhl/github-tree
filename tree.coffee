data = [
  { type: "dir", name: "lib" },
  { type: "dir", name: "test" },
  { type: "file", name: "README" },
]

moreData = [
  { type: "dir", name: "ght" },
  { type: "file", name: "ght.rb" },
  { type: "file", name: "random_file_with_big_name.rb" },
]

$ ->
  $("#root").append nodeTag(node) for node in data

  $(".tree .node a.dir").on "click", ->
    it = $(@)

    if it.attr("state") == "open"
      it.attr("state", "closed")
      it.parent().children("div").remove()
    else
      it.attr("state", "open")
      it.after("<div class='tree'>#{nodeTree(moreData)}</ul>")

  $(".tree .node a.file").on "click", ->
    # do nothing yet

nodeTag = (node) ->
  out = """
        <div class="node #{node.type}">
          <a href="#" class="#{node.type}">#{node.name}</a>
        </div>
        """
nodeTree = (data) ->
  out = ""
  out += nodeTag(node) for node in data
  out
