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

//   @override
//   void initState() {
//     super.initState();
//     _loadTransactionData();
//   }

//   // transaction_service.dart

//   Future<TransactionResponse?> getServiceData() async {
//     try {
//       var response = await http.post(
//         Uri.parse("${Constants.baseUrl}/api/v1/getTransactionByServiceId"),
//         body: {'service_id': "185"},
//       );

//       if (response.statusCode == 200) {
//         var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

//         // Convert Map<dynamic, dynamic> to Map<String, dynamic>
//         Map<String, dynamic> convertedResponse = {};
//         decodedResponse.forEach((key, value) {
//           convertedResponse[key.toString()] = value;
//         });

//         return TransactionResponse.fromJson(convertedResponse);
//       } else {
//         throw Exception('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
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
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to load transaction data';
//         _isLoading = false;
//       });
//     }
//   }

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
//                   : _buildContentWidget(),
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

//   Widget _buildContentWidget() {
//     final data = _transactionData!.data;

//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Summary Cards
//           _buildSummaryCards(data),
//           SizedBox(height: 24),

//           // Transactions List
//           Text(
//             'Transactions',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//           ),
//           SizedBox(height: 16),

//           if (data.transactions.isEmpty)
//             _buildNoTransactionsWidget()
//           else
//             ...data.transactions
//                 .map((transaction) => _buildTransactionCard(transaction))
//                 .toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryCards(TransactionData data) {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildSummaryCard(
//             'Total Earnings',
//             '\$${data.totalEarnings}',
//             Icons.attach_money,
//             Colors.green,
//           ),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: _buildSummaryCard(
//             'Sold Amount',
//             '\$${data.selledAmount}',
//             Icons.shopping_cart,
//             Colors.blue,
//           ),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: _buildSummaryCard(
//             'Pending',
//             '\$${data.pendingSettlements}',
//             Icons.pending_actions,
//             Colors.orange,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSummaryCard(
//       String title, String value, IconData icon, Color color) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Icon(icon, color: color, size: 32),
//             SizedBox(height: 8),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[800],
//               ),
//             ),
//             SizedBox(height: 4),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[600],
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNoTransactionsWidget() {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(32),
//         child: Column(
//           children: [
//             Icon(
//               Icons.receipt_long,
//               size: 48,
//               color: Colors.grey[400],
//             ),
//             SizedBox(height: 16),
//             Text(
//               'No transactions found',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTransactionCard(Transaction transaction) {
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Transaction #${transaction.transactionId}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue[800],
//                   ),
//                 ),
//                 _buildStatusChip(transaction.payStatus),
//               ],
//             ),
//             SizedBox(height: 12),

//             // Amount Information
//             _buildInfoRow('Total Amount', '\$${transaction.totalAmount}'),
//             _buildInfoRow(
//                 'Discounted Amount', '\$${transaction.discountedAmount}'),
//             _buildInfoRow('Provider Amount', '\$${transaction.providerAmount}'),
//             _buildInfoRow('OAC Amount', '\$${transaction.oacAmount}'),

//             Divider(height: 20),

//             // Booking Details
//             _buildInfoRow('Booking Date', transaction.bookingDate),
//             _buildInfoRow(
//                 'Adults/Kids', '${transaction.adult} / ${transaction.kids}'),
//             _buildInfoRow('Payment Channel', transaction.paymentChannel),

//             if (transaction.message.isNotEmpty) ...[
//               Divider(height: 20),
//               _buildInfoRow('Message', transaction.message),
//             ],

//             if (transaction.settlementComment.isNotEmpty) ...[
//               Divider(height: 20),
//               _buildInfoRow(
//                   'Settlement Comment', transaction.settlementComment),
//             ],

//             // Settlement Status
//             Divider(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Settlement Status:',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 _buildSettlementChip(transaction.settlementStatus),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 14,
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
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
//           fontSize: 12,
//         ),
//       ),
//       backgroundColor: chipColor,
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     );
//   }

//   Widget _buildSettlementChip(String status) {
//     Color chipColor;
//     switch (status.toLowerCase()) {
//       case 'settled':
//         chipColor = Colors.green;
//         break;
//       case 'pending':
//         chipColor = Colors.orange;
//         break;
//       default:
//         chipColor = Colors.grey;
//     }

//     return Chip(
//       label: Text(
//         status.toUpperCase(),
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 10,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       backgroundColor: chipColor,
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     );
//   }
// }

