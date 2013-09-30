class TaskCtrl extends Monocle.Controller

  elements:
    "input[name=name]"          : "name"
    "textarea[name=description]": "description"
    "input[name=list]"          : "list"
    "select[name=when]"         : "when"
    "input[name=important]"     : "important"

  events:
    "click [data-action=save]"  : "onSave"

  constructor: ->
    super
    @new = @_new
    @show = @_show

  # Events
  onSave: (event) ->
    if @current
      @current.name = @name.val()
      @current.description = @description.val()
      @current.list = @list.val()
      @current.when = @when.val()
      @current.important = @important.val()
      @current.save()
      Lungo.Notification.html("Task "+@name.val()+" changed!")

    else
      __Model.Task.create
        name        : @name.val()
        description : @description.val()
        list        : ""
        when        : ""
        important   : @important[0].checked
        done        : "accept"
      Lungo.Notification.html("Task "+@name.val()+" created!")

  _new: (@current=null) ->
    @name.val ""
    @description.val ""
    @list.val ""
    @when.val ""
    Lungo.Router.section "task"

  _show: (@current) ->
    @name.val @current.name
    @description.val @current.description
    @list.val @current.list
    @when.val @current.when
    @important.val @current.important
    Lungo.Router.section "task"

$$ ->
  __Controller.Task = new TaskCtrl "section#task"
