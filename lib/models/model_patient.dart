class PatientModel {
  String? priority;
  String? ruleBody;
  String? cons;
  String? boolean;
  String? pref;

  PatientModel({
    required this.priority,
    required this.ruleBody,
    required this.cons,
    required this.boolean,
    required this.pref,
  });

  PatientModel.fromJson(Map<String, dynamic> json) {
    priority = json['priority'];
    ruleBody = json['rule_body'];
    cons = json['cons'];
    boolean = json['boolean'];
    pref = json['pref'];
  }

  PatientModel copyWith({
    String? priority,
    String? ruleBody,
    String? cons,
    String? boolean,
    String? pref,
  }) {
    return PatientModel(
      priority: priority ?? this.priority,
      ruleBody: ruleBody ?? this.ruleBody,
      cons: cons ?? this.cons,
      boolean: boolean ?? this.boolean,
      pref: pref ?? this.pref,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'priority': priority,
      'ruleBody': ruleBody,
      'cons': cons,
      'boolean': boolean,
      'pref': pref,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      priority: map['priority'],
      ruleBody: map['ruleBody'],
      cons: map['cons'],
      boolean: map['boolean'],
      pref: map['pref'],
    );
  }

  @override
  String toString() {
    return 'Patient(priority: $priority, ruleBody: $ruleBody, cons: $cons, boolean: $boolean, pref: $pref)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PatientModel &&
        other.priority == priority &&
        other.ruleBody == ruleBody &&
        other.cons == cons &&
        other.boolean == boolean &&
        other.pref == pref;
  }

  @override
  int get hashCode {
    return priority.hashCode ^
        ruleBody.hashCode ^
        cons.hashCode ^
        boolean.hashCode ^
        pref.hashCode;
  }
}
