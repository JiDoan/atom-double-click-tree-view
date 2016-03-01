'use strict'

class DoubleClickTreeView
  activate: ->
    atom.packages.activatePackage('tree-view').then (treeViewPkg) =>
      @treeView = treeViewPkg.mainModule.createView()
      @treeView.originalEntryClicked = @treeView.entryClicked

      @treeView.entryClicked = (e) ->
        false

      @treeView.on 'click', '.entry', (e) =>
        @treeView.openSelectedEntry.call(@treeView) if \
          e.currentTarget.getAttribute('class').indexOf("directory") > -1 and \
          e.toElement.getAttribute('class').indexOf("list-item") > -1
        false

      @treeView.on 'dblclick', '.entry', (e) =>
        @treeView.openSelectedEntry.call(@treeView)
        false

  deactivate: ->
    @treeView.entryClicked = @treeView.originalEntryClicked
    delete @treeView.originalEntryClicked
    @treeView.off 'dblclick', '.entry'

  entryDoubleClicked: (e) ->
    @originalEntryClicked(e)

module.exports = new DoubleClickTreeView()
