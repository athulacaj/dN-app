//  void showSpinnerFunction() {
//    setState(() {
//      _showSpinner = true;
//    });
//    _itemdetails = isAnyContent(widget.details['items'], _whichSubcateogry);
//    if (_itemdetails.length > 0) {
//      String url = _itemdetails[0]['image'];
//      var _image = NetworkImage("$url");
//      _image.resolve(ImageConfiguration()).addListener(ImageStreamListener(
//        (info, call) {
//          setState(() {
//            _showSpinner = false;
//          });
//        },
//      ));
//    } else {
//      setState(() {
//        _showSpinner = false;
//      });
//    }
//  }
