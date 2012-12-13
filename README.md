# Backbone-drag-drop

This is a solution to a common use-case for me: drag/drop, where each draggable is a backbone view backed by a model, and each droppable is a backbone view backed by a collection.

Dragging a draggable from one droppable to another automatically updates the underlying collection.  
Updating the underlying collection automatically updates the view.

When a draggable is dragged (to/from) a collection-backed droppable, ("add"/"remove") is triggered on the draggable view.

When a draggable is successfully dragged, both the model and the view are triggered "drag"

This uses https://github.com/mikeplate/jquery-drag-drop-plugin and backbone
