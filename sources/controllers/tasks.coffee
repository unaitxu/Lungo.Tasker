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

    onNew: (event) ->
      __Controller.Task.new()

    bindTaskCreated: (task) =>
      context = if task.important is true then "high" else "normal"
      new __View.Task model: task, container: "article##{context} ul"
      Lungo.Router.back()
      setTimeout (->
        Lungo.Notification.hide()
      ), 2000

    bindTaskUpdated: (task) =>
      Lungo.Router.back()
      setTimeout (->
        Lungo.Notification.hide()
      ), 2000

$$ ->
  Lungo.init({})
  Tasks = new __Controller.TasksCtrl "section#tasks"
