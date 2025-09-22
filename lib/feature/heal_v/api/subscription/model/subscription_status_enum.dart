enum SubscriptionStatusEnum {
  incomplete(status: "incomplete"),
  canceled(status: "canceled"),
  pastDue(status: "past_due"),
  active(status: "active");

  final String status;

  const SubscriptionStatusEnum({
    required this.status,
  });

  static Map<String, SubscriptionStatusEnum> _map = {for (var item in SubscriptionStatusEnum.values) item.status: item};

  static SubscriptionStatusEnum? from(String? status) => _map[status];
}
