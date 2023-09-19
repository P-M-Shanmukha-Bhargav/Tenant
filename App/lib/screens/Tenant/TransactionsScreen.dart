import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionsScreen();
}

class _TransactionsScreen extends State<TransactionsScreen> {
  var titleOnCenterAfterExpansion = false;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: false,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            shrinkWrap: true,
            primary: false,
            slivers: [
              SliverFillRemaining(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          title: const Text("Transactions",
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.grey,
                                fontWeight: FontWeight.w200,
                              )),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return ExpansionTile(
                                title: titleOnCenterAfterExpansion ? const Center(
                                  child: Text("Jan - 2023"),
                                ): const Text("Jan - 2023"),
                                initiallyExpanded: false,
                                onExpansionChanged: (expanded){
                                  setState(() {
                                    titleOnCenterAfterExpansion = expanded;
                                  });
                                },
                                trailing: const Text("Paid",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    )
                                ),
                                children: [
                                  ListView(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    children: [
                                      ListTile(
                                          title: const Text("Rent Amount: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w200,
                                              )),
                                          trailing:
                                          Text("\u{20B9} 50.00".toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                      ListTile(
                                          title: const Text("Maintenance Amount",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w200,
                                              )),
                                          trailing:
                                          Text("\u{20B9} 10.00".toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                      ListTile(
                                          title: const Text("Power Amount: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w200,
                                              )),
                                          trailing:
                                          Text("\u{20B9} 10.00".toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                      ListTile(
                                          title: const Text("Water Amount: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w200,
                                              )),
                                          trailing:
                                          Text("\u{20B9} 10.00".toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                      ListTile(
                                          title: const Text("Previous Amount: ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w200,
                                              )),
                                          trailing:
                                          Text("\u{20B9} 20.00".toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                      ListTile(
                                          title: Row(
                                            children: [
                                              const Text("Total: ",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w200,
                                                  )),
                                              Text("\u{20B9} 100.00".toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ))
                                            ],
                                          ),
                                          trailing: const Text("Pending!!",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                              ))
                                      )
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
