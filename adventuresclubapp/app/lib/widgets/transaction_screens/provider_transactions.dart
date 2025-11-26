// provider_transactions_widget.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:app/constants.dart';
import 'package:app/models/transactions/provider_transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class ProviderTransactions extends StatefulWidget {
  const ProviderTransactions({super.key});

  @override
  ProviderTransactionsState createState() => ProviderTransactionsState();
}

class ProviderTransactionsState extends State<ProviderTransactions> {
  ProviderTransactionResponse? _transactionData;
  bool _isLoading = true;
  String _errorMessage = '';
  List<ProviderTransaction> _filteredTransactions = [];
  String _searchQuery = '';
  String _statusFilter = 'All';
  List<String> _statusOptions = ['All', 'Settled', 'In Progress', 'In Review'];
  int _rowsPerPage = 10;
  int _currentPage = 0;
  List<ProviderTransaction> _sortedTransactions = [];
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

  Future<ProviderTransactionResponse?> getProviderData() async {
    try {
      var response = await http.post(
        Uri.parse("${Constants.baseUrl}/api/v1/getTransactionByProviderId"),
        body: {
          'provider_id': Constants.userId.toString(),
        }, // You can make this dynamic
      );

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

        Map<String, dynamic> convertedResponse = {};
        decodedResponse.forEach((key, value) {
          convertedResponse[key.toString()] = value;
        });

        return ProviderTransactionResponse.fromJson(convertedResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Provider transactions data error: ${e.toString()}");
      return null;
    }
  }

  Future<void> _loadTransactionData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final data = await getProviderData();
      setState(() {
        _transactionData = data;
        _filteredTransactions = data?.data.transactions ?? [];
        _sortedTransactions = List.from(_filteredTransactions);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Provider transactions error: ${e.toString()}");
      setState(() {
        _errorMessage = 'Failed to load provider transaction data';
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
      var sheet = excel['Provider Transactions Report'];

      // Add headers
      List<String> headers = [
        'Transaction ID',
        'User Name',
        'Adventure Name',
        'Booking Date',
        'Total Amount (OMR)',
        'Discounted Amount (OMR)',
        'Refunded Amount (OMR)',
        'Provider Amount (OMR)',
        'OAC Amount (OMR)',
        'Payment Channel',
        'Settlement Status',
        'Settlement Comment',
        'Message'
      ];

      for (int i = 0; i < headers.length; i++) {
        final cell = sheet
            .cell(CellIndex.indexByString("${String.fromCharCode(65 + i)}1"));
        cell.value = TextCellValue(headers[i]);
        cell.cellStyle = CellStyle(bold: true);
      }

      // Add data rows
      for (int i = 0; i < _filteredTransactions.length; i++) {
        final transaction = _filteredTransactions[i];
        final rowIndex = i + 2;

        sheet.cell(CellIndex.indexByString("A$rowIndex")).value =
            TextCellValue(transaction.transactionId);

        sheet.cell(CellIndex.indexByString("B$rowIndex")).value =
            TextCellValue(transaction.name);

        sheet.cell(CellIndex.indexByString("C$rowIndex")).value =
            TextCellValue(transaction.adventureName);

        sheet.cell(CellIndex.indexByString("D$rowIndex")).value =
            TextCellValue(transaction.bookingDate);

        sheet.cell(CellIndex.indexByString("E$rowIndex")).value =
            DoubleCellValue(transaction.totalAmount);

        sheet.cell(CellIndex.indexByString("F$rowIndex")).value =
            DoubleCellValue(transaction.discountedAmount);

        sheet.cell(CellIndex.indexByString("G$rowIndex")).value =
            DoubleCellValue(transaction.clientRefund);

        sheet.cell(CellIndex.indexByString("H$rowIndex")).value =
            DoubleCellValue(transaction.providerAmount);

        sheet.cell(CellIndex.indexByString("I$rowIndex")).value =
            DoubleCellValue(transaction.oacAmount);

        sheet.cell(CellIndex.indexByString("J$rowIndex")).value =
            TextCellValue(transaction.paymentChannel);

        sheet.cell(CellIndex.indexByString("K$rowIndex")).value = TextCellValue(
          _statusMapping[transaction.settlementStatus.toLowerCase()] ??
              transaction.settlementStatus,
        );

        sheet.cell(CellIndex.indexByString("L$rowIndex")).value =
            TextCellValue(transaction.settlementComment);

        sheet.cell(CellIndex.indexByString("M$rowIndex")).value = TextCellValue(
            transaction.message.isEmpty ? 'No message' : transaction.message);
      }

      // Set column widths
      for (int i = 0; i < headers.length; i++) {
        sheet.setColumnWidth(i, 15.0);
      }

      // Generate file name with timestamp
      final timestamp = DateTime.now()
          .toString()
          .replaceAll(RegExp(r'[^\d]'), '')
          .substring(0, 14);
      final fileName = 'provider_transactions_$timestamp.xlsx';

      // Save and download
      final excelBytes = excel.save();
      if (excelBytes != null) {
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
        final directory = await getDownloadsDirectory();
        if (directory != null) {
          final file = File('${directory.path}/$fileName');
          await file.writeAsBytes(bytes);
          await OpenFile.open(file.path);
        }
      } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(bytes);
        await OpenFile.open(file.path);
      } else {
        _showDownloadInstructions(bytes, fileName);
      }
    } catch (e) {
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
            Text('File: $fileName'),
            Text('Size: ${(bytes.length / 1024).toStringAsFixed(2)} KB'),
          ],
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

  void _applyFilters() {
    List<ProviderTransaction> filtered =
        _transactionData?.data.transactions ?? [];

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((transaction) =>
              transaction.transactionId
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              transaction.name
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              transaction.adventureName
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              transaction.paymentChannel
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply status filter
    if (_statusFilter != 'All') {
      filtered = filtered.where((transaction) {
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
          case 'providerAmount':
            comparison = a.providerAmount.compareTo(b.providerAmount);
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

  List<ProviderTransaction> get _currentPageData {
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
  double get _selledAmount => _transactionData?.data.selledAmount ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Provider Transactions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
        actions: [
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
                    color: Colors.white,
                    size: 32,
                  ),
                  tooltip: 'Export to Excel',
                  onPressed: _exportToExcel,
                ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 32,
            ),
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
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[800]!),
          ),
          SizedBox(height: 16),
          Text(
            'Loading provider transactions...',
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
              backgroundColor: Colors.purple[800],
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
            'No provider transaction data available',
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
        // Summary Cards
        _buildSummaryCards(),
        SizedBox(height: 12),

        // Export info
        if (_filteredTransactions.isNotEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info, size: 16, color: Colors.purple[600]),
                SizedBox(width: 8),
                Text(
                  '${_filteredTransactions.length} transactions available for export',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.purple[700],
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

        // DataTable
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
            'TOTAL EARNINGS',
            'OMR $_totalEarnings',
            Icons.attach_money,
            Colors.green,
            isMain: true,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildSummaryRow(
                  'SETTLED',
                  'OMR $_selledAmount',
                  Icons.shopping_cart,
                  Colors.blue,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildSummaryRow(
                  'PENDING',
                  'OMR $_pendingSettlements',
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
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: isMain ? 20 : 16),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: isMain ? 14 : 12,
                  fontWeight: isMain ? FontWeight.bold : FontWeight.normal,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Text(
            value,
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
          TextField(
            decoration: InputDecoration(
              hintText: 'Search transactions...',
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
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _statusFilter,
                  decoration: InputDecoration(
                    labelText: 'Settlement Status',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    isDense: true,
                  ),
                  items: _statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status, style: TextStyle(fontSize: 14)),
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
              Container(
                width: 120,
                child: DropdownButtonFormField<int>(
                  value: _rowsPerPage,
                  decoration: InputDecoration(
                    labelText: 'Rows',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    isDense: true,
                  ),
                  items: [5, 10, 15, 20].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value', style: TextStyle(fontSize: 14)),
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
      headingRowColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) => Colors.purple[50],
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
          label: Text('Transaction ID',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          onSort: (columnIndex, ascending) {
            _sortData('transactionId', ascending);
          },
        ),
        DataColumn(
          label: Text('User Name',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('Adventure',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('Booking Date',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          onSort: (columnIndex, ascending) {
            _sortData('bookingDate', ascending);
          },
        ),
        DataColumn(
          label: Text('Total Paid',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          numeric: true,
          onSort: (columnIndex, ascending) {
            _sortData('totalAmount', ascending);
          },
        ),
        DataColumn(
          label: Text('Refunded',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          numeric: true,
        ),
        DataColumn(
          label: Text('Adventures\nClub',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          numeric: true,
        ),
        DataColumn(
          label: Text('Provider\nAmount',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          numeric: true,
          onSort: (columnIndex, ascending) {
            _sortData('providerAmount', ascending);
          },
        ),
        DataColumn(
          label: Text('Booking\nStatus',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          numeric: true,
        ),
        DataColumn(
          label: Text('Settlement\nStatus',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          onSort: (columnIndex, ascending) {
            _sortData('settlementStatus', ascending);
          },
        ),
        DataColumn(
          label: Text('Comment',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('Actions',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ),
      ],
      rows: _currentPageData.map((transaction) {
        final statusInfo = Constants.getStatusInfo(transaction.bookingStatus);
        return DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: 60,
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
              Text(transaction.name, style: TextStyle(fontSize: 11)),
            ),
            DataCell(
              SizedBox(
                width: 100,
                child: Text(
                  transaction.adventureName,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            DataCell(
              Text(transaction.bookingDate,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
            ),
            DataCell(
              Text(
                'OMR ${transaction.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700]),
              ),
            ),
            DataCell(
              Text(
                'OMR ${transaction.clientRefund.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 11),
              ),
            ),
            DataCell(
              Text(
                'OMR ${transaction.oacAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ),
            DataCell(
              Text(
                'OMR ${transaction.providerAmount.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700]),
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
            DataCell(_buildSettlementChip(transaction.settlementStatus)),
            DataCell(
              SizedBox(
                width: 80,
                child: Text(
                  transaction.settlementComment.isEmpty
                      ? '-'
                      : transaction.settlementComment,
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
        return 4;
      case 'bookingDate':
        return 3;
      case 'providerAmount':
        return 6;
      case 'settlementStatus':
        return 8;
      default:
        return null;
    }
  }

  Widget _buildSettlementChip(String status) {
    Color chipColor;
    String displayStatus;

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
            color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
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
                    ? () => setState(() {
                          _currentPage--;
                        })
                    : null,
              ),
              Text('${_currentPage + 1}/$totalPages',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              IconButton(
                icon: Icon(Icons.chevron_right, size: 20),
                onPressed: _currentPage < totalPages - 1
                    ? () => setState(() {
                          _currentPage++;
                        })
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(ProviderTransaction transaction) {
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
                  Text('Transaction Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop()),
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
                      _buildDetailRow(
                          'Transaction Status', transaction.payStatus),
                      _buildDetailRow('User Name', transaction.name),
                      _buildDetailRow(
                          'Adventure Name', transaction.adventureName),
                      _buildDetailRow('Booking Date', transaction.bookingDate),
                      _buildDetailRow(
                          'Settlement Status',
                          _statusMapping[
                                  transaction.settlementStatus.toLowerCase()] ??
                              transaction.settlementStatus),
                      _buildDetailRow(
                          'Total Paid', 'OMR ${transaction.totalAmount}'),
                      _buildDetailRow('Discounted Amount',
                          'OMR ${transaction.discountedAmount}'),
                      _buildDetailRow(
                          'Refunded Amount', 'OMR ${transaction.clientRefund}'),
                      _buildDetailRow('Provider Amount',
                          'OMR ${transaction.providerAmount}'),
                      _buildDetailRow(
                          'OAC Amount', 'OMR ${transaction.oacAmount}'),
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
              '$label:',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                  fontSize: 12),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
              child: Text(value,
                  style: TextStyle(fontSize: 12, color: Colors.grey[800]))),
        ],
      ),
    );
  }
}
