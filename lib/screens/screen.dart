import 'package:flutter/material.dart';
import 'package:quran/model/model.dart';
import 'package:quran/services.dart';
import 'package:quran/widgets/drawer.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int surahno = 1;
  String nameofsurah = '';
  List<Result>? _dataList;
  final services service = services();

  @override
  void initState() {
    super.initState();

    fetchdata(surahno);
  }

  fetchdata(int surahno) async {
    _dataList = await service.fetchData(surahno);
    setState(() {});
  }

  void _updateSuraNumber(String value) {
    final suraNumber = int.tryParse(value);
    if (suraNumber != null) {
      setState(() {
        surahno = suraNumber;
        fetchdata(surahno);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[200],
        child: Expanded(
          child: ListView.builder(
            itemCount: Global.surahNames.length,
            itemBuilder: (context, index) {
              var getnames = Global.surahNames;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      setState(() {
                        surahno = index + 1;

                        nameofsurah = getnames[index].toString();
                        fetchdata(surahno);
                      });
                      Navigator.pop(context);
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("(${(index + 1)})"),
                        Flexible(
                          child: Text(
                            getnames[index].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: _dataList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Text(
                  nameofsurah,
                  style:
                      const TextStyle(fontFamily: 'ArabicFont', fontSize: 20),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _dataList!.length,
                    itemBuilder: (context, index) {
                      final data = _dataList![index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Column(
                          children: [
                            Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey[400],
                            ),
                            Text(
                              "(${data.aya})",
                              style: const TextStyle(
                                  fontFamily: 'ArabicFont', fontSize: 20),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      data.arabicText ?? '',
                                      style: const TextStyle(
                                          fontFamily: 'ArabicFont',
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                    'fonts/stop.png',
                                  ))),
                                  child: Center(
                                      child: Text(
                                    data.aya.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'ArabicFont', fontSize: 10),
                                  )),
                                ),
                              ],
                            ),
                            Text(
                              data.translation ?? '',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
