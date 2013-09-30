class __View.Task extends Monocle.View

  template  : """
    <li class="{{style()}}">
      <div class="on-right">{{list}}</div>
      <strong>{{name}}</strong>
      <small>{{description}}</small>
    </li>
  """
  
  constructor: ->
    super
    __Model.Task.bind "update", @bindTaskUpdated
    @append @model

  events:
    "swipeLeft li"  :  "onDelete"
    "hold li"       :  "onDone"
    "singleTap li"  :  "onView"

  elements:
    "input.toggle"  : "toggle"

  onDone: (event) ->
    @model.updateAttributes done: !@model.done
    @refresh()

  onDelete: (event) ->
    Lungo.Notification.confirm
      icon: "remove-sign"
      title: ""
      description: "Do you really want to remove this task?"
      accept:
        icon: "checkmark"
        label: "Yes"
        callback: =>
          @model.destroy()
          @remove() 
          @refresh()
      cancel:
        icon: "close"
        label: "No"
        callback: ->
          console.log "Error on onDelete"


  onView: (event) ->
    __Controller.Task.show @model

  bindTaskUpdated: (task) =>
    if task.uid is @model.uid
      @model = task
      @refresh()