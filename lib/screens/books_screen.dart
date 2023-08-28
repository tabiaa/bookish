import 'package:flutter/material.dart';
import 'package:flutter_app/commons/reusable_button.dart';
import 'package:dio/dio.dart';
import 'book_details_screen.dart';
import 'package:flutter_app/commons/reusable_drawer.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({
    super.key,
  });
  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  var jsonList;
  List<dynamic> bookPDFLink = [
    'https://thebookshelfbeforeme.files.wordpress.com/2020/04/fantastic-beasts-and-where-to-find-them-by-j.k.-rowling.pdf',
    'https://content.e-bookshelf.de/media/reading/L-576519-7583327fa1.pdf',
    '',
    '',
    'https://content.e-bookshelf.de/media/reading/L-576519-7583327fa1.pdf',
    'https://vidyaprabodhinicollege.edu.in/VPCCECM/ebooks/ENGLISH%20LITERATURE/Harry%20potter/(Book%207)%20Harry%20Potter%20And%20The%20Deathly%20Hallows.pdf',
    'https://kvdrdolibrary.files.wordpress.com/2021/08/harry_potter_and_the_cursed_child.pdf',
    '',
    '',
    'https://docenti.unimc.it/antonella.pascali/teaching/2018/19055/files/ultima-lezione/harry-potter-and-the-philosophers-stone'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await Dio()
          .get('https://www.googleapis.com/books/v1/volumes?q=harry+potter');
      if (response.statusCode == 200) {
        setState(() {
          jsonList =
              (response.data['items'] as List).cast<Map<String, dynamic>>();
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Welcome",
          style: TextStyle(
              letterSpacing: 8,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xffC29E86)),
        ),
      ),
      drawer: ReusableDrawer(),
      body: Container(
        child: ListView.builder(
          itemCount: jsonList == null ? 0 : jsonList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 53, 37, 28).withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Color(0xffC29E86),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 5, top: 2, right: 12, left: 5),
                      child: Image.network(
                        jsonList[index]['volumeInfo']['imageLinks']
                                ['thumbnail'] ??
                            'https://www.libertybooks.com/image/cache/catalog/9781408855652-640x996.jpg?q6',
                        width: 100,
                      ),
                    ),
                    Flexible(
                      child: Container(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                jsonList[index]['volumeInfo']['title'] ??
                                    'No Title Available',
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color(0xff795C4B),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                (jsonList[index]['volumeInfo']['authors']
                                        as List<dynamic>)
                                    .join(', ')
                                    .toString(),
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 156, 122, 102),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              height: 40,
                              child: ReusableButton(
                                buttonText: 'Description',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookDetailsScreen(
                                        description: jsonList[index]
                                                ['volumeInfo']['description'] ??
                                            'no des',
                                        title: jsonList[index]['volumeInfo']
                                            ['title'],
                                        author: (jsonList[index]['volumeInfo']
                                            ['authors'] as List<dynamic>),
                                        pdf: (bookPDFLink[index] == ''
                                            ? ''
                                            : bookPDFLink[index]),
                                        isPDFAvailable:
                                            (bookPDFLink[index] == ''
                                                ? false
                                                : true),
                                        img: jsonList[index]['volumeInfo']
                                                ['imageLinks']['thumbnail'] ??
                                            'https://www.libertybooks.com/image/cache/catalog/9781408855652-640x996.jpg?q6',
                                      ),
                                    ),
                                  );
                                },
                                bgColor: Color(0xff795C4B),
                                txtColor: Color(0xffC29E86),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
