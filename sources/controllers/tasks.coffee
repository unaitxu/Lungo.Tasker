class __Controller.TasksCtrl extends Monocle.Controller

    events:
      "click [data-action=new]"    :  "onNew"

    elements:
      "#pending"    :   "pending"
      "#important"  :   "important"

    constructor: ->
      super
      __Model.Task.bind "create", @bindTaskCreated
      __Model.Task.bind "update", @bindTaskUpdated
      __Model.Task.bind "destroy", @updateCounters

    onNew: (event) ->
      __Controller.Task.new()

    bindTaskCreated: (task) =>
      context = if task.important is true then "high" else "normal"
      new __View.Task model: task, container: "article##{context} ul"
      Lungo.Router.back()
      setTimeout (->
        Lungo.Notification.hide()
      ), 1500
      @updateCounters()

    bindTaskUpdated: (task) =>
      Lungo.Router.back()
      setTimeout (->
        Lungo.Notification.hide()
      ), 1500
      @updateCounters()

    updateCounters: ->
      Lungo.Element.count("#important", __Model.Task.important().length);
      Lungo.Element.count("#importantnav", __Model.Task.important().length);
      Lungo.Element.count("#normal", __Model.Task.normal().length);
      Lungo.Element.count("#pending", __Model.Task.normal().length);

$$ ->
  Lungo.init({})
  Tasks = new __Controller.TasksCtrl "section#tasks"
