(()->
  class Backbone.DraggableModel extends Backbone.Model

  class Backbone.DroppableCollection extends Backbone.Collection
    initialize:->
      @on "add", @_add
      @on "remove", @_remove

    _add:(model)=>
      console.log "add", model
      if @view? and model.view
        console.log @view
        @view.$el.append(model.view.$el)

    _remove:(model)=>
      console.log "remove", model
      if model.view?
        model.view.$el.detach()
  
  class Backbone.DraggableView extends Backbone.View
    initialize:->
      console.log "HERE!"
      @model.view = @ # so updates to the underlying collection can affect the model

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
        dst_view.trigger("remove")
      if dst_collection?
        dst_collection.add(src_model)
        dst_view.trigger("add")

      @didDrop(src_view, dst_view)

    canDrop:(droppable_view)=>
      # override me
      return true

    didDrop:(draggable_view, droppable_view)=>
      # override me

  class Backbone.DroppableView extends Backbone.View
    droppable:(options={})=>
      @$el.data('view', @)
      @$el.data('collection', @collection)

      @collection.view = @ # so collection changes can update the views

    canDrop:(draggable_view)=>
      return true

).call(this)

