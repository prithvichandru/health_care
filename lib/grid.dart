import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';

class Users {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;

  Users({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Users> userList = [];
  List<ExpandableRow> filteredRows = [];
  List<ExpandableRow> uptRows = [];
  List<Users> _filteredData = [];

  late List<ExpandableColumn<dynamic>> headers;
  bool _isLoading = true;


  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSampleData();
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void loadSampleData() {
    userList = [
      Users(id: 1, firstName: 'm', lastName: 'Doe', maidenName: 'Smith', age: 25, gender: 'Male', email: 'john@example.com'),
      Users(id: 2, firstName: 'Jane', lastName: 'Smith', maidenName: 'new', age: 30, gender: 'Female', email: 'jane@example.com'),
      // Add more sample users...
    ];

    createDataSource();
    setLoading(false);
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "First name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Last name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Maiden name", columnFlex: 2),
      ExpandableColumn<int>(columnTitle: "Age", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "Gender", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "Email", columnFlex: 4),
    ];

    updateFilteredRows();
  }

  void updateFilteredRows() {
    if(_filteredData.isNotEmpty){
      print('not empty'); 
      uptRows = _filteredData.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<int>(columnTitle: "ID", value: e.id),
        ExpandableCell<String>(columnTitle: "First name", value: e.firstName),
        ExpandableCell<String>(columnTitle: "Last name", value: e.lastName),
        ExpandableCell<String>(columnTitle: "Maiden name", value: e.maidenName),
        ExpandableCell<int>(columnTitle: "Age", value: e.age),
        ExpandableCell<String>(columnTitle: "Gender", value: e.gender),
        ExpandableCell<String>(columnTitle: "Email", value: e.email),
      ]);
    }).toList();
    }else{
      print('empty');
filteredRows = userList.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<int>(columnTitle: "ID", value: e.id),
        ExpandableCell<String>(columnTitle: "First name", value: e.firstName),
        ExpandableCell<String>(columnTitle: "Last name", value: e.lastName),
        ExpandableCell<String>(columnTitle: "Maiden name", value: e.maidenName),
        ExpandableCell<int>(columnTitle: "Age", value: e.age),
        ExpandableCell<String>(columnTitle: "Gender", value: e.gender),
        ExpandableCell<String>(columnTitle: "Email", value: e.email),
      ]);
    }).toList();
    }
    
  }

   onSearch(String searchQuery) {
  setState(() {
    if (searchQuery.isNotEmpty) {
      _filteredData = userList.where((element) {
        return element.firstName
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
      }).toList();
    } else {
      _filteredData = List.from(userList);
    }
    createDataSource();
  });
}
  
  @override
  Widget build(BuildContext context) {

    print('Building UI'); 
    print(uptRows.length);
    print(uptRows.isNotEmpty);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      onSearch('');
                    },
                  ),
                ),
                onChanged: onSearch,
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : LayoutBuilder(builder: (context, constraints) {
                      int visibleCount = 3;
                      if (constraints.maxWidth < 600) {
                        visibleCount = 3;
                      } else if (constraints.maxWidth < 800) {
                        visibleCount = 4;
                      } else if (constraints.maxWidth < 1000) {
                        visibleCount = 5;
                      } else {
                        visibleCount = 6;
                      }

                      return ExpandableTheme(
                        
                        data: ExpandableThemeData(
                          context,
                          contentPadding: const EdgeInsets.all(20),
                          expandedBorderColor: Colors.transparent,
                          paginationSize: 48,
                          headerHeight: 56,
                          headerColor: Colors.amber[400],
                          headerBorder: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          evenRowColor: const Color(0xFFFFFFFF),
                          oddRowColor: Colors.amber[200],
                          rowBorder: const BorderSide(
                            color: Colors.black,
                            width: 0.3,
                          ),
                          rowColor: Colors.green,
                          headerTextMaxLines: 4,
                          headerSortIconColor: const Color(0xFF6c59cf),
                          paginationSelectedFillColor: const Color(0xFF6c59cf),
                          paginationSelectedTextColor: Colors.white,
                        ),
                        child: ExpandableDataTable(
                          
                          headers: headers,
                          rows: uptRows.isNotEmpty ? uptRows : filteredRows,
                          multipleExpansion: false,
                          isEditable: false,
                          visibleColumnCount: visibleCount,
                        ),
                      );
                    }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditDialog(
      ExpandableRow row, Function(ExpandableRow) onSuccess) {
    return AlertDialog(
      title: SizedBox(
        height: 300,
        child: TextButton(
          child: const Text("Change name"),
          onPressed: () {
            row.cells[1].value = "x3";
            onSuccess(row);
          },
        ),
      ),
    );
  }
}