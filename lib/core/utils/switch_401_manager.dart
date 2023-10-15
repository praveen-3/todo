class Switch401Manager {
  bool _switchOn = false;

  toggleSwitch(bool value) {
    _switchOn = value;
  }

  bool getSwitchValue() {
    return _switchOn;
  }
}
