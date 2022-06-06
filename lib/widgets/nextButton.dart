library material_buttonx;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class materialButtonX extends StatelessWidget {
  final String message;
  bool loading;
  final IconData icon;
  final VoidCallback onClick;

  materialButtonX(
      {Key? key,
      required this.message,
      required this.icon,
      required this.onClick,
      required this.loading})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 20.0),
              blurRadius: 30.0,
              color: Colors.black12,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              height: 50.0,
              width: 115.0,
              child: Center(
                child: loading
                    ? Center(
                        child: Container(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      )
                    : FittedBox(
                        child: Text(message,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w700)),
                      ),
              ),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80.0),
                      topLeft: Radius.circular(80.0),
                      bottomRight: Radius.circular(80.0),
                      topRight: Radius.circular(80))),
            ),
            Icon(
              icon,
              size: 25.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
