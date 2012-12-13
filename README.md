# Backbone-drag-drop

This is a solution to a common use-case for me: drag/drop, where each draggable is a backbone view backed by a model, and each droppable is a backbone view backed by a collection.

Dragging a draggable from one droppable to another automatically updates the underlying collection.  
This uses https://github.com/mikeplate/jquery-drag-drop-plugin and backbone

## TODO:

- updating the underlying collections should automatically update the views
- use the collection comparator to keep the views sorted
