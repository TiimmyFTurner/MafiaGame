import 'package:Mafia/models/player.dart';
import 'package:flutter/Material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/role.dart';
import '../data/roles.dart';

class RolesNPlayers extends ChangeNotifier {
  List<String> _players = [];
  List<Role> _selectedRoles;
  List<Role> _mafia;
  List<Role> _citizen;
  List<Role> _independent;
  int _selectedMafia;
  int _selectedCitizen;
  List<Player> _playersWithRole;
  List<Player> _playersWithRoleFoShow;
  int _day, _night;
  int _alives;
  SharedPreferences _prefs;
  bool _limitLock;
  get alive => _alives;
  get voteToJudge => _alives ~/ 2;
  get voteToDead => (_alives ~/ 2) + 1;
  get day => _day;
  get night => _night;
  get playersWithRolesFoShow => _playersWithRoleFoShow;
  get playersWithRoles => _playersWithRole;
  get players => _players;
  get limitLock => _limitLock;
  get mafia => _mafia;
  get citizen => _citizen;
  get independent => _independent;
  get selectedRoles => _selectedRoles;

  newGame() {
    Roles roles = Roles();
    _selectedRoles = [];
    _playersWithRole = [];
    _playersWithRoleFoShow = [];
    _selectedCitizen = 0;
    _selectedMafia = 0;
    _mafia = roles.mafia;
    _citizen = roles.citizen;
    _independent = roles.independent;
  }

  initRNPSetting() async {
    _prefs = await SharedPreferences.getInstance();
    _limitLock = (_prefs.getBool('limitLock') ?? true)
        ? _limitLock = true
        : _limitLock = false;
    newGame();
  }

  set removeRole(Role role) {
    _selectedRoles.remove(role);
    if (role.type == 'M') {
      _mafia.add(role);
      _selectedMafia--;
    } else if (role.type == 'C') {
      _selectedCitizen--;
      _citizen.add(role);
    } else {
      _selectedCitizen--;
      _independent.add(role);
    }
    notifyListeners();
  }

  set silentPlayer(index) {
    _playersWithRole[index].status =
        _playersWithRole[index].status == 'silent' ? 'alive' : 'silent';
    notifyListeners();
  }

  set killPlayer(index) {
    _playersWithRole[index].status =
        _playersWithRole[index].status != 'dead' ? 'dead' : 'alive';
    notifyListeners();
  }

  set judgePlayer(index) {
    _playersWithRole[index].status =
        _playersWithRole[index].status == 'judge' ? 'alive' : 'judge';
    notifyListeners();
  }

  set limitLock(bool status) {
    _limitLock = status;
    _prefs.setBool('limitLock', _limitLock);
    notifyListeners();
  }

  set addPlayer(String name) {
    _players.add(name);
    notifyListeners();
  }

  set removePlayer(String name) {
    _players.remove(name);
    notifyListeners();
  }

  set addRole(Role role) {
    if (_players.length > _selectedRoles.length) {
      if (_limitLock) {
        if (role.type == 'M' && _selectedMafia < _players.length ~/ 3) {
          _selectedRoles.add(role);
          _selectedMafia++;
          _mafia.removeWhere((e) => e.name == role.name);
        } else if (role.type == 'C' &&
            _selectedCitizen < _players.length - (_players.length ~/ 3)) {
          _selectedRoles.add(role);
          _selectedCitizen++;
          _citizen.removeWhere((e) => e.name == role.name);
        } else if (role.type == "I" &&
            _selectedCitizen < _players.length - (_players.length ~/ 3)) {
          _selectedRoles.add(role);
          _selectedCitizen++;
          _independent.removeWhere((e) => e.name == role.name);
        }
      } else {
        _selectedRoles.add(role);
        role.type == 'M' ? _selectedMafia++ : _selectedCitizen++;
        role.type == 'M'
            ? _mafia.removeWhere((e) => e.name == role.name)
            : role.type == 'C'
                ? _citizen.removeWhere((e) => e.name == role.name)
                : _independent.removeWhere((e) => e.name == role.name);
      }
      notifyListeners();
    }
  }

  setPlayers() {
    if (_players.length != _selectedRoles.length) {
      while (_selectedMafia < _players.length ~/ 3 &&
          _selectedRoles.length < _players.length) {
        _selectedRoles.add(
          Role(
              name: 'مافیا',
              type: 'M',
              order: 19,
              job: "یک مافیای ساده که عملکرد خاصی ندارد"),
        );
        _selectedMafia++;
      }
      while (_selectedCitizen < _players.length - (_players.length ~/ 3) &&
          _selectedRoles.length < _players.length) {
        _selectedRoles.add(
          Role(
              name: 'شهروند',
              type: 'C',
              order: 49,
              job: "شهروند عادی ک در شب نقشی ندارد"),
        );
        _selectedCitizen++;
      }
    }
    if (_players.length == _selectedRoles.length) {
      _playersWithRole.clear();
      _players.shuffle();
      _selectedRoles.shuffle();
      for (var i = 0; i < _players.length; i++) {
        _playersWithRole.add(Player(
            name: _players[i], status: 'alive', role: _selectedRoles[i]));
      }
      _playersWithRoleFoShow = List.from(_playersWithRole);
      notifyListeners();
    }
  }

  recoverLastRoles() {
    Roles roles = Roles();
    var _lastRoles = _prefs.getStringList('lastRoles');
    if (_lastRoles.length != 0) {
      for (Role _selectedRole in List.from(_selectedRoles))
        removeRole = _selectedRole;
      for (String role in _lastRoles) addRole = roles.find(role);
    }
    notifyListeners();
  }

  saveRoles() async {
    await _prefs.setStringList(
        'lastRoles', _selectedRoles.map((e) => e.name).toList());
  }

  savePlayers() async => await _prefs.setStringList('lastPlayers', _players);

  bool recoverLastPlayers() {
    _players = _prefs.getStringList('lastPlayers') ?? [];
    notifyListeners();
    return _players.isNotEmpty;
  }

  playGame() {
    _day = 1;
    _night = 1;
    _sortPlayer();
    notifyListeners();
  }

  startDay() {
    _night++;
    notifyListeners();
  }

  startVoting() {
    if (_day > 1) _playersWithRole.shuffle();
    _alives = 0;
    _playersWithRole.forEach((element) {
      if (element.status != 'dead') _alives++;
    });
    _day++;
    notifyListeners();
  }

  startNight() {
    _sortPlayer();
  }

  _sortPlayer() =>
      _playersWithRole.sort((p1, p2) => p1.role.order.compareTo(p2.role.order));
}
