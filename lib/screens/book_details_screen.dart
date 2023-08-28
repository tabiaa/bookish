import 'package:flutter/material.dart';
import 'pdf_screen.dart';
import 'package:flutter_app/commons/reusable_button.dart';

class BookDetailsScreen extends StatefulWidget {
  final String? description;
  final String? title;
  final String? pdf;
  final bool? isPDFAvailable;
  final String? img;
  final List<dynamic>? author;

  const BookDetailsScreen(
      {super.key,
      required this.img,
      required this.pdf,
      required this.isPDFAvailable,
      required this.description,
      required this.title,
      required this.author});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xffC29E86),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: 220,
              color: Color(0xffC29E86),
              child: Container(child: Image.network("${widget.img}")),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "${widget.title}",
                style: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff795C4B),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "By ${widget.author?.join(', ')}",
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 16,
                  color: Color.fromARGB(255, 158, 119, 96),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Description:",
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 158, 119, 96),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
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
                child: Text(
                  "${widget.description}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ReusableButton(
                buttonText: 'View as PDF',
                onPressed: () {
                  widget.isPDFAvailable == true
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFViewer(
                              pdfUrl: widget.pdf,
                            ),
                          ),
                        )
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('No Book Found'),
                              content: Text('This book is not available!'),
                            );
                          },
                        );
                  ;

                  // _launchURL("${widget.pdf}")
                },
                bgColor: Color(0xff795C4B),
                txtColor: Color(0xffC29E86),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
