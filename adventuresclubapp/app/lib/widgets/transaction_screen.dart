// // // transaction_widget.dart
// // import 'dart:convert';
// // import 'package:app/constants.dart';
// // import 'package:app/models/transaction_model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // class TransactionScreen extends StatefulWidget {
// //   const TransactionScreen({super.key});

// //   @override
// //   TransactionScreenState createState() => TransactionScreenState();
// // }

// // class TransactionScreenState extends State<TransactionScreen> {
// //   TransactionResponse? _transactionData;
// //   bool _isLoading = true;
// //   String _errorMessage = '';
// //   List<Transaction> _filteredTransactions = [];
// //   String _searchQuery = '';
// //   String _statusFilter = 'All';
// //   List<String> _statusOptions = ['All', 'Settled', 'In Progress', 'In Review'];
// //   int _rowsPerPage = 10;
// //   int _currentPage = 0;
// //   List<Transaction> _sortedTransactions = [];
// //   String _sortColumn = 'transactionId';
// //   bool _sortAscending = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadTransactionData();
// //   }

// //   Future<TransactionResponse?> getServiceData() async {
// //     try {
// //       var response = await http.post(
// //         Uri.parse("${Constants.baseUrl}/api/v1/getTransactionByServiceId"),
// //         body: {'service_id': "185"},
// //       );

// //       if (response.statusCode == 200) {
// //         var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

// //         Map<String, dynamic> convertedResponse = {};
// //         decodedResponse.forEach((key, value) {
// //           convertedResponse[key.toString()] = value;
// //         });

// //         return TransactionResponse.fromJson(convertedResponse);
// //       } else {
// //         throw Exception('Failed to load data: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       debugPrint("${"tractions data"}${e.toString()}");
// //       print(e.toString());
// //       return null;
// //     }
// //   }

// //   Future<void> _loadTransactionData() async {
// //     setState(() {
// //       _isLoading = true;
// //       _errorMessage = '';
// //     });

// //     try {
// //       final data = await getServiceData();
// //       setState(() {
// //         _transactionData = data;
// //         _filteredTransactions = data?.data.transactions ?? [];
// //         _sortedTransactions = List.from(_filteredTransactions);
// //         _isLoading = false;
// //       });
// //     } catch (e) {
// //       debugPrint("${"tractions"}${e.toString()}");
// //       setState(() {
// //         _errorMessage = 'Failed to load transaction data';
// //         _isLoading = false;
// //       });
// //     }
// //   }

// //   void _applyFilters() {
// //     List<Transaction> filtered = _transactionData?.data.transactions ?? [];

// //     // Apply search filter
// //     if (_searchQuery.isNotEmpty) {
// //       filtered = filtered
// //           .where((transaction) =>
// //               transaction.transactionId
// //                   .toLowerCase()
// //                   .contains(_searchQuery.toLowerCase()) ||
// //               transaction.paymentChannel
// //                   .toLowerCase()
// //                   .contains(_searchQuery.toLowerCase()) ||
// //               transaction.bookingDate
// //                   .toLowerCase()
// //                   .contains(_searchQuery.toLowerCase()) ||
// //               transaction.message
// //                   .toLowerCase()
// //                   .contains(_searchQuery.toLowerCase()))
// //           .toList();
// //     }

// //     // Apply status filter
// //     if (_statusFilter != 'All') {
// //       filtered = filtered
// //           .where((transaction) =>
// //               transaction.settlementStatus.toLowerCase() ==
// //               _statusFilter.toLowerCase())
// //           .toList();
// //     }

// //     setState(() {
// //       _filteredTransactions = filtered;
// //       _sortedTransactions = List.from(_filteredTransactions);
// //       _currentPage = 0;
// //       _sortData(_sortColumn, _sortAscending);
// //     });
// //   }

// //   void _sortData(String column, bool ascending) {
// //     setState(() {
// //       _sortColumn = column;
// //       _sortAscending = ascending;

// //       _sortedTransactions.sort((a, b) {
// //         int comparison = 0;
// //         switch (column) {
// //           case 'transactionId':
// //             comparison = a.transactionId.compareTo(b.transactionId);
// //             break;
// //           case 'totalAmount':
// //             comparison = a.totalAmount.compareTo(b.totalAmount);
// //             break;
// //           case 'bookingDate':
// //             comparison = a.bookingDate.compareTo(b.bookingDate);
// //             break;
// //           case 'payStatus':
// //             comparison = a.payStatus.compareTo(b.payStatus);
// //             break;
// //           case 'settlementStatus':
// //             comparison = a.settlementStatus.compareTo(b.settlementStatus);
// //             break;
// //           default:
// //             comparison = 0;
// //         }
// //         return ascending ? comparison : -comparison;
// //       });
// //     });
// //   }

// //   List<Transaction> get _currentPageData {
// //     final startIndex = _currentPage * _rowsPerPage;
// //     final endIndex = startIndex + _rowsPerPage;
// //     return _sortedTransactions.sublist(
// //       startIndex,
// //       endIndex > _sortedTransactions.length
// //           ? _sortedTransactions.length
// //           : endIndex,
// //     );
// //   }

// //   // Calculate summary values
// //   double get _totalEarnings => _transactionData?.data.totalEarnings ?? 0;
// //   double get _pendingSettlements =>
// //       _transactionData?.data.pendingSettlements ?? 0;
// //   double get _settledAmount => _totalEarnings - _pendingSettlements;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       appBar: AppBar(
// //         title: Text(
// //           'Transaction Details',
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //           ),
// //         ),
// //         backgroundColor: Colors.blue[800],
// //         elevation: 0,
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.refresh),
// //             onPressed: _loadTransactionData,
// //           ),
// //         ],
// //       ),
// //       body: _isLoading
// //           ? _buildLoadingWidget()
// //           : _errorMessage.isNotEmpty
// //               ? _buildErrorWidget()
// //               : _transactionData == null
// //                   ? _buildNoDataWidget()
// //                   : _buildDataTableWidget(),
// //     );
// //   }

// //   Widget _buildLoadingWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           CircularProgressIndicator(
// //             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!),
// //           ),
// //           SizedBox(height: 16),
// //           Text(
// //             'Loading transaction data...',
// //             style: TextStyle(
// //               fontSize: 16,
// //               color: Colors.grey[600],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildErrorWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(
// //             Icons.error_outline,
// //             size: 64,
// //             color: Colors.red[400],
// //           ),
// //           SizedBox(height: 16),
// //           Text(
// //             _errorMessage,
// //             style: TextStyle(
// //               fontSize: 16,
// //               color: Colors.grey[600],
// //             ),
// //           ),
// //           SizedBox(height: 16),
// //           ElevatedButton(
// //             onPressed: _loadTransactionData,
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.blue[800],
// //               foregroundColor: Colors.white,
// //             ),
// //             child: Text('Try Again'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildNoDataWidget() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(
// //             Icons.receipt_long,
// //             size: 64,
// //             color: Colors.grey[400],
// //           ),
// //           SizedBox(height: 16),
// //           Text(
// //             'No transaction data available',
// //             style: TextStyle(
// //               fontSize: 16,
// //               color: Colors.grey[600],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildDataTableWidget() {
// //     return Column(
// //       children: [
// //         // Summary Cards - Compact mobile layout
// //         _buildSummaryCards(),
// //         SizedBox(height: 12),

// //         // Filters and Search
// //         _buildFilterBar(),
// //         SizedBox(height: 12),

// //         // DataTable with horizontal scroll
// //         Expanded(
// //           child: _buildScrollableDataTable(),
// //         ),

