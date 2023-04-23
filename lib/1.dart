import 'package:flutter/material.dart';

const String sampleText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse euismod ipsum vel magna auctor malesuada. Nullam aliquet sollicitudin est, ac laoreet dolor suscipit vel. Nam imperdiet malesuada mi, ut lobortis tortor varius et. Cras vitae lacus bibendum, rutrum mi vel, lobortis tortor. Aenean sit amet ornare lorem. Maecenas tortor magna, cursus a placerat non, faucibus eu augue.";

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _textController = TextEditingController(text: sampleText);
  final _fontSizeController = TextEditingController(text: '14');
  final _fontColorController = TextEditingController(text: '000000');
  final _backgroundColorController = TextEditingController(text: 'FFFFFF');

  @override
  void dispose() {
    _textController.dispose();
    _fontSizeController.dispose();
    _fontColorController.dispose();
    _backgroundColorController.dispose();
    super.dispose();
  }

  List<String> _getPages(String text, double fontSize, Color fontColor, Color backgroundColor, int pageSize) {
    final textStyle = TextStyle(fontSize: fontSize, color: fontColor);
    List<String> pages = [];
    String pageText = '';
    int pageCount = 0;
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final charSize = TextPainter(text: TextSpan(text: char, style: textStyle), maxLines: 1, textDirection: TextDirection.ltr)
          .size;
      if ((pageText.length + charSize.width) > (pageSize * fontSize)) {
        pages.add(pageText);
        pageText = char;
        pageCount += 1;
      } else {
        pageText += char;
      }
    }
    if (pageText.isNotEmpty) {
      pages.add(pageText);
      pageCount += 1;
    }
    _currentPageNotifier.value = 0;
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentPageNotifier,
                  builder: (BuildContext context, int currentPage, _) {
                    final fontSize = double.tryParse(_fontSizeController.text)
                            ?.clamp(8.0, 50.0) ??
                        14.0;
                    final fontColor = Color(int.tryParse(_fontColorController.text) ?? 0xFF000000);
                    final backgroundColor = Color(int.tryParse(_backgroundColorController.text) ?? 0xFFFFFFFF);
                    final pages = _getPages(sampleText, fontSize, fontColor, backgroundColor, (MediaQuery.of(context).size.width / fontSize).floor());
                    return PageView.builder(
                      itemCount: pages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final pageText = pages[index];
                        return Container(
                          color: backgroundColor,
                          child: Center(
                            child: Text(
                              pageText,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: fontSize, color: fontColor),
                            ),
                          ),
                        );
                      },
                      onPageChanged: (int index) {
                        _currentPageNotifier.value = index;
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Text('Font Size:'),
                  SizedBox(width: 16.0),
                  SizedBox(
                    width: 80.0,
                    child: TextFormField(
                      controller: _fontSizeController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(hintText: '14'),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Text('Font Color:'),
                  SizedBox(width: 16.0),
                  SizedBox(
                    width: 80.0,
                    child: TextFormField(
                      controller: _fontColorController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: InputDecoration(hintText: '000000'),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Text('Background Color:'),
                  SizedBox(width: 16.0),
                  SizedBox(
                    width: 80.0,
                    child: TextFormField(
                      controller: _backgroundColorController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: InputDecoration(hintText: 'FFFFFF'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}