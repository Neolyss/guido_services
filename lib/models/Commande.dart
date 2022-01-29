class Command {

  final String idCommand;
  final String dateCommand;
  final CommandState state;
  final String idClient;

  Command({
    required this.idCommand,
    required this.dateCommand,
    required this.state,
    required this.idClient,
  });

  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
        idCommand: json["id_commande"],
        dateCommand: json["date_commande"],
        state: CommandStateExt.getState(json["etat_commande"].toString()),
        idClient: json["id_client"],
    );
  }

  static List<Command> getCommandsFromJson(Map<String, dynamic> json) {
    List<Command> commands = [];
    json["data"].map((i) => Command.fromJson(i)).forEach((e) => commands.add(e));
    return commands;
  }

}

enum CommandState {
  toBuy,
  bought,
  packed,
  shipped,
  arrived,
  delivered,
  done,
  error
}

extension CommandStateExt on CommandState {
  String get name {
    switch (this) {
      case CommandState.toBuy:
        return 'To buy';
      case CommandState.bought:
        return 'Bought';
      case CommandState.packed:
        return 'Packed';
      case CommandState.shipped:
        return 'Shipped';
      case CommandState.arrived:
        return 'Arrived';
      case CommandState.delivered:
        return 'Delivered';
      case CommandState.done:
        return 'Done';
      default:
        return 'Error';
    }
  }

  static CommandState getState(String name) {
    switch (name) {
      case 'To buy':
        return CommandState.toBuy;
      case 'Bought':
        return CommandState.bought;
      case 'Packed':
        return CommandState.packed;
      case 'Shipped':
        return CommandState.shipped;
      case 'Arrived':
        return CommandState.arrived;
      case 'Delivered' :
        return CommandState.delivered;
      case 'Done':
        return CommandState.done;
      default:
        return CommandState.error;
    }
  }
}