// transaction_widget.dart
import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

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
  List<String> _statusOptions = ['All', 'Success', 'Pending', 'Failed'];
  int _rowsPerPage = 10;
  int _currentPage = 0;
  List<Transaction> _sortedTransactions = [];
  String _sortColumn = 'transactionId';
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _loadTransactionData();
  }

  Future<TransactionResponse?> getServiceData() async {
    try {
      var response = await http.post(
        Uri.parse("${Constants.baseUrl}/api/v1/getTransactionByServiceId"),
        body: {'service_id': "185"},
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
      setState(() {
        _errorMessage = 'Failed to load transaction data';
        _isLoading = false;
      });
    }
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

    // Apply status filter
    if (_statusFilter != 'All') {
      filtered = filtered
          .where((transaction) =>
              transaction.payStatus.toLowerCase() ==
              _statusFilter.toLowerCase())
          .toList();
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
            comparison = double.parse(a.totalAmount)
                .compareTo(double.parse(b.totalAmount));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Transaction Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
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
            'Loading transaction data...',
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
            _errorMessage,
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
            child: Text('Try Again'),
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
            'No transaction data available',
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
    final data = _transactionData!.data;

    return Column(
      children: [
        // Summary Cards
        _buildSummaryCards(data),
        SizedBox(height: 16),

        // Filters and Search
        _buildFilterBar(),
        SizedBox(height: 16),

        // DataTable
        Expanded(
          child: _buildDataTable(),
        ),

        // Pagination
        _buildPaginationControls(),
      ],
    );
  }

  Widget _buildSummaryCards(TransactionData data) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Total Earnings',
              '\$${data.totalEarnings}',
              Icons.attach_money,
              Colors.green,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'Sold Amount',
              '\$${data.selledAmount}',
              Icons.shopping_cart,
              Colors.blue,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'Pending',
              '\$${data.pendingSettlements}',
              Icons.pending_actions,
              Colors.orange,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'Total Transactions',
              '${_transactionData!.data.transactions.length}',
              Icons.list_alt,
              Colors.purple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search transactions...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _applyFilters();
              },
            ),
          ),
          SizedBox(width: 16),

          // Status Filter
          Container(
            width: 150,
            child: DropdownButtonFormField<String>(
              value: _statusFilter,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              items: _statusOptions.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
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
          SizedBox(width: 16),

          // Rows per page
          Container(
            width: 120,
            child: DropdownButtonFormField<int>(
              value: _rowsPerPage,
              decoration: InputDecoration(
                labelText: 'Rows',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              items: [5, 10, 25, 50].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value per page'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _rowsPerPage = value!;
                  _currentPage = 0;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: DataTable(
          headingRowColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) => Colors.blue[50],
          ),
          sortColumnIndex: _getSortColumnIndex(),
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
              label: Text('Transaction ID'),
              onSort: (columnIndex, ascending) {
                _sortData('transactionId', ascending);
              },
            ),
            DataColumn(
              label: Text('Amount'),
              numeric: true,
              onSort: (columnIndex, ascending) {
                _sortData('totalAmount', ascending);
              },
            ),
            // DataColumn(
            //   label: Text('Discounted'),
            //   numeric: true,
            // ),
            // DataColumn(
            //   label: Text('Provider'),
            //   numeric: true,
            // ),
            DataColumn(
              label: Text('Booking Date'),
              onSort: (columnIndex, ascending) {
                _sortData('bookingDate', ascending);
              },
            ),
            DataColumn(
              label: Text('Payment Status'),
              onSort: (columnIndex, ascending) {
                _sortData('payStatus', ascending);
              },
            ),
            DataColumn(
              label: Text('Settlement Status'),
              onSort: (columnIndex, ascending) {
                _sortData('settlementStatus', ascending);
              },
            ),
            DataColumn(
              label: Text('Actions'),
            ),
          ],
          rows: _currentPageData.map((transaction) {
            return DataRow(
              cells: [
                DataCell(
                  Tooltip(
                    message: 'ID: ${transaction.transactionId}',
                    child: Text(
                      transaction.transactionId.length > 8
                          ? '${transaction.transactionId.substring(0, 8)}...'
                          : transaction.transactionId,
                      style: TextStyle(fontFamily: 'Monospace'),
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    '\$${transaction.totalAmount}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ),
                // DataCell(Text('\$${transaction.discountedAmount}')),
                // DataCell(Text('\$${transaction.providerAmount}')),
                DataCell(Text(transaction.bookingDate)),
                DataCell(_buildStatusChip(transaction.payStatus)),
                DataCell(_buildSettlementChip(transaction.settlementStatus)),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.visibility, size: 18),
                    onPressed: () {
                      _showTransactionDetails(transaction);
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  int? _getSortColumnIndex() {
    switch (_sortColumn) {
      case 'transactionId':
        return 0;
      case 'totalAmount':
        return 1;
      case 'bookingDate':
        return 4;
      case 'payStatus':
        return 5;
      case 'settlementStatus':
        return 6;
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
          fontSize: 10,
        ),
      ),
      backgroundColor: chipColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildSettlementChip(String status) {
    Color chipColor;
    switch (status.toLowerCase()) {
      case 'settled':
        chipColor = Colors.green;
        break;
      case 'pending':
        chipColor = Colors.orange;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Chip(
      label: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: chipColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildPaginationControls() {
    final totalPages = (_filteredTransactions.length / _rowsPerPage).ceil();

    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing ${_currentPage * _rowsPerPage + 1} to ${_currentPage * _rowsPerPage + _currentPageData.length} of ${_filteredTransactions.length} transactions',
            style: TextStyle(color: Colors.grey[600]),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: _currentPage > 0
                    ? () {
                        setState(() {
                          _currentPage--;
                        });
                      }
                    : null,
              ),
              Text(
                'Page ${_currentPage + 1} of $totalPages',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right),
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
      builder: (context) => AlertDialog(
        title: Text('Transaction Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Transaction ID', transaction.transactionId),
              _buildDetailRow('Total Amount', '\$${transaction.totalAmount}'),
              // _buildDetailRow(
              //     'Discounted Amount', '\$${transaction.discountedAmount}'),
              // _buildDetailRow(
              //     'Provider Amount', '\$${transaction.providerAmount}'),
              _buildDetailRow('OAC Amount', '\$${transaction.oacAmount}'),
              _buildDetailRow('Booking Date', transaction.bookingDate),
              _buildDetailRow(
                  'Adults/Kids', '${transaction.adult} / ${transaction.kids}'),
              _buildDetailRow('Payment Channel', transaction.paymentChannel),
              _buildDetailRow('Payment Status', transaction.payStatus),
              _buildDetailRow(
                  'Settlement Status', transaction.settlementStatus),
              if (transaction.message.isNotEmpty)
                _buildDetailRow('Message', transaction.message),
              if (transaction.settlementComment.isNotEmpty)
                _buildDetailRow(
                    'Settlement Comment', transaction.settlementComment),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
