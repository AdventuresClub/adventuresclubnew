// models/provider_transaction_model.dart
class ProviderTransactionResponse {
  final bool status;
  final ProviderTransactionData data;

  ProviderTransactionResponse({
    required this.status,
    required this.data,
  });

  factory ProviderTransactionResponse.fromJson(Map<String, dynamic> json) {
    return ProviderTransactionResponse(
      status: json['status'] ?? false,
      data: ProviderTransactionData.fromJson(json['data'] ?? {}),
    );
  }
}

class ProviderTransactionData {
  final double selledAmount;
  final double pendingSettlements;
  final double totalEarnings;
  final List<ProviderTransaction> transactions;

  ProviderTransactionData({
    required this.selledAmount,
    required this.pendingSettlements,
    required this.totalEarnings,
    required this.transactions,
  });

  factory ProviderTransactionData.fromJson(Map<String, dynamic> json) {
    return ProviderTransactionData(
      selledAmount: (json['selled_amount'] ?? 0).toDouble(),
      pendingSettlements: (json['pending_settlements'] ?? 0).toDouble(),
      totalEarnings: (json['total_earnings'] ?? 0).toDouble(),
      transactions: (json['transactions'] as List? ?? [])
          .map((item) => ProviderTransaction.fromJson(item))
          .toList(),
    );
  }
}

class ProviderTransaction {
  final int id;
  final int userId;
  final int serviceId;
  final String transactionId;
  final String payStatus;
  final int providerId;
  final String message;
  final double unitAmount;
  final double totalAmount;
  final double discountedAmount;
  final String bookingDate;
  final String settlementStatus;
  final String settlementComment;
  final double clientRefund;
  final double providerAmount;
  final double oacAmount;
  final String paymentChannel;
  final String adventureName;
  final String name;

  ProviderTransaction({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.transactionId,
    required this.payStatus,
    required this.providerId,
    required this.message,
    required this.unitAmount,
    required this.totalAmount,
    required this.discountedAmount,
    required this.bookingDate,
    required this.settlementStatus,
    required this.settlementComment,
    required this.clientRefund,
    required this.providerAmount,
    required this.oacAmount,
    required this.paymentChannel,
    required this.adventureName,
    required this.name,
  });

  factory ProviderTransaction.fromJson(Map<String, dynamic> json) {
    return ProviderTransaction(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      serviceId: json['service_id'] ?? 0,
      transactionId: json['transaction_id']?.toString() ?? '',
      payStatus: json['pay_status']?.toString() ?? '',
      providerId: json['provider_id'] ?? 0,
      message: json['message']?.toString() ?? '',
      unitAmount: double.tryParse(json['unit_amount']?.toString() ?? '0') ?? 0,
      totalAmount:
          double.tryParse(json['total_amount']?.toString() ?? '0') ?? 0,
      discountedAmount:
          double.tryParse(json['discounted_amount']?.toString() ?? '0') ?? 0,
      bookingDate: json['booking_date']?.toString() ?? '',
      settlementStatus: json['settlement_status']?.toString() ?? '',
      settlementComment: json['settlment_comment']?.toString() ?? '',
      clientRefund: (json['client_refund'] ?? 0).toDouble(),
      providerAmount: (json['provider_amount'] ?? 0).toDouble(),
      oacAmount: (json['oac_amount'] ?? 0).toDouble(),
      paymentChannel: json['payment_channel']?.toString() ?? '',
      adventureName: json['adventure_name']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}