// //         // Pagination
// //         _buildPaginationControls(),
// //       ],
// //     );
// //   }

// //   Widget _buildSummaryCards() {
// //     return Container(
// //       padding: EdgeInsets.all(12),
// //       color: Colors.white,
// //       child: Column(
// //         children: [
// //           // Main total earnings
// //           _buildSummaryRow(
// //             'TOTAL EARNINGS',
// //             'OMR $_totalEarnings',
// //             Icons.attach_money,
// //             Colors.green,
// //             isMain: true,
// //           ),
// //           SizedBox(height: 8),

// //           // Sub totals in a row
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: _buildSummaryRow(
// //                   'SETTLED',
// //                   'OMR $_settledAmount',
// //                   Icons.check_circle,
// //                   Colors.blue,
// //                 ),
// //               ),
// //               SizedBox(width: 8),
// //               Expanded(
// //                 child: _buildSummaryRow(
// //                   'PENDING',
// //                   'OMR $_pendingSettlements',
// //                   Icons.pending_actions,
// //                   Colors.orange,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSummaryRow(
// //       String title, String value, IconData icon, Color color,
// //       {bool isMain = false}) {
// //     return Container(
// //       padding: EdgeInsets.all(12),
// //       decoration: BoxDecoration(
// //         color: isMain ? color.withOpacity(0.1) : Colors.grey[50],
// //         borderRadius: BorderRadius.circular(8),
// //         border: Border.all(color: color.withOpacity(0.3)),
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Row(
// //             children: [
// //               Icon(icon, color: color, size: isMain ? 20 : 16),
// //               SizedBox(width: 8),
// //               Text(
// //                 title,
// //                 style: TextStyle(
// //                   fontSize: isMain ? 14 : 12,
// //                   fontWeight: isMain ? FontWeight.bold : FontWeight.normal,
// //                   color: Colors.grey[700],
// //                 ),
// //               ),
// //             ],
// //           ),
// //           Text(
// //             value,
// //             style: TextStyle(
// //               fontSize: isMain ? 16 : 14,
// //               fontWeight: FontWeight.bold,
// //               color: color,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildFilterBar() {
// //     return Container(
// //       padding: EdgeInsets.all(12),
// //       color: Colors.white,
// //       child: Column(
// //         children: [
// //           // Search Field
// //           TextField(
// //             decoration: InputDecoration(
// //               hintText: 'Search transactions...',
// //               prefixIcon: Icon(Icons.search),
// //               border: OutlineInputBorder(),
// //               contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //               isDense: true,
// //             ),
// //             onChanged: (value) {
// //               setState(() {
// //                 _searchQuery = value;
// //               });
// //               _applyFilters();
// //             },
// //           ),
// //           SizedBox(height: 8),
// //           Row(
// //             children: [
// //               // Status Filter
// //               Expanded(
// //                 child: DropdownButtonFormField<String>(
// //                   value: _statusFilter,
// //                   decoration: InputDecoration(
// //                     labelText: 'Settlement Status',
// //                     border: OutlineInputBorder(),
// //                     contentPadding:
// //                         EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //                     isDense: true,
// //                   ),
// //                   items: _statusOptions.map((String status) {
// //                     return DropdownMenuItem<String>(
// //                       value: status,
// //                       child: Text(
// //                         status,
// //                         style: TextStyle(fontSize: 14),
// //                       ),
// //                     );
// //                   }).toList(),
// //                   onChanged: (value) {
// //                     setState(() {
// //                       _statusFilter = value!;
// //                     });
// //                     _applyFilters();
// //                   },
// //                 ),
// //               ),
// //               SizedBox(width: 8),
// //               // Rows per page
// //               Container(
// //                 width: 120,
// //                 child: DropdownButtonFormField<int>(
// //                   value: _rowsPerPage,
// //                   decoration: InputDecoration(
// //                     labelText: 'Rows',
// //                     border: OutlineInputBorder(),
// //                     contentPadding:
// //                         EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //                     isDense: true,
// //                   ),
// //                   items: [5, 10, 15, 20].map((int value) {
// //                     return DropdownMenuItem<int>(
// //                       value: value,
// //                       child: Text(
// //                         '$value',
// //                         style: TextStyle(fontSize: 14),
// //                       ),
// //                     );
// //                   }).toList(),
// //                   onChanged: (value) {
// //                     setState(() {
// //                       _rowsPerPage = value!;
// //                       _currentPage = 0;
// //                     });
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildScrollableDataTable() {
// //     return Container(
// //       margin: EdgeInsets.symmetric(horizontal: 8),
// //       child: SingleChildScrollView(
// //         scrollDirection: Axis.horizontal,
// //         child: Container(
// //           constraints: BoxConstraints(
// //             minWidth: MediaQuery.of(context).size.width,
// //           ),
// //           child: Card(
// //             elevation: 2,
// //             child: _buildDataTable(),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDataTable() {
// //     return DataTable(
// //       headingRowColor: MaterialStateProperty.resolveWith<Color?>(
// //         (Set<MaterialState> states) => Colors.blue[50],
// //       ),
// //       dataRowMinHeight: 40,
// //       dataRowMaxHeight: 60,
// //       headingRowHeight: 44,
// //       columnSpacing: 12,
// //       horizontalMargin: 8,
// //       sortColumnIndex: _getSortColumnIndex(),
// //       sortAscending: _sortAscending,
// //       columns: [
// //         DataColumn(
// //           label: Text(
// //             'Transaction ID',
// //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //           ),
// //           onSort: (columnIndex, ascending) {
// //             _sortData('transactionId', ascending);
// //           },
// //         ),
// //         DataColumn(
// //           label: Text(
// //             'User ID',
// //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //         DataColumn(
// //           label: Text(
// //             'Booking Date',
// //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //           ),
// //           onSort: (columnIndex, ascending) {
// //             _sortData('payStatus', ascending);
// //           },
// //         ),
// //         DataColumn(
// //           label: Text(
// //             'Total Paid',
// //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //           ),
// //           numeric: true,
// //           onSort: (columnIndex, ascending) {
// //             _sortData('totalAmount', ascending);
// //           },
// //         ),
// //         DataColumn(
// //           label: Text(
// //             'Refunded',
// //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //           ),
// //           numeric: true,
// //         ),
// //         DataColumn(
// //           label: Text(
// //             'Adventures\nClub',
// //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //           ),
// //           numeric: true,
// //         ),
// //         DataColumn(
// //           label: Text(
// //             'Partner',
// //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //           ),
// //           numeric: true,
// //         ),
// //         DataColumn(
// //           label: Text(
// //             'Settlement\nStatus',
// //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //           ),
// //           onSort: (columnIndex, ascending) {
// //             _sortData('settlementStatus', ascending);
// //           },
// //         ),
// //         DataColumn(
// //           label: Text(
// //             'Comment',
// //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //         DataColumn(
// //           label: Text(
// //             'Actions',
// //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //       ],
// //       rows: _currentPageData.map((transaction) {
// //         return DataRow(
// //           cells: [
// //             DataCell(
// //               SizedBox(
// //                 width: 80,
// //                 child: Text(
// //                   transaction.transactionId.length > 8
// //                       ? '${transaction.transactionId.substring(0, 8)}...'
// //                       : transaction.transactionId,
// //                   style: TextStyle(fontSize: 11, fontFamily: 'Monospace'),
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //               ),
// //             ),
// //             DataCell(
// //               Text(
// //                 '${transaction.userId}',
// //                 style: TextStyle(fontSize: 11),
// //               ),
// //             ),
// //             //needs changing here
// //             // DataCell(
// //             //   _buildStatusChip(transaction.bookingDate),
// //             // ),
// //             DataCell(
// //               Text(
// //                 transaction.bookingDate,
// //                 style: TextStyle(
// //                   fontSize: 11,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ),
// //             DataCell(
// //               Text(
// //                 'OMR ${transaction.totalAmount.toStringAsFixed(2)}',
// //                 style: TextStyle(
// //                   fontSize: 11,
// //                   fontWeight: FontWeight.w600,
// //                   color: Colors.green[700],
// //                 ),
// //               ),
// //             ),
// //             DataCell(
// //               Text(
// //                 'OMR ${transaction.clientRefund.toStringAsFixed(2)}',
// //                 style: TextStyle(fontSize: 11),
// //               ),
// //             ),
// //             DataCell(
// //               Text(
// //                 'OMR ${transaction.oacAmount.toStringAsFixed(2)}',
// //                 style: TextStyle(
// //                   fontSize: 11,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ),
// //             DataCell(
// //               Text(
// //                 'OMR ${transaction.providerAmount.toStringAsFixed(2)}',
// //                 style: TextStyle(
// //                   fontSize: 11,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.blue[700],
// //                 ),
// //               ),
// //             ),
// //             DataCell(
// //               _buildSettlementChip(transaction.settlementStatus),
// //             ),
// //             DataCell(
// //               SizedBox(
// //                 width: 80,
// //                 child: Text(
// //                   transaction.settlementComment.isEmpty
// //                       ? '-'
// //                       : transaction.settlementComment,
// //                   style: TextStyle(fontSize: 10),
// //                   overflow: TextOverflow.ellipsis,
// //                   maxLines: 2,
// //                 ),
// //               ),
// //             ),
// //             DataCell(
// //               IconButton(
// //                 icon: Icon(Icons.visibility, size: 16),
// //                 onPressed: () {
// //                   _showTransactionDetails(transaction);
// //                 },
// //               ),
// //             ),
// //           ],
// //         );
// //       }).toList(),
// //     );
// //   }

// //   int? _getSortColumnIndex() {
// //     switch (_sortColumn) {
// //       case 'transactionId':
// //         return 0;
// //       case 'totalAmount':
// //         return 3;
// //       case 'payStatus':
// //         return 2;
// //       case 'settlementStatus':
// //         return 7;
// //       default:
// //         return null;
// //     }
// //   }

// //   Widget _buildStatusChip(String status) {
// //     Color chipColor;
// //     switch (status.toLowerCase()) {
// //       case 'success':
// //         chipColor = Colors.green;
// //         break;
// //       case 'pending':
// //         chipColor = Colors.orange;
// //         break;
// //       case 'failed':
// //         chipColor = Colors.red;
// //         break;
// //       default:
// //         chipColor = Colors.grey;
// //     }

// //     return Chip(
// //       label: Text(
// //         status,
// //         style: TextStyle(
// //           color: Colors.white,
// //           fontSize: 9,
// //         ),
// //       ),
// //       backgroundColor: chipColor,
// //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //       visualDensity: VisualDensity.compact,
// //       padding: EdgeInsets.symmetric(horizontal: 4),
// //     );
// //   }

// //   Widget _buildSettlementChip(String status) {
// //     Color chipColor;
// //     switch (status.toLowerCase()) {
// //       case 'settled':
// //         chipColor = Colors.green;
// //         break;
// //       case 'in_progress':
// //         chipColor = Colors.orange;
// //         break;
// //       case 'in_review':
// //         chipColor = Colors.blue;
// //         break;
// //       default:
// //         chipColor = Colors.grey;
// //     }

// //     return Chip(
// //       label: Text(
// //         status.replaceAll('_', ' ').toUpperCase(),
// //         style: TextStyle(
// //           color: Colors.white,
// //           fontSize: 8,
// //           fontWeight: FontWeight.bold,
// //         ),
// //       ),
// //       backgroundColor: chipColor,
// //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //       visualDensity: VisualDensity.compact,
// //       padding: EdgeInsets.symmetric(horizontal: 4),
// //     );
// //   }

// //   Widget _buildPaginationControls() {
// //     final totalPages = (_filteredTransactions.length / _rowsPerPage).ceil();

// //     return Container(
// //       padding: EdgeInsets.all(12),
// //       color: Colors.white,
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(
// //             '${_currentPage * _rowsPerPage + 1}-${_currentPage * _rowsPerPage + _currentPageData.length} of ${_filteredTransactions.length}',
// //             style: TextStyle(fontSize: 12, color: Colors.grey[600]),
// //           ),
// //           Row(
// //             children: [
// //               IconButton(
// //                 icon: Icon(Icons.chevron_left, size: 20),
// //                 onPressed: _currentPage > 0
// //                     ? () {
// //                         setState(() {
// //                           _currentPage--;
// //                         });
// //                       }
// //                     : null,
// //               ),
// //               Text(
// //                 '${_currentPage + 1}/$totalPages',
// //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
// //               ),
// //               IconButton(
// //                 icon: Icon(Icons.chevron_right, size: 20),
// //                 onPressed: _currentPage < totalPages - 1
// //                     ? () {
// //                         setState(() {
// //                           _currentPage++;
// //                         });
// //                       }
// //                     : null,
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   void _showTransactionDetails(Transaction transaction) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => Dialog(
// //         insetPadding: EdgeInsets.all(16),
// //         child: Container(
// //           width: double.infinity,
// //           padding: EdgeInsets.all(16),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(
// //                     'Transaction Details',
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   IconButton(
// //                     icon: Icon(Icons.close),
// //                     onPressed: () => Navigator.of(context).pop(),
// //                   ),
// //                 ],
// //               ),
// //               Divider(),
// //               Expanded(
// //                 child: SingleChildScrollView(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       _buildDetailRow(
// //                           'Transaction ID', transaction.transactionId),
// //                       _buildDetailRow('User ID', '${transaction.userId}'),
// //                       _buildDetailRow('Booking Date', transaction.bookingDate),
// //                       _buildDetailRow('Status', transaction.payStatus),
// //                       _buildDetailRow(
// //                           'Settlement Status', transaction.settlementStatus),
// //                       _buildDetailRow(
// //                           'Total Paid', 'OMR ${transaction.totalAmount}'),
// //                       // _buildDetailRow(
// //                       //     'Discounted', 'OMR ${transaction.discountedAmount}'),
// //                       _buildDetailRow(
// //                           'Refunded Amount', 'OMR ${transaction.clientRefund}'),
// //                       _buildDetailRow(
// //                           'Adventures Club', 'OMR ${transaction.oacAmount}'),
// //                       _buildDetailRow('Partner Amount',
// //                           'OMR ${transaction.providerAmount}'),
// //                       _buildDetailRow(
// //                           'Payment Channel', transaction.paymentChannel),
// //                       if (transaction.message.isNotEmpty)
// //                         _buildDetailRow('Message', transaction.message),
// //                       if (transaction.settlementComment.isNotEmpty)
// //                         _buildDetailRow(
// //                             'Comment', transaction.settlementComment),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 16),
// //               Center(
// //                 child: ElevatedButton(
// //                   onPressed: () => Navigator.of(context).pop(),
// //                   child: Text('Close'),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDetailRow(String label, String value) {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(vertical: 6),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           SizedBox(
// //             width: 120,
// //             child: Text(
// //               '$label:',
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w500,
// //                 color: Colors.grey[700],
// //                 fontSize: 12,
// //               ),
// //             ),
// //           ),
// //           SizedBox(width: 8),
// //           Expanded(
// //             child: Text(
// //               value,
// //               style: TextStyle(fontSize: 12, color: Colors.grey[800]),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // transaction_widget.dart
// import 'dart:convert';
// import 'package:app/constants.dart';
// import 'package:app/models/transaction_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class TransactionScreen extends StatefulWidget {
//   const TransactionScreen({super.key});

//   @override
//   TransactionScreenState createState() => TransactionScreenState();
// }

// class TransactionScreenState extends State<TransactionScreen> {
//   TransactionResponse? _transactionData;
//   bool _isLoading = true;
//   String _errorMessage = '';
//   List<Transaction> _filteredTransactions = [];
//   String _searchQuery = '';
//   String _statusFilter = 'All';
//   List<String> _statusOptions = ['All', 'Settled', 'In Progress', 'In Review'];
//   int _rowsPerPage = 10;
//   int _currentPage = 0;
//   List<Transaction> _sortedTransactions = [];
//   String _sortColumn = 'transactionId';
//   bool _sortAscending = true;

//   // Map for API status to display status
//   final Map<String, String> _statusMapping = {
//     'settled': 'Settled',
//     'in_progress': 'In Progress',
//     'in_review': 'In Review',
//   };

//   @override
//   void initState() {
//     super.initState();
//     _loadTransactionData();
//   }

//   Future<TransactionResponse?> getServiceData() async {
//     try {
//       var response = await http.post(
//         Uri.parse("${Constants.baseUrl}/api/v1/getTransactionByServiceId"),
//         body: {'service_id': "185"},
//       );

//       if (response.statusCode == 200) {
//         var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

//         Map<String, dynamic> convertedResponse = {};
//         decodedResponse.forEach((key, value) {
//           convertedResponse[key.toString()] = value;
//         });

//         return TransactionResponse.fromJson(convertedResponse);
//       } else {
//         throw Exception('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint("${"tractions data"}${e.toString()}");
//       print(e.toString());
//       return null;
//     }
//   }

//   Future<void> _loadTransactionData() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });

//     try {
//       final data = await getServiceData();
//       setState(() {
//         _transactionData = data;
//         _filteredTransactions = data?.data.transactions ?? [];
//         _sortedTransactions = List.from(_filteredTransactions);
//         _isLoading = false;
//       });
//     } catch (e) {
//       debugPrint("${"tractions"}${e.toString()}");
//       setState(() {
//         _errorMessage = 'Failed to load transaction data';
//         _isLoading = false;
//       });
//     }
//   }

//   void _applyFilters() {
//     List<Transaction> filtered = _transactionData?.data.transactions ?? [];

//     // Apply search filter
//     if (_searchQuery.isNotEmpty) {
//       filtered = filtered
//           .where((transaction) =>
//               transaction.transactionId
//                   .toLowerCase()
//                   .contains(_searchQuery.toLowerCase()) ||
//               transaction.paymentChannel
//                   .toLowerCase()
//                   .contains(_searchQuery.toLowerCase()) ||
//               transaction.bookingDate
//                   .toLowerCase()
//                   .contains(_searchQuery.toLowerCase()) ||
//               transaction.message
//                   .toLowerCase()
//                   .contains(_searchQuery.toLowerCase()))
//           .toList();
//     }

//     // Apply status filter - fixed mapping
//     if (_statusFilter != 'All') {
//       filtered = filtered.where((transaction) {
//         // Map the API status to display status for filtering
//         final apiStatus = transaction.settlementStatus.toLowerCase();
//         final displayStatus = _statusMapping[apiStatus] ?? apiStatus;
//         return displayStatus == _statusFilter;
//       }).toList();
//     }

//     setState(() {
//       _filteredTransactions = filtered;
//       _sortedTransactions = List.from(_filteredTransactions);
//       _currentPage = 0;
//       _sortData(_sortColumn, _sortAscending);
//     });
//   }

//   void _sortData(String column, bool ascending) {
//     setState(() {
//       _sortColumn = column;
//       _sortAscending = ascending;

//       _sortedTransactions.sort((a, b) {
//         int comparison = 0;
//         switch (column) {
//           case 'transactionId':
//             comparison = a.transactionId.compareTo(b.transactionId);
//             break;
//           case 'totalAmount':
//             comparison = a.totalAmount.compareTo(b.totalAmount);
//             break;
//           case 'bookingDate':
//             comparison = a.bookingDate.compareTo(b.bookingDate);
//             break;
//           case 'payStatus':
//             comparison = a.payStatus.compareTo(b.payStatus);
//             break;
//           case 'settlementStatus':
//             comparison = a.settlementStatus.compareTo(b.settlementStatus);
//             break;
//           default:
//             comparison = 0;
//         }
//         return ascending ? comparison : -comparison;
//       });
//     });
//   }

//   List<Transaction> get _currentPageData {
//     final startIndex = _currentPage * _rowsPerPage;
//     final endIndex = startIndex + _rowsPerPage;
//     return _sortedTransactions.sublist(
//       startIndex,
//       endIndex > _sortedTransactions.length
//           ? _sortedTransactions.length
//           : endIndex,
//     );
//   }

//   // Calculate summary values
//   double get _totalEarnings => _transactionData?.data.totalEarnings ?? 0;
//   double get _pendingSettlements =>
//       _transactionData?.data.pendingSettlements ?? 0;
//   double get _settledAmount => _totalEarnings - _pendingSettlements;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Text(
//           'Transaction Details',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blue[800],
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _loadTransactionData,
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? _buildLoadingWidget()
//           : _errorMessage.isNotEmpty
//               ? _buildErrorWidget()
//               : _transactionData == null
//                   ? _buildNoDataWidget()
//                   : _buildDataTableWidget(),
//     );
//   }

//   Widget _buildLoadingWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!),
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Loading transaction data...',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             size: 64,
//             color: Colors.red[400],
//           ),
//           SizedBox(height: 16),
//           Text(
//             _errorMessage,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[600],
//             ),
//           ),
//           SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: _loadTransactionData,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue[800],
//               foregroundColor: Colors.white,
//             ),
//             child: Text('Try Again'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNoDataWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.receipt_long,
//             size: 64,
//             color: Colors.grey[400],
//           ),
//           SizedBox(height: 16),
//           Text(
//             'No transaction data available',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDataTableWidget() {
//     return Column(
//       children: [
//         // Summary Cards - Compact mobile layout
//         _buildSummaryCards(),
//         SizedBox(height: 12),

//         // Filters and Search
//         _buildFilterBar(),
//         SizedBox(height: 12),

//         // DataTable with horizontal scroll
//         Expanded(
//           child: _buildScrollableDataTable(),
//         ),

//         // Pagination
//         _buildPaginationControls(),
//       ],
//     );
//   }

//   Widget _buildSummaryCards() {
//     return Container(
//       padding: EdgeInsets.all(12),
//       color: Colors.white,
//       child: Column(
//         children: [
//           // Main total earnings
//           _buildSummaryRow(
//             'TOTAL EARNINGS',
//             'OMR $_totalEarnings',
//             Icons.attach_money,
//             Colors.green,
//             isMain: true,
//           ),
//           SizedBox(height: 8),

//           // Sub totals in a row
//           Row(
//             children: [
//               Expanded(
//                 child: _buildSummaryRow(
//                   'SETTLED',
//                   'OMR $_settledAmount',
//                   Icons.check_circle,
//                   Colors.blue,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Expanded(
//                 child: _buildSummaryRow(
//                   'PENDING',
//                   'OMR $_pendingSettlements',
//                   Icons.pending_actions,
//                   Colors.orange,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryRow(
//       String title, String value, IconData icon, Color color,
//       {bool isMain = false}) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isMain ? color.withOpacity(0.1) : Colors.grey[50],
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: color, size: isMain ? 20 : 16),
//               SizedBox(width: 8),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: isMain ? 14 : 12,
//                   fontWeight: isMain ? FontWeight.bold : FontWeight.normal,
//                   color: Colors.grey[700],
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: isMain ? 16 : 14,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterBar() {
//     return Container(
//       padding: EdgeInsets.all(12),
//       color: Colors.white,
//       child: Column(
//         children: [
//           // Search Field
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Search transactions...',
//               prefixIcon: Icon(Icons.search),
//               border: OutlineInputBorder(),
//               contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               isDense: true,
//             ),
//             onChanged: (value) {
//               setState(() {
//                 _searchQuery = value;
//               });
//               _applyFilters();
//             },
//           ),
//           SizedBox(height: 8),
//           Row(
//             children: [
//               // Status Filter
//               Expanded(
//                 child: DropdownButtonFormField<String>(
//                   value: _statusFilter,
//                   decoration: InputDecoration(
//                     labelText: 'Settlement Status',
//                     border: OutlineInputBorder(),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     isDense: true,
//                   ),
//                   items: _statusOptions.map((String status) {
//                     return DropdownMenuItem<String>(
//                       value: status,
//                       child: Text(
//                         status,
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _statusFilter = value!;
//                     });
//                     _applyFilters();
//                   },
//                 ),
//               ),
//               SizedBox(width: 8),
//               // Rows per page
//               Container(
//                 width: 120,
//                 child: DropdownButtonFormField<int>(
//                   value: _rowsPerPage,
//                   decoration: InputDecoration(
//                     labelText: 'Rows',
//                     border: OutlineInputBorder(),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     isDense: true,
//                   ),
//                   items: [5, 10, 15, 20].map((int value) {
//                     return DropdownMenuItem<int>(
//                       value: value,
//                       child: Text(
//                         '$value',
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _rowsPerPage = value!;
//                       _currentPage = 0;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildScrollableDataTable() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Container(
//           constraints: BoxConstraints(
//             minWidth: MediaQuery.of(context).size.width,
//           ),
//           child: Card(
//             elevation: 2,
//             child: _buildDataTable(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDataTable() {
//     return DataTable(
//       headingRowColor: MaterialStateProperty.resolveWith<Color?>(
//         (Set<MaterialState> states) => Colors.blue[50],
//       ),
//       dataRowMinHeight: 40,
//       dataRowMaxHeight: 60,
//       headingRowHeight: 44,
//       columnSpacing: 12,
//       horizontalMargin: 8,
//       sortColumnIndex: _getSortColumnIndex(),
//       sortAscending: _sortAscending,
//       columns: [
//         DataColumn(
//           label: Text(
//             'Transaction ID',
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//           onSort: (columnIndex, ascending) {
//             _sortData('transactionId', ascending);
//           },
//         ),
//         DataColumn(
//           label: Text(
//             'User ID',
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             'Booking Date',
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//           onSort: (columnIndex, ascending) {
//             _sortData('payStatus', ascending);
//           },
//         ),
//         DataColumn(
//           label: Text(
//             'Total Paid',
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//           numeric: true,
//           onSort: (columnIndex, ascending) {
//             _sortData('totalAmount', ascending);
//           },
//         ),
//         DataColumn(
//           label: Text(
//             'Refunded',
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//           numeric: true,
//         ),
//         DataColumn(
//           label: Text(
//             'Adventures\nClub',
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//           numeric: true,
//         ),
//         DataColumn(
//           label: Text(
//             'Partner',
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//           numeric: true,
//         ),
//         DataColumn(
//           label: Text(
//             'Settlement\nStatus',
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//           onSort: (columnIndex, ascending) {
//             _sortData('settlementStatus', ascending);
//           },
//         ),
//         DataColumn(
//           label: Text(
//             'Comment',
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             'Actions',
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//       rows: _currentPageData.map((transaction) {
//         return DataRow(
//           cells: [
//             DataCell(
//               SizedBox(
//                 width: 80,
//                 child: Text(
//                   transaction.transactionId.length > 8
//                       ? '${transaction.transactionId.substring(0, 8)}...'
//                       : transaction.transactionId,
//                   style: TextStyle(fontSize: 11, fontFamily: 'Monospace'),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//             DataCell(
//               Text(
//                 '${transaction.userId}',
//                 style: TextStyle(fontSize: 11),
//               ),
//             ),
//             DataCell(
//               Text(
//                 transaction.bookingDate,
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             DataCell(
//               Text(
//                 'OMR ${transaction.totalAmount.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.green[700],
//                 ),
//               ),
//             ),
//             DataCell(
//               Text(
//                 'OMR ${transaction.clientRefund.toStringAsFixed(2)}',
//                 style: TextStyle(fontSize: 11),
//               ),
//             ),
//             DataCell(
//               Text(
//                 'OMR ${transaction.oacAmount.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             DataCell(
//               Text(
//                 'OMR ${transaction.providerAmount.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue[700],
//                 ),
//               ),
//             ),
//             DataCell(
//               _buildSettlementChip(transaction.settlementStatus),
//             ),
//             DataCell(
//               SizedBox(
//                 width: 80,
//                 child: Text(
//                   transaction.settlementComment.isEmpty
//                       ? '-'
//                       : transaction.settlementComment,
//                   style: TextStyle(fontSize: 10),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//               ),
//             ),
//             DataCell(
//               IconButton(
//                 icon: Icon(Icons.visibility, size: 16),
//                 onPressed: () {
//                   _showTransactionDetails(transaction);
//                 },
//               ),
//             ),
//           ],
//         );
//       }).toList(),
//     );
//   }

//   int? _getSortColumnIndex() {
//     switch (_sortColumn) {
//       case 'transactionId':
//         return 0;
//       case 'totalAmount':
//         return 3;
//       case 'payStatus':
//         return 2;
//       case 'settlementStatus':
//         return 7;
//       default:
//         return null;
//     }
//   }

//   Widget _buildStatusChip(String status) {
//     Color chipColor;
//     switch (status.toLowerCase()) {
//       case 'success':
//         chipColor = Colors.green;
//         break;
//       case 'pending':
//         chipColor = Colors.orange;
//         break;
//       case 'failed':
//         chipColor = Colors.red;
//         break;
//       default:
//         chipColor = Colors.grey;
//     }

//     return Chip(
//       label: Text(
//         status,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 9,
//         ),
//       ),
//       backgroundColor: chipColor,
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       visualDensity: VisualDensity.compact,
//       padding: EdgeInsets.symmetric(horizontal: 4),
//     );
//   }

//   Widget _buildSettlementChip(String status) {
//     Color chipColor;
//     String displayStatus;

//     // Map API status to display status
//     switch (status.toLowerCase()) {
//       case 'settled':
//         chipColor = Colors.green;
//         displayStatus = 'SETTLED';
//         break;
//       case 'in_progress':
//         chipColor = Colors.orange;
//         displayStatus = 'IN PROGRESS';
//         break;
//       case 'in_review':
//         chipColor = Colors.blue;
//         displayStatus = 'IN REVIEW';
//         break;
//       default:
//         chipColor = Colors.grey;
//         displayStatus = status.replaceAll('_', ' ').toUpperCase();
//     }

//     return Chip(
//       label: Text(
//         displayStatus,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 8,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       backgroundColor: chipColor,
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       visualDensity: VisualDensity.compact,
//       padding: EdgeInsets.symmetric(horizontal: 4),
//     );
//   }

//   Widget _buildPaginationControls() {
//     final totalPages = (_filteredTransactions.length / _rowsPerPage).ceil();

//     return Container(
//       padding: EdgeInsets.all(12),
//       color: Colors.white,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             '${_currentPage * _rowsPerPage + 1}-${_currentPage * _rowsPerPage + _currentPageData.length} of ${_filteredTransactions.length}',
//             style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//           ),
//           Row(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.chevron_left, size: 20),
//                 onPressed: _currentPage > 0
//                     ? () {
//                         setState(() {
//                           _currentPage--;
//                         });
//                       }
//                     : null,
//               ),
//               Text(
//                 '${_currentPage + 1}/$totalPages',
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//               ),
//               IconButton(
//                 icon: Icon(Icons.chevron_right, size: 20),
//                 onPressed: _currentPage < totalPages - 1
//                     ? () {
//                         setState(() {
//                           _currentPage++;
//                         });
//                       }
//                     : null,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _showTransactionDetails(Transaction transaction) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         insetPadding: EdgeInsets.all(16),
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Transaction Details',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.close),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ],
//               ),
//               Divider(),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildDetailRow(
//                           'Transaction ID', transaction.transactionId),
//                       _buildDetailRow('User ID', '${transaction.userId}'),
//                       _buildDetailRow('Booking Date', transaction.bookingDate),
//                       _buildDetailRow('Status', transaction.payStatus),
//                       _buildDetailRow(
//                           'Settlement Status',
//                           _statusMapping[
//                                   transaction.settlementStatus.toLowerCase()] ??
//                               transaction.settlementStatus),
//                       _buildDetailRow(
//                           'Total Paid', 'OMR ${transaction.totalAmount}'),
//                       _buildDetailRow(
//                           'Refunded Amount', 'OMR ${transaction.clientRefund}'),
//                       _buildDetailRow(
//                           'Adventures Club', 'OMR ${transaction.oacAmount}'),
//                       _buildDetailRow('Partner Amount',
//                           'OMR ${transaction.providerAmount}'),
//                       _buildDetailRow(
//                           'Payment Channel', transaction.paymentChannel),
//                       if (transaction.message.isNotEmpty)
//                         _buildDetailRow('Message', transaction.message),
//                       if (transaction.settlementComment.isNotEmpty)
//                         _buildDetailRow(
//                             'Comment', transaction.settlementComment),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text('Close'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               '$label:',
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[700],
//                 fontSize: 12,
//               ),
//             ),
//           ),
//           SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(fontSize: 12, color: Colors.grey[800]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

// transaction_widget.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:app/constants.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/models/transaction_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class TransactionScreen extends StatefulWidget {
  final ServicesModel sm;
  const TransactionScreen({required this.sm, super.key});

  @override
  TransactionScreenState createState() => TransactionScreenState();
}

class TransactionScreenState extends State<TransactionScreen> {
  TransactionResponse? _transactionData;
  bool _isLoading = true;
  String _errorMessage = '';
  List<Transaction> _filteredTransactions = [];
  String _searchQuery = '';
  String _statusFilter = 'All';
  List<String> _statusOptions = ['All', 'Settled', 'In Progress', 'In Review'];
  int _rowsPerPage = 10;
  int _currentPage = 0;
  List<Transaction> _sortedTransactions = [];
  String _sortColumn = 'transactionId';
  bool _sortAscending = true;
  bool _isExporting = false;

  // Map for API status to display status
  final Map<String, String> _statusMapping = {
    'settled': 'Settled',
    'in_progress': 'In Progress',
    'in_review': 'In Review',
  };

  @override
  void initState() {
    super.initState();
    _loadTransactionData();
  }

  Future<TransactionResponse?> getServiceData() async {
    try {
      var response = await http.post(
        Uri.parse("${Constants.baseUrl}/api/v1/getTransactionByServiceId"),
        body: {'service_id': widget.sm.id.toString()},
      );

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

        Map<String, dynamic> convertedResponse = {};
        decodedResponse.forEach((key, value) {
          convertedResponse[key.toString()] = value;
        });

        return TransactionResponse.fromJson(convertedResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("${"tractions data"}${e.toString()}");
      print(e.toString());
      return null;
    }
  }

  Future<void> _loadTransactionData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final data = await getServiceData();
      setState(() {
        _transactionData = data;
        _filteredTransactions = data?.data.transactions ?? [];
        _sortedTransactions = List.from(_filteredTransactions);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("${"tractions"}${e.toString()}");
      setState(() {
        _errorMessage = 'Failed to load transaction data';
        _isLoading = false;
      });
    }
  }

  Future<void> _exportToExcel() async {
    if (_filteredTransactions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No data to export'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isExporting = true;
    });

    try {
      // Create Excel workbook
      var excel = Excel.createExcel();
      var sheet = excel['Transaction Report'];

      // Add headers
      List<String> headers = [
        'Transaction ID',
        'User ID',
        'Service Date',
        'Total Amount (OMR)',
        'Refunded Amount (OMR)',
        'Adventures Club (OMR)',
        'Partner Amount (OMR)',
        'Payment Channel',
        'Settlement Status',
        'Settlement Comment',
        'Message'
      ];

      for (int i = 0; i < headers.length; i++) {
        final cell = sheet
            .cell(CellIndex.indexByString("${String.fromCharCode(65 + i)}1"));
        cell.value = TextCellValue(headers[i]);
        cell.cellStyle = CellStyle(
          bold: true,
          // backgroundColor: const ExcelColor.blue(), // Use ExcelColor instead of hex
          //fontColor: const ExcelColor.white(),      // Use ExcelColor instead of hex
        );
      }

      // Add data rows
      for (int i = 0; i < _filteredTransactions.length; i++) {
        final transaction = _filteredTransactions[i];
        final rowIndex = i + 2; // Start from row 2 (after header)

        // Transaction ID
        sheet.cell(CellIndex.indexByString("A$rowIndex")).value =
            TextCellValue(transaction.transactionId);

        // User ID
        sheet.cell(CellIndex.indexByString("B$rowIndex")).value =
            TextCellValue(transaction.userId.toString());

        // Booking Date
        sheet.cell(CellIndex.indexByString("C$rowIndex")).value =
            TextCellValue(transaction.bookingDate);

        // Total Amount
        sheet.cell(CellIndex.indexByString("D$rowIndex")).value =
            DoubleCellValue(transaction.totalAmount);

        // Refunded Amount
        sheet.cell(CellIndex.indexByString("E$rowIndex")).value =
            DoubleCellValue(transaction.clientRefund);

        // Adventures Club Amount
        sheet.cell(CellIndex.indexByString("F$rowIndex")).value =
            DoubleCellValue(transaction.oacAmount);

        // Partner Amount
        sheet.cell(CellIndex.indexByString("G$rowIndex")).value =
            DoubleCellValue(transaction.providerAmount);

        // Payment Channel
        sheet.cell(CellIndex.indexByString("H$rowIndex")).value =
            TextCellValue(transaction.paymentChannel);

        // Settlement Status
        sheet.cell(CellIndex.indexByString("I$rowIndex")).value = TextCellValue(
          _statusMapping[transaction.settlementStatus.toLowerCase()] ??
              transaction.settlementStatus,
        );

        // Settlement Comment
        sheet.cell(CellIndex.indexByString("J$rowIndex")).value = TextCellValue(
          transaction.settlementComment.isEmpty
              ? 'No comment'
              : transaction.settlementComment,
        );

        // Message
        sheet.cell(CellIndex.indexByString("K$rowIndex")).value = TextCellValue(
          transaction.message.isEmpty ? 'No message' : transaction.message,
        );
      }

      // Auto-size columns - using the correct method with column index (int)
      for (int i = 0; i < headers.length; i++) {
        // Use column index (int) instead of letter (String)
        sheet.setColumnWidth(
            i, 20.0); // Set a reasonable width using column index
      }

      // Generate file name with timestamp
      final timestamp = DateTime.now()
          .toString()
          .replaceAll(RegExp(r'[^\d]'), '')
          .substring(0, 14);
      final fileName = 'transactions_$timestamp.xlsx';

      // Save and download - convert List<int> to Uint8List
      final excelBytes = excel.save();
      if (excelBytes != null) {
        // Convert List<int> to Uint8List
        final uint8List = Uint8List.fromList(excelBytes);
        await _saveExcelFile(uint8List, fileName);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Excel file saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Excel export error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to export Excel: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isExporting = false;
      });
    }
  }

  Future<void> _saveExcelFile(Uint8List bytes, String fileName) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        // For mobile - save to downloads directory and open
        final directory = await getDownloadsDirectory();
        if (directory != null) {
          final file = File('${directory.path}/$fileName');
          await file.writeAsBytes(bytes);
          await OpenFile.open(file.path);
        }
      } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        // For desktop - save to documents directory and open
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(bytes);
        await OpenFile.open(file.path);
      } else {
        // For web - use download method (though this won't work without universal_html)
        // Fallback: Show dialog with instructions
        _showDownloadInstructions(bytes, fileName);
      }
    } catch (e) {
      // Fallback for all platforms
      _showDownloadInstructions(bytes, fileName);
    }
  }

  void _showDownloadInstructions(Uint8List bytes, String fileName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Export Complete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Excel file has been generated.'),
            SizedBox(height: 16),
            Text(
              'To save the file:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('1. Copy the file path below'),
            Text('2. Save it to your desired location'),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.grey[100],
              child: SelectableText(
                'File: $fileName\nSize: ${(bytes.length / 1024).toStringAsFixed(2)} KB',
                style: TextStyle(fontFamily: 'Monospace'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // For web, you might want to use a different approach
              // This is a simple fallback
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('File ready for download'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    List<Transaction> filtered = _transactionData?.data.transactions ?? [];

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((transaction) =>
              transaction.transactionId
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              transaction.paymentChannel
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              transaction.bookingDate
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              transaction.message
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply status filter - fixed mapping
    if (_statusFilter != 'All') {
      filtered = filtered.where((transaction) {
        // Map the API status to display status for filtering
        final apiStatus = transaction.settlementStatus.toLowerCase();
        final displayStatus = _statusMapping[apiStatus] ?? apiStatus;
        return displayStatus == _statusFilter;
      }).toList();
    }

    setState(() {
      _filteredTransactions = filtered;
      _sortedTransactions = List.from(_filteredTransactions);
      _currentPage = 0;
      _sortData(_sortColumn, _sortAscending);
    });
  }

  void _sortData(String column, bool ascending) {
    setState(() {
      _sortColumn = column;
      _sortAscending = ascending;

      _sortedTransactions.sort((a, b) {
        int comparison = 0;
        switch (column) {
          case 'transactionId':
            comparison = a.transactionId.compareTo(b.transactionId);
            break;
          case 'totalAmount':
            comparison = a.totalAmount.compareTo(b.totalAmount);
            break;
          case 'bookingDate':
            comparison = a.bookingDate.compareTo(b.bookingDate);
            break;
          case 'payStatus':
            comparison = a.payStatus.compareTo(b.payStatus);
            break;
          case 'settlementStatus':
            comparison = a.settlementStatus.compareTo(b.settlementStatus);
            break;
          default:
            comparison = 0;
        }
        return ascending ? comparison : -comparison;
      });
    });
  }

  List<Transaction> get _currentPageData {
    final startIndex = _currentPage * _rowsPerPage;
    final endIndex = startIndex + _rowsPerPage;
    return _sortedTransactions.sublist(
      startIndex,
      endIndex > _sortedTransactions.length
          ? _sortedTransactions.length
          : endIndex,
    );
  }

  // Calculate summary values
  double get _totalEarnings => _transactionData?.data.totalEarnings ?? 0;
  double get _pendingSettlements =>
      _transactionData?.data.pendingSettlements ?? 0;
  double get _settledAmount => _totalEarnings - _pendingSettlements;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Transaction Details'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: kSecondaryColor,
        elevation: 0,
        actions: [
          // Export to Excel button
          _isExporting
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    Icons.download,
                    size: 32,
                    color: Colors.white,
                  ),
                  tooltip: 'Export to Excel'.tr(),
                  onPressed: _exportToExcel,
                ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: 32,
              color: Colors.white,
            ),
            tooltip: 'Refresh Data'.tr(),
            onPressed: _loadTransactionData,
          ),
        ],
      ),
      body: _isLoading
          ? _buildLoadingWidget()
          : _errorMessage.isNotEmpty
              ? _buildErrorWidget()
              : _transactionData == null
                  ? _buildNoDataWidget()
                  : _buildDataTableWidget(),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!),
          ),
          SizedBox(height: 16),
          Text(
            'Loading transaction data...'.tr(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          SizedBox(height: 16),
          Text(
            _errorMessage.tr(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadTransactionData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              foregroundColor: Colors.white,
            ),
            child: Text('Try Again'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No transaction data available'.tr(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTableWidget() {
    return Column(
      children: [
        // Summary Cards - Compact mobile layout
        _buildSummaryCards(),
        SizedBox(height: 12),

        // Export info banner
        if (_filteredTransactions.isNotEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              //  border: Border.all(color: Colors.blue[100]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info, size: 16, color: Colors.blue[600]),
                SizedBox(width: 8),
                Text(
                  '${_filteredTransactions.length} "${"transactions available for export".tr()}"',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 8),

        // Filters and Search
        _buildFilterBar(),
        SizedBox(height: 12),

        // DataTable with horizontal scroll
        Expanded(
          child: _buildScrollableDataTable(),
        ),

        // Pagination
        _buildPaginationControls(),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.white,
      child: Column(
        children: [
          // Main total earnings
          _buildSummaryRow(
            'TOTAL EARNINGS'.tr(),
            '${"OMR".tr()} $_totalEarnings',
            Icons.attach_money,
            Colors.green,
            isMain: true,
          ),
          SizedBox(height: 8),

          // Sub totals in a row
          Row(
            children: [
              Expanded(
                child: _buildSummaryRow(
                  'SETTLED'.tr(),
                  '${"OMR".tr()} $_settledAmount',
                  Icons.check_circle,
                  Colors.blue,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildSummaryRow(
                  'PENDING'.tr(),
                  '${"OMR".tr()} $_pendingSettlements',
                  Icons.pending_actions,
                  Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
      String title, String value, IconData icon, Color color,
      {bool isMain = false}) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMain ? color.withOpacity(0.1) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: isMain ? 20 : 16),
              SizedBox(width: 8),
              Text(
                title.tr(),
                style: TextStyle(
                  fontSize: isMain ? 14 : 12,
                  fontWeight: isMain ? FontWeight.bold : FontWeight.normal,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Text(
            value.tr(),
            style: TextStyle(
              fontSize: isMain ? 16 : 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.white,
      child: Column(
        children: [
          // Search Field
          TextField(
            decoration: InputDecoration(
              hintText: 'Search transactions...'.tr(),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
              _applyFilters();
            },
          ),
          SizedBox(height: 8),
          Row(
            children: [
              // Status Filter
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _statusFilter,
                  decoration: InputDecoration(
                    labelText: 'Settlement Status'.tr(),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    isDense: true,
                  ),
                  items: _statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(
                        status.tr(),
                        style: TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _statusFilter = value!;
                    });
                    _applyFilters();
                  },
                ),
              ),
              SizedBox(width: 8),
              // Rows per page
              DropdownButtonFormField<int>(
                value: _rowsPerPage,
                decoration: InputDecoration(
                  labelText: 'Rows'.tr(),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  isDense: true,
                ),
                items: [5, 10, 15, 20].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                      '$value'.tr(),
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _rowsPerPage = value!;
                    _currentPage = 0;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableDataTable() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Card(
            elevation: 2,
            child: _buildDataTable(),
          ),
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
      headingRowColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) => Colors.blue[50],
      ),
      dataRowMinHeight: 40,
      dataRowMaxHeight: 60,
      headingRowHeight: 44,
      columnSpacing: 12,
      horizontalMargin: 8,
      sortColumnIndex: _getSortColumnIndex(),
      sortAscending: _sortAscending,
      columns: [
        DataColumn(
          label: Text(
            'Transaction ID'.tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          onSort: (columnIndex, ascending) {
            _sortData('transactionId', ascending);
          },
        ),
        DataColumn(
          label: Text(
            //'Name'.tr(),
            'User Name'.tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Booking Date'.tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          onSort: (columnIndex, ascending) {
            _sortData('payStatus', ascending);
          },
        ),
        DataColumn(
          label: Text(
            'Total Paid'.tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          numeric: true,
          onSort: (columnIndex, ascending) {
            _sortData('totalAmount', ascending);
          },
        ),
        DataColumn(
          label: Text(
            'Refunded'.tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          numeric: true,
        ),
        DataColumn(
          label: Text(
            "Adventures Club".tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          numeric: true,
        ),
        DataColumn(
          label: Text(
            'Partner'.tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          numeric: true,
        ),
        DataColumn(
          label: Text(
            "Booking Status".tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          numeric: true,
        ),
        DataColumn(
          label: Text(
            "Settlement Status".tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          onSort: (columnIndex, ascending) {
            _sortData('settlementStatus', ascending);
          },
        ),
        DataColumn(
          label: Text(
            'Comment'.tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Actions'.tr(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: _currentPageData.map((transaction) {
        final statusInfo =
            Constants.getStatusInfo(transaction.bookingStatus ?? "");
        return DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: 80,
                child: Text(
                  transaction.transactionId.length > 8
                      ? '${transaction.transactionId.substring(0, 8)}...'
                      : transaction.transactionId,
                  style: TextStyle(fontSize: 11, fontFamily: 'Monospace'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            DataCell(
              Text(
                transaction.name!.tr(),
                style: TextStyle(fontSize: 11),
              ),
            ),
            DataCell(
              Text(
                transaction.bookingDate,
                style: TextStyle(
                  fontSize: 11,
                  //   fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DataCell(
              Text(
                '${"OMR".tr()} ${transaction.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[700],
                ),
              ),
            ),
            DataCell(
              Text(
                '${"OMR".tr()} ${transaction.clientRefund.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 11),
              ),
            ),
            DataCell(
              Text(
                '${"OMR".tr()} ${transaction.oacAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DataCell(
              Text(
                '${"OMR".tr()} ${transaction.providerAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: 80,
                child: Text(
                  transaction.settlementComment.isEmpty
                      ? "" //statusInfo['text']
                      : statusInfo['text'],
                  style: TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            DataCell(
              _buildSettlementChip(transaction.settlementStatus.tr()),
            ),
            DataCell(
              SizedBox(
                width: 80,
                child: Text(
                  transaction.settlementComment.isEmpty
                      ? '-'
                      : transaction.settlementComment.tr(),
                  style: TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            DataCell(
              IconButton(
                icon: Icon(Icons.visibility, size: 16),
                onPressed: () {
                  _showTransactionDetails(transaction);
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  int? _getSortColumnIndex() {
    switch (_sortColumn) {
      case 'transactionId':
        return 0;
      case 'totalAmount':
        return 3;
      case 'payStatus':
        return 2;
      case 'settlementStatus':
        return 7;
      default:
        return null;
    }
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status.toLowerCase()) {
      case 'success':
        chipColor = Colors.green;
        break;
      case 'pending':
        chipColor = Colors.orange;
        break;
      case 'failed':
        chipColor = Colors.red;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Chip(
      label: Text(
        status,
        style: TextStyle(
          color: Colors.white,
          fontSize: 9,
        ),
      ),
      //backgroundColor = chipColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildSettlementChip(String status) {
    Color chipColor;
    String displayStatus;

    // Map API status to display status
    switch (status.toLowerCase()) {
      case 'settled':
        chipColor = Colors.green;
        displayStatus = 'SETTLED';
        break;
      case 'in_progress':
        chipColor = Colors.orange;
        displayStatus = 'IN PROGRESS';
        break;
      case 'in_review':
        chipColor = Colors.blue;
        displayStatus = 'IN REVIEW';
        break;
      default:
        chipColor = Colors.grey;
        displayStatus = status.replaceAll('_', ' ').toUpperCase();
    }

    return Chip(
      label: Text(
        displayStatus,
        style: TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: chipColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildPaginationControls() {
    final totalPages = (_filteredTransactions.length / _rowsPerPage).ceil();

    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_currentPage * _rowsPerPage + 1}-${_currentPage * _rowsPerPage + _currentPageData.length} of ${_filteredTransactions.length}',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left, size: 20),
                onPressed: _currentPage > 0
                    ? () {
                        setState(() {
                          _currentPage--;
                        });
                      }
                    : null,
              ),
              Text(
                '${_currentPage + 1}/$totalPages',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right, size: 20),
                onPressed: _currentPage < totalPages - 1
                    ? () {
                        setState(() {
                          _currentPage++;
                        });
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(Transaction transaction) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction Details'.tr(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                          'Transaction ID', transaction.transactionId),
                      _buildDetailRow('User Name', '${transaction.name}'),
                      _buildDetailRow('Booking Date', transaction.bookingDate),
                      _buildDetailRow('Status', transaction.payStatus),
                      _buildDetailRow(
                          'Settlement Status',
                          _statusMapping[
                                  transaction.settlementStatus.toLowerCase()] ??
                              transaction.settlementStatus),
                      _buildDetailRow(
                          'Total Paid', 'OMR ${transaction.totalAmount}'),
                      _buildDetailRow(
                          'Refunded Amount', 'OMR ${transaction.clientRefund}'),
                      _buildDetailRow(
                          'Adventures Club', 'OMR ${transaction.oacAmount}'),
                      _buildDetailRow('Partner Amount',
                          'OMR ${transaction.providerAmount}'),
                      _buildDetailRow(
                          'Payment Channel', transaction.paymentChannel),
                      if (transaction.message.isNotEmpty)
                        _buildDetailRow('Message', transaction.message),
                      if (transaction.settlementComment.isNotEmpty)
                        _buildDetailRow(
                            'Comment', transaction.settlementComment),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "${label.tr()} : ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value.tr(),
              style: TextStyle(fontSize: 12, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
