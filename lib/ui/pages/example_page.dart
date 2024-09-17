
import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar Example'),
      ),
      body: Center(
        child: Text('Content of Tab $_currentIndex'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Handle tap on the tab
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tab 0',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tab 2',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Activate a specific tab (e.g., Tab 1) when the button is pressed
          setState(() {
            _currentIndex = 1;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}





// class ExamplePage extends StatefulWidget {
//   const ExamplePage({super.key});

//   @override
//   _ExamplePageState createState() => _ExamplePageState();
// }

// class _ExamplePageState extends State<ExamplePage> {
//   // Dummy data for the page
//   List<String> dataList = List.generate(10, (index) => 'Item $index');

//   Future<void> _refreshPage() async {
//     // Simulate a network request or any asynchronous operation
//     await Future.delayed(Duration(seconds: 2));

//     // Update your data or perform any other actions needed
//     setState(() {
//       // dataList = List.generate(10, (index) => 'Refreshed Item $index');      
//       Navigator.of(context).popAndPushNamed('/example');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Refreshable Page'),
//       ),
//       body: RefreshIndicator(
//         onRefresh: _refreshPage,
//         child: ListView.builder(
//           itemCount: dataList.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(dataList[index]),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }





// class ExamplePage extends StatefulWidget {
//   @override
//   _ExamplePageState createState() => _ExamplePageState();
// }

// class _ExamplePageState extends State<ExamplePage> {
//   // List to store data for each tab
//   List<List<String>> _tabData = [
//     ['Tab 1 Initial Data'],
//     ['Tab 2 Initial Data'],
//     ['Tab 3 Initial Data'],
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('My App'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Tab 1'),
//               Tab(text: 'Tab 2'),
//               Tab(text: 'Tab 3'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildTabContent(0),
//             _buildTabContent(1),
//             _buildTabContent(2),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTabContent(int tabIndex) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         // You can perform your data fetching or refreshing here
//         await _fetchDataForTab(tabIndex);
//       },
//       child: ListView.builder(
//         itemCount: _tabData[tabIndex].length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_tabData[tabIndex][index]),
//           );
//         },
//       ),
//     );
//   }

//   Future<void> _fetchDataForTab(int tabIndex) async {
//     // Simulate fetching data
//     await Future.delayed(Duration(seconds: 2));

//     // Update the state with new data for the specified tab index
//     setState(() {
//       _tabData[tabIndex] = ['Tab ${tabIndex + 1} Updated Data'];
//     });
//   }
// }




// class ExamplePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reloadable Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Reload the page by popping and pushing the route
//             Navigator.of(context).popAndPushNamed('/example');
//           },
//           child: Text('Reload Page'),
//         ),
//       ),
//     );
//   }
// }