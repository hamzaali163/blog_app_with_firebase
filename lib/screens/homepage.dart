import 'package:blog_app/Utils/route_names.dart';
import 'package:blog_app/components/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbref = FirebaseDatabase.instance.ref('Posts');
  final _auth = FirebaseAuth.instance;
  final searchcontroller = TextEditingController();
  String search = "";
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'New Blogs',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            InkWell(
                onTap: () async {
                  await GoogleSignIn().signOut();
                  await _auth.signOut().then((value) {
                    Navigator.pushNamed(context, RoutesNames.mainScreen);
                  });
                },
                child: const Icon(
                  Icons.logout_outlined,
                  color: AppColors.whitecolor,
                )),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: searchcontroller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE1E1E1))),
                  hintText: "Search with blog title",
                ),
                onChanged: (value) {
                  setState(() {
                    value = search;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: FirebaseAnimatedList(
                      query: dbref.child('post list'),
                      itemBuilder: (((context, snapshot, animation, index) {
                        final temptitle =
                            snapshot.child('title').value.toString();

                        if (searchcontroller.text.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.assetNetwork(
                                    // height: 100,
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                    placeholder: 'images/loading.jpg',
                                    image: snapshot
                                        .child('image')
                                        .value
                                        .toString()),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                snapshot.child('title').value.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.child('description').value.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          );
                        } else if (temptitle
                            .toLowerCase()
                            .contains(searchcontroller.text.toLowerCase())) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.assetNetwork(
                                    // height: 100,
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                    placeholder: 'images/loading.jpg',
                                    image: snapshot
                                        .child('image')
                                        .value
                                        .toString()),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                snapshot.child('title').value.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.child('description').value.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }))))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.mainColor,
          onPressed: () {
            Navigator.pushNamed(context, RoutesNames.uploadScreen);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
