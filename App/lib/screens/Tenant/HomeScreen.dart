import 'package:flutter/material.dart';
import 'package:houseapp/screens/Tenant/TransactionsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with RestorationMixin{
  final RestorableBool _displayBanner = RestorableBool(true);

  @override
  String? get restorationId => "display_banner";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_displayBanner, 'display_banner');
  }

  @override
  Widget build(BuildContext context) {

    final banner = MaterialBanner(
      content: const Text("Checking"),
      leading: const CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(Icons.access_alarm, color: Colors.blueAccent),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              _displayBanner.value = false;
            });
          },
          child: const Text("Dismiss"),
        ),
      ],
    );

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(25),
              child: SizedBox(
                height: 250,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: Text("Card"),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text("Total Amount: ",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: const Text("\u{20B9} 100.00", style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
              )),
              trailing: ElevatedButton.icon(
                onPressed: () => {
                  print("Payment")
                },
                label: const Text("Pay Now"),
                icon: const Icon(Icons.payments),
              ),
            ),
            const ListTile(
              title: Text("Rent", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
              )),
              trailing: Text("\u{20B9} 50.00", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              leading: Icon(Icons.meeting_room, size: 25),
              minLeadingWidth: 1,
            ),
            const ListTile(
              title: Text("Power Bill", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
              )),
              trailing: Text("\u{20B9} 10.00", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              leading: Icon(Icons.power, size: 25),
              minLeadingWidth: 1,
            ),
            const ListTile(
              title: Text("Water Bill", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
              )),
              trailing: Text("\u{20B9} 10.00", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              leading: Icon(Icons.water_drop, size: 25),
              minLeadingWidth: 1,
            ),
            const ListTile(
              title: Text("Maintenance Bill", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
              )),
              trailing: Text("\u{20B9} 10.00", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              leading: Icon(Icons.lightbulb, size: 25),
              minLeadingWidth: 1,
            ),
            const ListTile(
              title: Text("Pending Bill", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
              )),
              trailing: Text("\u{20B9} 20.00", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              leading: Icon(Icons.pending_actions, size: 25),
              minLeadingWidth: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransactionsScreen(),
                          fullscreenDialog: true,
                        )
                    )
                  },
                  child: const Text("Previous Transactions"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}