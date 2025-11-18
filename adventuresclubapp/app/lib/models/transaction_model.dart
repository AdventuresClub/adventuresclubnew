// transaction_model.dart
class TransactionResponse {
  final bool status;
  final TransactionData data;

  TransactionResponse({
    required this.status,
    required this.data,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      status: json['status'] ?? false,
      data: TransactionData.fromJson(json['data'] ?? {}),
    );
  }
}

class TransactionData {
  final double selledAmount;
  final double pendingSettlements;
  final double totalEarnings;
  final List<Transaction> transactions;

  TransactionData({
    required this.selledAmount,
    required this.pendingSettlements,
    required this.totalEarnings,
    required this.transactions,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      selledAmount: (json['selled_amount'] ?? 0.0).toDouble(),
      pendingSettlements: (json['pending_settlements'] ?? 0.0).toDouble(),
      totalEarnings: (json['total_earnings'] ?? 0.0).toDouble(),
      transactions: (json['transactions'] as List? ?? [])
          .map((item) => Transaction.fromJson(item))
          .toList(),
    );
  }
}

class Transaction {
  final int id;
  final int userId;
  final int serviceId;
  final String transactionId;
  final String payStatus;
  final int providerId;
  final int adult;
  final int kids;
  final String message;
  final String unitAmount;
  final String totalAmount;
  final String discountedAmount;
  final int futurePlan;
  final String bookingDate;
  final int currency;
  final int couponApplied;
  final String status;
  final String settlementStatus;
  final String settlementComment;
  final int clientRefund;
  final double providerAmount;
  final double oacAmount;
  final int updatedBy;
  final String? cancelledReason;
  final String? paymentStatus;
  final String paymentChannel;
  final String? deletedAt;
  final String createdAt;
  final String? updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.transactionId,
    required this.payStatus,
    required this.providerId,
    required this.adult,
    required this.kids,
    required this.message,
    required this.unitAmount,
    required this.totalAmount,
    required this.discountedAmount,
    required this.futurePlan,
    required this.bookingDate,
    required this.currency,
    required this.couponApplied,
    required this.status,
    required this.settlementStatus,
    required this.settlementComment,
    required this.clientRefund,
    required this.providerAmount,
    required this.oacAmount,
    required this.updatedBy,
    this.cancelledReason,
    this.paymentStatus,
    required this.paymentChannel,
    this.deletedAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      serviceId: json['service_id'] ?? 0,
      transactionId: json['transaction_id'] ?? '',
      payStatus: json['pay_status'] ?? '',
      providerId: json['provider_id'] ?? 0,
      adult: json['adult'] ?? 0,
      kids: json['kids'] ?? 0,
      message: json['message'] ?? '',
      unitAmount: json['unit_amount'] ?? '0.00',
      totalAmount: json['total_amount'] ?? '0.00',
      discountedAmount: json['discounted_amount'] ?? '0.00',
      futurePlan: json['future_plan'] ?? 0,
      bookingDate: json['booking_date'] ?? '',
      currency: json['currency'] ?? 0,
      couponApplied: json['coupon_applied'] ?? 0,
      status: json['status'] ?? '',
      settlementStatus: json['settlement_status'] ?? '',
      settlementComment: json['settlment_comment'] ?? '',
      clientRefund: json['client_refund'] ?? 0,
      providerAmount: (json['provider_amount'] ?? 0.0).toDouble(),
      oacAmount: (json['oac_amount'] ?? 0.0).toDouble(),
      updatedBy: json['updated_by'] ?? 0,
      cancelledReason: json['cancelled_reason'],
      paymentStatus: json['payment_status'],
      paymentChannel: json['payment_channel'] ?? '',
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'],
    );
  }
}
