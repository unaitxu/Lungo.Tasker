class __View.Task extends Monocle.View

  template  : """
    <li class="{{done}}">
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
    @event.updateAttributes class: "icon accept"
    @refresh()

  onDelete: (event) ->
    @remove()

  onView: (event) ->
    __Controller.Task.show @model

  bindTaskUpdated: (task) =>
    if task.uid is @model.uid
      @model = task
      @refresh()