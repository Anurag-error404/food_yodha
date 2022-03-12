// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class Auth {
//   final firestore = FirebaseFirestore.instance;
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final googleSignIn = GoogleSignIn();

//   bool newUser = false;
//   bool authenticatedUser = false;

//   Future<bool> emailLogin(email, password) async {
//     try {
//       final User? user =
//           (await auth.signInWithEmailAndPassword(
//                   email: email,
//                   password: password))
//               .user;

//       if (user!.uid.isNotEmpty) {
//         // ** Navigate to HomeScren
//         authenticatedUser = true;
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<bool> signUpWithMail(
//       email, password) async {
//     try {
//       final User? user = (await auth
//               .createUserWithEmailAndPassword(
//                   email: email,
//                   password: password))
//           .user;

//       if (user!.uid.isNotEmpty) {
//         // ** Navigate to WelcomeScreen
//         newUser = true;
//         authenticatedUser = true;
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<bool> loginGoogle() async {
//     User user;
//     final GoogleSignInAccount?
//         googleSignInAccount =
//         await googleSignIn.signIn();
//     try {
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication
//             googleSignInAuthentication =
//             await googleSignInAccount
//                 .authentication;

//         final AuthCredential credential =
//             GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication
//               .accessToken,
//           idToken:
//               googleSignInAuthentication.idToken,
//         );

//         try {
//           final UserCredential userCredential =
//               await auth.signInWithCredential(
//                   credential);

//           user = userCredential.user!;

//           // ignore: avoid_print
//           print(
//               "name =============== ${user.displayName}");
//           // ignore: avoid_print
//           print(
//               "uid =============== ${user.uid.toString()}");

//           if (userCredential
//               .additionalUserInfo!.isNewUser) {
//             // ** Navigate to WelcomeScreen
//             newUser = true;
//             authenticatedUser = true;
//           } else {
//             // **Navigate to HomeScreen
//             newUser = false;
//             authenticatedUser = true;
//           }
//           return authenticatedUser;
//         } on FirebaseAuthException catch (e) {
//           print(e);
//           return false;
//         }
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<bool> logout() async {
//     final GoogleSignIn googleSignIn =
//         GoogleSignIn();

//     try {
//       GoogleSignIn().disconnect();
//       googleSignIn.signOut();
//       auth.signOut();

//       authenticatedUser = false;
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }
