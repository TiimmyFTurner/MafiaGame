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
  int _selectedMafia;
  int _selectedCitizen;
  List<Player> _playersWithRole;
  List<Player> _playersWithRoleFoShow;
  int _day, _night;
  int _alives;
  SharedPreferences _prefs;

  newGame() {
    Roles roles = Roles();
    _selectedRoles = [];
    _playersWithRole = [];
    _playersWithRoleFoShow = [];
    _selectedCitizen = 0;
    _selectedMafia = 0;
    _mafia = roles.mafia;
    _citizen = roles.citizen;
  }

  initRNPSetting() async {
    _prefs = await SharedPreferences.getInstance();
    newGame();
  }

  recoverLastPlayers() {
    _players = _prefs.getStringList('lastPlayers') ?? [];
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

  get players => _players;

  savePlayers() async => await _prefs.setStringList('lastPlayers', _players);

  set addRole(Role role) {
    if (_players.length > _selectedRoles.length) {
      if (role.type == 'M' && _selectedMafia < _players.length ~/ 3) {
        _selectedRoles.add(role);
        _selectedMafia++;
        _mafia.remove(role);
      } else if (role.type == 'C' &&
          _selectedCitizen < _players.length - (_players.length ~/ 3)) {
        _selectedRoles.add(role);
        _selectedCitizen++;
        _citizen.remove(role);
      }
      notifyListeners();
    }
  }

  set removeRole(Role role) {
    _selectedRoles.remove(role);
    if (role.type == 'M') {
      _mafia.add(role);
      _selectedMafia--;
    } else {
      _selectedCitizen--;
      _citizen.add(role);
    }
    notifyListeners();
  }

  get mafia => _mafia;
  get citizen => _citizen;
  get selectedRoles => _selectedRoles;

  setPlayers() {
    if (_players.length != _selectedRoles.length) {
      while (_selectedMafia < _players.length ~/ 3) {
        _selectedRoles.add(
          Role(
              name: 'مافیا',
              type: 'M',
              order: 9,
              job: "یک مافیای ساده که عملکرد خاصی ندارد"),
        );
        _selectedMafia++;
      }
      while (_selectedCitizen < _players.length - (_players.length ~/ 3)) {
        _selectedRoles.add(
          Role(
              name: 'شهروند',
              type: 'C',
              order: 20,
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

  get playersWithRolesFoShow => _playersWithRoleFoShow;
  get playersWithRoles => _playersWithRole;

  playGame() {
    _day = 1;
    _night = 1;
    _playersWithRole.sort((p1, p2) => p1.role.order.compareTo(p2.role.order));
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

  get day => _day;

  get night => _night;

  startDay() {
    _night++;
    notifyListeners();
  }

  startVoting() {
    _alives = 0;
    _playersWithRole.forEach((element) {
      if (element.status != 'dead') _alives++;
    });
    _day++;
    notifyListeners();
  }

  get alive => _alives;
  get voteToJudge => _alives ~/ 2;
  get voteToDead => (_alives ~/ 2) + 1;

  set silentPlayer(index) {
    _playersWithRole[index].status =
        _playersWithRole[index].status == 'silent' ? 'alive' : 'silent';
    notifyListeners();
  }
}
