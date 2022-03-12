import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE5B2CA),
              Color(0xFFCD82DE)
            ],
          ),
        ),
        child: Text(
            """These terms of use (the "Terms of Use") govern your use of our Mobile application.. Please read these Terms of Use carefully before you use the services. If you do not agree to these Terms of Use, you may not use the services on the Platform, and we request you to uninstall the App. The Platform is owned and operated by Team Hustler For the purpose of these Terms of Use, wherever the context so requires, "you", “user”, or “User” shall mean any natural or legal person who shall transaction on the Platform by providing registration data while registering on the Platform as a registered user using any computer systems. The terms "Food Yodha", "we", "us" or "our" shall mean Team Hustlers. Food Yodha enables transactions on its Platform between participating restaurants/merchants and buyers, dealing in (a) prepared food and beverages, (b) consumer goods, and (c) other products and services ("Platform Services"). The food distributed shall be the responsibility of the concerned organisation Food Yodha enables delivery of such Orders or completion of Tasks at select localities of serviceable cities across India ("Delivery Services") by connecting third party service providers i.e. pick-up and delivery partners (“PDP”) who will be responsible for providing the pick-up and delivery services and completing Tasks initiated by the users of the Platform (Buyers or Merchants). The Platform Services and Delivery Services are collectively referred to as "Services". For both Platform Services and Delivery Services, is merely acting as an intermediary between the Merchants and Buyers and/or PDPs and Buyers/Merchants. PDPs are individual entrepreneurs engaged with Food Yodha on a voluntary, non-exclusive and principal to principal basis to provide aforementioned services for service fee. PDPs are independent contractors and are free to determine their timings of work. Food Yodha does not exercise control on the PDPs and the relationship between the PDPs and Food Yodha is not that of an agent and principal or employee and employer. For the pickup and delivery services and completing the Tasks, PDPs may charge the users of the Platform (Buyers or Merchants), a service fee (inclusive of applicable taxes whenever not expressly mentioned) determined on the basis of various factors including but not limited to distance covered, time taken, demand for delivery services/Tasks, real time analysis of traffic and weather conditions, seasonal peaks or such other parameters as may be determined from time to time."""),
      ),
    );
  }
}
