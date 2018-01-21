type States is (State1 | State2)

class StateMachine
  let env: Env
  var state1: (State1 | None) = None
  var state2: (State2 | None) = None
  var cur_state: (States | None) = None

  new create(env': Env) =>
    env = env'
    state1 = State1(this)
    state2 = State2(this)
    transitionTo(state1)

  fun ref transitionTo(state: (States | None)) =>
    cur_state = state

  fun ref doIt() =>
    if true then
      try
        (cur_state as States).doIt()
      end
    else
      match cur_state
      | let c: States => c.doIt()
      end
    end


class State1
  let _sm: StateMachine

  new create(sm: StateMachine) =>
    _sm = sm

  fun ref doIt() =>
    _sm.env.out.print("State1.doIt()")
    _sm.transitionTo(_sm.state2)


class State2
  let _sm: StateMachine

  new create(sm: StateMachine) =>
    _sm = sm

  fun ref doIt() =>
    _sm.env.out.print("State2.doIt()")
    _sm.transitionTo(_sm.state1)


actor Main
  var sm: StateMachine

  new create(env: Env) =>
    sm = StateMachine(env)
    doIt()

  be doIt() =>
    sm.doIt()
    sm.doIt()
    sm.doIt()
    sm.doIt()
