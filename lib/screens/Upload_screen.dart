import 'dart:io';

import 'package:blog_app/Utils/general_utils.dart';
import 'package:blog_app/components/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _image;
  final picker = ImagePicker();
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  FocusNode titlefocusnode = FocusNode();
  FocusNode descrfoucnode = FocusNode();
  final _auth = FirebaseAuth.instance;
  final postref = FirebaseDatabase.instance.ref().child('Posts');
  final storage = FirebaseStorage.instance;

  Future getimagegallery() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      _image = File(pickedfile.path);
    } else {
      GeneralUtils().showerrormessage("No Image found", context);
    }
  }

  Future getcameraimage() async {
    final pickedfile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedfile != null) {
        _image = File(pickedfile.path);
      } else {
        GeneralUtils().showerrormessage("No Image found", context);
      }
    });
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getcameraimage();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Camera"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getimagegallery();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.photo_album_outlined),
                      title: Text("Gallery"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final providerr = Provider.of<GeneralUtils>(context);
    return ModalProgressHUD(
      inAsyncCall: providerr.showspinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Upload Blog'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      dialog(context);
                    },
                    child: Container(
                        height: 150,
                        width: double.infinity,
                        child: _image != null
                            ? ClipRect(
                                child: Image.file(
                                _image!.absolute,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ))
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.grey,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLines: 1,
                          style: const TextStyle(color: Colors.black),
                          controller: titlecontroller,
                          focusNode: titlefocusnode,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE1E1E1))),
                            hintText: "Enter title",
                            labelText: 'Title',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              providerr.progressindic(false);
                              return 'Enter title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          maxLines: 6,
                          style: const TextStyle(color: Colors.black),
                          controller: descriptioncontroller,
                          focusNode: descrfoucnode,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE1E1E1))),
                            hintText: "Enter description",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              providerr.progressindic(false);
                              return 'Enter title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        RoundButtonTwo(
                            title: "Submit",
                            ontap: () async {
                              providerr.progressindic(true);
                              if (_formkey.currentState!.validate()) {
                                if (_image == null) {
                                  // Throw an error or show a message indicating that an image must be uploaded.
                                  GeneralUtils().showerrormessage(
                                      "NO image, please add an image"
                                          .toString(),
                                      context);
                                  providerr.progressindic(false);
                                  return;
                                }

                                int id = DateTime.now().microsecondsSinceEpoch;
                                final storageref = storage.ref('/blogapp$id');
                                UploadTask uploadTask =
                                    storageref.putFile(_image!.absolute);
                                await Future.value(uploadTask);
                                var newurl = await storageref.getDownloadURL();
                                final User? user = _auth.currentUser;

                                postref
                                    .child("post list")
                                    .child(id.toString())
                                    .set({
                                  'id': id,
                                  'title': titlecontroller.text.toString(),
                                  'description':
                                      descriptioncontroller.text.toString(),
                                  'image': newurl.toString(),
                                  'date': id.toString(),
                                  'Uemail': user!.email,
                                  'Uid': _auth.currentUser!.uid,
                                }).then((value) {
                                  GeneralUtils().successfulmessage(
                                      'Post Uploaded', context);
                                  providerr.progressindic(false);
                                }).onError((error, stackTrace) {
                                  GeneralUtils().showerrormessage(
                                      error.toString(), context);
                                  providerr.progressindic(false);
                                });
                              }
                            })
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
