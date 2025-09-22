import 'package:json_annotation/json_annotation.dart';

part 'subscription_history_dto.g.dart';

@JsonSerializable()
class SubscriptionHistoryDto {
  @JsonKey(name: "total")
  final int? total;
  @JsonKey(name: "customerId")
  final String? customerId;
  @JsonKey(name: "invoices")
  final List<SubscriptionInvoiceDto>? invoices;

  SubscriptionHistoryDto({
    required this.total,
    required this.customerId,
    required this.invoices,
  });

  factory SubscriptionHistoryDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionHistoryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionHistoryDtoToJson(this);
  }
}

@JsonSerializable()
class SubscriptionInvoiceDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "amountPaid")
  final int? amountPaid;
  @JsonKey(name: "amountDue")
  final int? amountDue;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "created")
  final int? created;
  @JsonKey(name: "paidAt")
  final int? paidAt;
  @JsonKey(name: "invoiceUrl")
  final String? invoiceUrl;
  @JsonKey(name: "pdfUrl")
  final String? pdfUrl;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "subscriptionId")
  final String? subscriptionId;

  SubscriptionInvoiceDto({
    required this.id,
    required this.amount,
    required this.amountPaid,
    required this.amountDue,
    required this.currency,
    required this.status,
    required this.created,
    required this.paidAt,
    required this.invoiceUrl,
    required this.pdfUrl,
    required this.description,
    required this.subscriptionId,
  });

  factory SubscriptionInvoiceDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionInvoiceDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionInvoiceDtoToJson(this);
  }
}
