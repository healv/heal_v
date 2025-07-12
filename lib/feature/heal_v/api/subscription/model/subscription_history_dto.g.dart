// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionHistoryDto _$SubscriptionHistoryDtoFromJson(
        Map<String, dynamic> json) =>
    SubscriptionHistoryDto(
      total: (json['total'] as num?)?.toInt(),
      customerId: json['customerId'] as String?,
      invoices: (json['invoices'] as List<dynamic>?)
          ?.map(
              (e) => SubscriptionInvoiceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionHistoryDtoToJson(
        SubscriptionHistoryDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'customerId': instance.customerId,
      'invoices': instance.invoices,
    };

SubscriptionInvoiceDto _$SubscriptionInvoiceDtoFromJson(
        Map<String, dynamic> json) =>
    SubscriptionInvoiceDto(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      amountPaid: (json['amountPaid'] as num?)?.toInt(),
      amountDue: (json['amountDue'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      status: json['status'] as String?,
      created: (json['created'] as num?)?.toInt(),
      paidAt: (json['paidAt'] as num?)?.toInt(),
      invoiceUrl: json['invoiceUrl'] as String?,
      pdfUrl: json['pdfUrl'] as String?,
      description: json['description'] as String?,
      subscriptionId: json['subscriptionId'] as String?,
    );

Map<String, dynamic> _$SubscriptionInvoiceDtoToJson(
        SubscriptionInvoiceDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'amountPaid': instance.amountPaid,
      'amountDue': instance.amountDue,
      'currency': instance.currency,
      'status': instance.status,
      'created': instance.created,
      'paidAt': instance.paidAt,
      'invoiceUrl': instance.invoiceUrl,
      'pdfUrl': instance.pdfUrl,
      'description': instance.description,
      'subscriptionId': instance.subscriptionId,
    };
