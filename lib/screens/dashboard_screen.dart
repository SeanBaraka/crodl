import 'package:crodl/components/default_alert_dialogs.dart';
import 'package:crodl/components/default_button.dart';
import 'package:crodl/constants/colors.dart';
import 'package:crodl/screens/account_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:crodl/services/network_services.dart';

class DashBoardScreen extends StatefulWidget {
  static String routeName = '/dashboard';

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  dynamic leaderPositionResponse,followerPosition;
  bool isLoading, isCopyLoading;

  String responseMessage;

  @override
  void initState() {
    // TODO: implement initState
    isLoading = false;
    isCopyLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Image.asset(
            'assets/images/crodl-logo.png',
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AccountSetup.routeName, (route) => true);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: SvgPicture.asset('assets/icons/settings.svg'),
            ),
          )
        ],
        backgroundColor: bgColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () async {
                        var followerPositions = await getCurrentPositions();

                        setState(() {
                          isLoading = true;
                        });
                        var response = await getLeaderPositions();

                        if (response['status'] == 200) {
                          var leaderPosition = response['leader_position'];

                          setState(() {
                            isLoading = false;
                            leaderPositionResponse = leaderPosition;
                            followerPosition = followerPositions['orderDetails'];
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            isLoading != true
                                ? "Get leader positions"
                                : "Getting Leader Positions... please wait",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: primaryColor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          isLoading != true
                              ? SvgPicture.asset('assets/icons/refresh.svg')
                              : Container(
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: primaryColor,
                                    ),
                                  ),
                                )
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  leaderPositionResponse != null
                      ? Table(
                          defaultColumnWidth: FixedColumnWidth(70),
                          columnWidths: {
                            0: FixedColumnWidth(50),
                            2: FixedColumnWidth(50),
                            4: FixedColumnWidth(45)
                          },
                          children: [
                            TableRow(children: [
                              Container(
                                height: 36,
                                child: Text(
                                  "Side",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text("Symbol",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Text("Lev",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Text("Entry",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Text("Qty",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              Container()
                            ]),
                            buildCrodlTableRow(
                                leaderPosition: leaderPositionResponse, actions: true)
                          ],
                        )
                      : Container(
                          child: Center(
                              child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/note.svg',
                                width: 150,
                              ),
                              Text(
                                'No postions at the moment',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: lightGreyColor,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          )),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "My current Positions",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  followerPosition != null ? Table(
                    defaultColumnWidth: FixedColumnWidth(75),
                    children: [
                      TableRow(children: [
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          margin:
                              EdgeInsets.only(bottom: 5),
                          height: 32,
                          child: Text(
                            "Side",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          margin:
                              EdgeInsets.only(bottom: 5),
                          height: 32,
                          child: Text("Symbol",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          margin:
                          EdgeInsets.only(bottom: 5),
                          height: 32,
                          child: Text("Leverage",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          margin:
                          EdgeInsets.only(bottom: 5),
                          height: 32,
                          child: Text("Entry",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(bottom: 5),
                          alignment: AlignmentDirectional.centerStart,
                          height: 32,
                          child: Text("Qty",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ),
                        Container()
                      ],
                      ),
                      buildCrodlTableRow(leaderPosition: followerPosition, actions: false)
                    ],
                  ) : Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/note.svg', width: 80,),
                            Text("You do not have any positions", style: TextStyle(fontSize:
                            20, fontWeight: FontWeight.bold, color: lightGreyColor),)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  TableRow buildCrodlTableRow({dynamic leaderPosition, bool actions}) {
    final List<dynamic> columns = [
      leaderPosition['side'],
      leaderPosition['symbol'],
      leaderPosition['leverage'],
      leaderPosition['entry_price'].toString(),
      leaderPosition['size']
    ];
    double entryPrice = double.parse(columns[3]);

    return TableRow(children: [
      Container(
        height: 36,
        child: Text(
          columns[0].toString(),
          style: TextStyle(fontSize: 18),
        ),
      ),
      Text(
        columns[1].toString(),
        style: TextStyle(fontSize: 18),
      ),
      Text(
        columns[2].toString(),
        style: TextStyle(fontSize: 18),
      ),
      Text(
        entryPrice.toStringAsFixed(2),
          style: TextStyle(fontSize: 18),
      ),
      Text(
        columns[4].toString(),
        style: TextStyle(fontSize: 18),
      ),
      actions == true ? IconCodlButton(
        isCopyLoading: isCopyLoading,
        onPressed: () async {
          setState(() {
            isCopyLoading = true;
          });

          var positionDetails = {
            "side": columns[0].toString(),
            "symbol": columns[1].toString(),
            "leverage": columns[2].toString()
          };

          var copyResponse = await copyLeaderPosition(positionDetails);
          // a case scenario where the token issued has expired
          if (copyResponse['status'] == 200) {
            if (copyResponse != null) {
              var message = copyResponse['message'];

              if (message != null) {
                var serverResponse = await getCurrentPositions();
                var followerOrders = serverResponse['orderDetails'];
                setState(() {
                  isCopyLoading = false;
                  followerPosition = followerOrders;
                });
                var snackBar = SnackBar(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: primaryColor,
                    duration: Duration(seconds: 5),
                    elevation: 10,
                    content: Text(
                      message,
                      style: TextStyle(fontSize: 18, color: darkColor),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              setState(() {
                isCopyLoading = false;
              });
              var snackBar = SnackBar(
                  backgroundColor: Colors.redAccent,
                  action: SnackBarAction(textColor: darkColor, onPressed: ()=>{},),
                  content: Text("Sorry, network connection could not be established"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else if (copyResponse['status'] == 401) {
              showAlertDialog(context);
          }

          // return SnackBar(content: Text(message));
        },
      ) : Container()
    ]);
  }

}

class IconCodlButton extends StatelessWidget {
  const IconCodlButton({Key key, this.onPressed, this.isCopyLoading})
      : super(key: key);
  final Function onPressed;
  final bool isCopyLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: isCopyLoading != true
          ? Row(
              children: [
                SvgPicture.asset('assets/icons/copy.svg'),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Copy",
                  style: TextStyle(color: primaryColor, fontSize: 16),
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                  ),
                ),
              ],
            ),
    );
  }
}
