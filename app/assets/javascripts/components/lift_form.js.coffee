@LiftForm = React.createClass
  getInitialState: ->
    date: ''
    liftname: ''
    ismetric: ''
    weightlifted: ''
    repsperformed: ''
    onerm: 0
    coefficients: { 
        1: 1, 2: .943, 3: .906, 4: .881, 5: .851, 6: 831, 7: .807, 8: 786, 9: .706, 10: .744
    }
  calculateOneRm: ->
    if @state.weightlifted and @state.repsperformed
      @state.onerm = @state.weightlifted / @state.coefficients[@state.repsperformed]
    else
      0
  handleValueChange: (e) ->
    valueName = e.target.name
    @setState "#{ valueName }":e.target.value
  toggleUnit: (e) ->
    e.preventDefault()
    @setStage.ismetric: !@state.ismetric
  valid: ->
    @state.date && @state.liftname && @state.weightlifted && @state.repsperformed && @state.onerm
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { lift: @state}, (data) =>
        @props.handleNewLift data
        @setState @getInitialState()
        'JSON'

  render: ->
    React.DOM.form 
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'date'
          className: 'form-control'
          placeholder: 'date'
          name: 'date'
          value: @state.date
          onChange: @handleValueChange
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'liftname'
          name: 'liftname'
          value: @state.liftname
          onChange: @handleValueChange
        React.DOM.a 
          className: 'btn btn-primary'
          onClick: @toggleUnit
          'Metric = ' + @state.ismetric.toString()
        React.DOM.input
          type: 'number'
          className: 'form-control'
          placeholder: 'weightlifted'
          name: 'weightlifted'
          value: @state.weightlifted
          onChange: @handleValueChange  
        React.DOM.input
          type: 'number'
          min: 1
          max: 10
          className: 'form-control'
          placeholder: 'repsperformed'
          name: 'repsperformed'
          value: @state.repsperformed
          onChange: @handleValueChange  
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: !@valid()
          'Create Lift'
        React.createElement OneRmBox, onerm: @calculateOneRm()