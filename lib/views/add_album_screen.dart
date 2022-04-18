import 'package:crudapp/controllers/album_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAlbumScreen extends StatefulWidget {
  const AddAlbumScreen({Key? key}) : super(key: key);

  @override
  State<AddAlbumScreen> createState() => _AddAlbumScreenState();
}

class _AddAlbumScreenState extends State<AddAlbumScreen> {
  final GlobalKey<FormState> createFormKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createProv = Provider.of<AlbumProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Add Album",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: createFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        autofocus: false,
                        controller: textController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          textController.text = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter album name";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: RawMaterialButton(
                            onPressed: () {
                              if (createFormKey.currentState!.validate()) {
                                createFormKey.currentState!.save();
                                createProv
                                    .createAlbumProvider(textController.text);
                                Navigator.pop(context);
                              }
                            },
                            fillColor: Colors.green[900],
                            elevation: 5,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              "Add Album",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
