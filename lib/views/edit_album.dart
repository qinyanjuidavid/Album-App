import 'package:crudapp/controllers/album_providers.dart';
import 'package:crudapp/models/album_model.dart';
import 'package:crudapp/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAlbumPage extends StatefulWidget {
  final Album album;
  EditAlbumPage({Key? key, required this.album}) : super(key: key);

  @override
  State<EditAlbumPage> createState() => _EditAlbumPageState();
}

class _EditAlbumPageState extends State<EditAlbumPage> {
  final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textController.text = widget.album.title!;
    // print("Album ID: ${widget.}");
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<AlbumProvider>(context, listen: false);

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
              "Edit Album",
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
                  key: _updateFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        autofocus: false,
                        controller: _textController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          _textController.text = value!;
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
                              if (_updateFormKey.currentState!.validate()) {
                                _updateFormKey.currentState!.save();
                                _controller.updateAlbumProvider(
                                    _textController.text, 1);
                                Navigator.pop(context);
                              }
                            },
                            // _textController.text,
                            // widget.albumId,
                            fillColor: Colors.green[900],
                            elevation: 5,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              "Update Album",
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _controller.deleteAlbumProvider(widget.album.id!);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyHomeScreen();
            }));
          },
          child: Icon(
            Icons.delete,
            size: 20,
          ),
        ),
      ),
    );
  }
}
