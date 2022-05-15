import 'dart:io';

import 'package:best_beer_ranking/data/model/user.dart';
import 'package:best_beer_ranking/data/repository/user_repository.dart';
import 'package:best_beer_ranking/utils/image_utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final myPageViewModelProvider =
    ChangeNotifierProvider((ref) => MyPageViewModel(ref.read));

enum MyPageType { None, ShowLogin, ShowUser }

class MyPageViewModel extends ChangeNotifier {

  MyPageViewModel(this._reader);

  late final _userRepository = _reader(userRepositoryProvider);
  final imagePicker = ImagePicker();

  final Reader _reader;
  User? _user;
  User? get user => _user;

  String _name = "";
  String get name => _name;

  File? _imageFile;

  MyPageType _myPageDisplayType = MyPageType.None;
  MyPageType? get myPageDisplayType => _myPageDisplayType;

  Future<void> checkAccount() async {
    final auth = firebase_auth.FirebaseAuth.instance.currentUser;
    if (auth == null) {
      _myPageDisplayType = MyPageType.ShowLogin;
      notifyListeners();
      return;
    }
    _user = await _userRepository.getUser(auth.uid);
    if (_user != null) {
      _myPageDisplayType = MyPageType.ShowUser;
    } else {
      _myPageDisplayType = MyPageType.ShowLogin;
    }
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    final googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount == null) {
      print("Sign in with Google failed");
      return;
    }
    final googleAuth = await googleAccount.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _signInWithFirebase(credential);

    final auth = firebase_auth.FirebaseAuth.instance;
    _user = await _userRepository.getUser(auth.currentUser!.uid);
    if (_user == null) {
      _user = await _userRepository.updateUser(id: auth.currentUser!.uid);
    }
    await checkAccount();
  }

  Future<void> loginWithApple(BuildContext context) async {
    try {
      final appleId = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );
      final oauthProvider = firebase_auth.OAuthProvider('apple.com');
      final credential = oauthProvider.credential(
        idToken: appleId.identityToken,
      );
      await _signInWithFirebase(credential);

      final auth = firebase_auth.FirebaseAuth.instance;
      _user = await _userRepository.getUser(auth.currentUser!.uid);
      if (_user == null) {
        _user = await _userRepository.updateUser(id: auth.currentUser!.uid);
      }
      await checkAccount();

      notifyListeners();
    } on SignInWithAppleException catch (e) {
      print("Sign in with Apple failed : ${e}");
    }
  }

  Future<String> _signInWithFirebase(firebase_auth.AuthCredential credential) async {
    final auth = firebase_auth.FirebaseAuth.instance;
    final u = auth.currentUser;
    final userCredential = await auth.signInWithCredential(credential);
    final idToken = await userCredential.user!.getIdToken();
    return idToken;
  }

  Future<void> updateUserName(String name) async {
    final auth = firebase_auth.FirebaseAuth.instance;
    _user = await _userRepository.updateUser(
        id: auth.currentUser!.uid,
        name : name,
        description: _user?.description ?? "",
        photoUrl : _user?.photoUrl ?? "");
    notifyListeners();
  }

  Future<void> updateUserProfile(String url) async {
    final auth = firebase_auth.FirebaseAuth.instance;
    _user = await _userRepository.updateUser(
        id: auth.currentUser!.uid,
        name: _user?.name ?? "",
        description: _user?.description ?? "",
        photoUrl : url);
    notifyListeners();
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile == null) return;
    _imageFile = await ImageUtils.cropImage(pickedFile.path);
    final auth = firebase_auth.FirebaseAuth.instance;
    // auth.currentUser?.getIdToken().whenComplete(() => {
    //   uploadFile(auth.currentUser!.uid)
    // });
    uploadFile(auth.currentUser!.uid);
    notifyListeners();
  }

  Future<void> uploadFile(String uploadFileName) async{
    final FirebaseStorage storage = FirebaseStorage.instance;
    try{
      final task = await storage.ref("user/${uploadFileName}.png").putFile(_imageFile!);
      final url = await task.ref.getDownloadURL();
      updateUserProfile(url);
    } catch(FirebaseException){
      //エラー処理
      print("FirebaseException : ${FirebaseException.toString()}");
    }
  }

}
