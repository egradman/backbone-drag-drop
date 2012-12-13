(()->
  class Backbone.DraggableModel extends Backbone.Model

  class Backbone.DroppableCollection extends Backbone.Collection
  
  class Backbone.DraggableView extends Backbone.View
    draggable:(options={})=>
      options.canDrop = @_canDrop
      options.didDrop = @_didDrop
      @$el.dragdrop options

      @$el.data('view', @)
      @$el.data('model', @model)

    _canDrop:(el)=>
      droppable_view = $(el).data('view')
      if not droppable_view
        return false

      return droppable_view.canDrop(@) and @canDrop(droppable_view)

    _didDrop:(src, dst)=>
      src_view = src.data('view')
      dst_view = dst.data('view')
      src_model = src.data('model')
      src_collection = src_view.$el.parent().data('collection')
      dst_collection = dst.data('collection')

      # update the model to belong to the collection
      # if the src is currently in a draggable view, remove it from the collection
      if src_collection?
        src_collection.remove(src_model)
      if dst_collection?
        dst_collection.add(src_model)

      @didDrop(src_view, dst_view)

    canDrop:(droppable_view)=>
      # override me
      return true

    didDrop:(draggable_view, droppable_view)=>
      # override me
      # default is to append draggable view to droppable view
      draggable_view.$el.appendTo(droppable_view.$el)

  class Backbone.DroppableView extends Backbone.View
    droppable:(options={})=>
      @$el.data('view', @)
      @$el.data('collection', @collection)

    canDrop:(draggable_view)=>
      return true

).call(this)

