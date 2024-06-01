import 'dart:convert';

TopUpModel topUpModelFromJson(String str) => TopUpModel.fromJson(json.decode(str));

String topUpModelToJson(TopUpModel data) => json.encode(data.toJson());

class TopUpModel {
  Agent agent;
  List<History> history;

  TopUpModel({
    required this.agent,
    required this.history,
  });

  factory TopUpModel.fromJson(Map<String, dynamic> json) => TopUpModel(
        agent: Agent.fromJson(json["agent"]),
        history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "agent": agent.toJson(),
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
      };
}

class Agent {
  String? saldo;

  Agent({
    required this.saldo,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        saldo: json["saldo"],
      );

  Map<String, dynamic> toJson() => {
        "saldo": saldo,
      };
}

class History {
  String? saldoMaster;
  String? saldoAddMinus;
  String? totalSaldo;
  String? typeTransaction;
  String? status;
  DateTime createdAt;

  History({
    required this.saldoMaster,
    required this.saldoAddMinus,
    required this.totalSaldo,
    required this.typeTransaction,
    required this.status,
    required this.createdAt,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        saldoMaster: json["saldo_master"],
        saldoAddMinus: json["saldo_add_minus"],
        totalSaldo: json["total_saldo"],
        typeTransaction: json["type_transaction"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "saldo_master": saldoMaster,
        "saldo_add_minus": saldoAddMinus,
        "total_saldo": totalSaldo,
        "type_transaction": typeTransaction,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}
