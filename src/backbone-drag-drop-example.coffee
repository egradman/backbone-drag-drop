$ ->
  # create two droppable collections and matching views
  drop_collections = []
  drop_views = []
  for i in [0..1]
    drop_collection = new Backbone.DroppableCollection
    drop_collections.push(drop_collection)
    drop_collection.id = i

    drop_view = new Backbone.DroppableView
      collection: drop_collection
      el: $("#drop"+i)
    drop_view.droppable()
    drop_views.push(drop_view)

  # create a few draggable views
  drag_models = []
  drag_views = []
  for i in [0..7]
    drag_model = new Backbone.DraggableModel
      id: "drag"+i
    drag_models.push(drag_model)
    drop_collections[(i%2)].add(drag_model)

    drag_view = new Backbone.DraggableView
      model: drag_model
      el: $("#drag"+i)
    drag_view.draggable
      makeClone: true

    drag_views.push(drag_view)
