import 'package:flutter/material.dart';

class SelectionModal extends StatefulWidget {
  @override
  _SelectionModalState createState() => _SelectionModalState();

  final List dataSource;
  final List values;
  final bool filterable;
  final String textField;
  final String valueField;
  final String title;
  final int maxLength;
  final Color buttonBarColor;
  final String cancelButtonText;
  final IconData cancelButtonIcon;
  final Color cancelButtonColor;
  final Color cancelButtonTextColor;
  final String saveButtonText;
  final IconData saveButtonIcon;
  final Color saveButtonColor;
  final Color saveButtonTextColor;
  final String clearButtonText;
  final IconData clearButtonIcon;
  final Color clearButtonColor;
  final Color clearButtonTextColor;
  final String deleteButtonTooltipText;
  final IconData deleteIcon;
  final Color deleteIconColor;
  final Color selectedOptionsBoxColor;
  final String selectedOptionsInfoText;
  final Color selectedOptionsInfoTextColor;
  final IconData checkedIcon;
  final IconData uncheckedIcon;
  final Color checkBoxColor;
  final Color searchBoxColor;
  final String searchBoxHintText;
  final Color searchBoxFillColor;
  final IconData searchBoxIcon;
  final String searchBoxToolTipText;
  SelectionModal(
      {this.filterable,
        this.dataSource,
        this.title = 'Please select one or more option(s)',
        this.values,
        this.textField,
        this.valueField,
        this.maxLength,
        this.buttonBarColor,
        this.cancelButtonText,
        this.cancelButtonIcon,
        this.cancelButtonColor,
        this.cancelButtonTextColor,
        this.saveButtonText,
        this.saveButtonIcon,
        this.saveButtonColor,
        this.saveButtonTextColor,
        this.clearButtonText,
        this.clearButtonIcon,
        this.clearButtonColor,
        this.clearButtonTextColor,
        this.deleteButtonTooltipText,
        this.deleteIcon,
        this.deleteIconColor,
        this.selectedOptionsBoxColor,
        this.selectedOptionsInfoText,
        this.selectedOptionsInfoTextColor,
        this.checkedIcon,
        this.uncheckedIcon,
        this.checkBoxColor,
        this.searchBoxColor,
        this.searchBoxHintText,
        this.searchBoxFillColor,
        this.searchBoxIcon,
        this.searchBoxToolTipText})
      : super();
}

class _SelectionModalState extends State<SelectionModal> {
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;

  List _localDataSourceWithState = [];
  List _searchresult = [];

  _SelectionModalState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.dataSource.forEach((item) {
      var newItem = {
        'value': item[widget.valueField],
        'text': item[widget.textField],
        'checked': widget.values.contains(item[widget.valueField])
      };
      _localDataSourceWithState.add(newItem);
    });

    _searchresult = List.from(_localDataSourceWithState);
    _isSearching = false;
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF6F35A5),
      leading: Container(
      ),
      elevation: 0.0,
      title: Text(widget.title, style: TextStyle(fontSize: 20.0,
        fontFamily: 'Comfortaa',
      )),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.close,
            size: 26.0,
          ),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
            widget.filterable ? _buildSearchText() : Color(0xFF6F35A5),

          Expanded(
            child: _optionsList(),
          ),
          _currentlySelectedOptions(),
          Container(
            color: widget.buttonBarColor ?? Color(0xFFF1E6FF),
            child: ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ButtonTheme(
                    height: 50.0,
                    child: RaisedButton.icon(
                      label: Text(widget.cancelButtonText ?? 'Cancel'),
                      icon: Icon(
                        widget.cancelButtonIcon ?? Icons.clear,
                        size: 20.0,
                      ),
                      color: widget.cancelButtonColor ?? Color(0xFF6F35A5),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                    ),
                  ),
                  ButtonTheme(
                    height: 50.0,
                    child: RaisedButton.icon(
                      label: Text(widget.clearButtonText ?? 'Clear All'),
                      icon: Icon(
                        widget.clearButtonIcon ?? Icons.clear,
                        size: 20.0,
                      ),
                      color: widget.clearButtonColor ?? Color(0xFF6F35A5) ,
                      textColor: Colors.white,
                      onPressed: () {
                        _clearSelection();
                      },
                    ),
                  ),
                  ButtonTheme(
                    height: 50.0,
                    child: RaisedButton.icon(
                      label: Text(widget.saveButtonText ?? 'Save'),
                      icon: Icon(
                        widget.saveButtonIcon ?? Icons.save,
                        size: 20.0,
                      ),
                      color: Color(0xFF6F35A5) ??
                          Theme.of(context).primaryColor,
                      textColor: widget.saveButtonTextColor ?? Colors.white,
                      onPressed: _localDataSourceWithState
                          .where((item) => item['checked'])
                          .length >
                          widget.maxLength
                          ? null
                          : () {
                        var selectedValuesObjectList =
                        _localDataSourceWithState
                            .where((item) => item['checked'])
                            .toList();
                        var selectedValues = [];
                        selectedValuesObjectList.forEach((item) {
                          selectedValues.add(item['value']);
                        });
                        Navigator.pop(context, selectedValues);
                      },
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }

  Widget _currentlySelectedOptions() {
    List<Widget> selectedOptions = [];

    var selectedValuesObjectList =
    _localDataSourceWithState.where((item) => item['checked']).toList();
    var selectedValues = [];
    selectedValuesObjectList.forEach((item) {
      selectedValues.add(item['value']);
    });
    selectedValues.forEach((item) {
      var existingItem = _localDataSourceWithState
          .singleWhere((itm) => itm['value'] == item, orElse: () => null);
      selectedOptions.add(Chip(
        label: new Container(
          constraints: new BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 80.0),
          child: Text(existingItem['text'], overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: 'Comfortaa',
            ),
          ),
        ),
        deleteButtonTooltipMessage:
        widget.deleteButtonTooltipText ?? 'Tap to delete this item',
        deleteIcon: widget.deleteIcon ?? Icon(Icons.cancel),
        deleteIconColor: widget.deleteIconColor ?? Color(0xFF6F35A5),
        onDeleted: () {
          existingItem['checked'] = false;
          setState(() {});
        },
      ));
    });
    return selectedOptions.length > 0
        ? Container(
      padding: EdgeInsets.all(10.0),
      color: widget.selectedOptionsBoxColor ?? Color(0xFFF1E6FF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Text(
            widget.selectedOptionsInfoText ??
                'Currently selected ${selectedOptions.length} items (tap to remove)', // use languageService here
            style: TextStyle(
                color:
                widget.selectedOptionsInfoTextColor ?? Colors.black,
                fontSize: 15.0,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold),
          ),
          ConstrainedBox(
              constraints: new BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 8,
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 0.4, // gap between lines
                      alignment: WrapAlignment.start,
                      children: selectedOptions,
                    )),
              )),
        ],
      ),
    )
        : new Container();
  }

  ListView _optionsList() {
    List<Widget> options = [];
    _searchresult.forEach((item) {
      options.add(ListTile(
          selected: true,
          title: Text(item['text'] ?? '',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Comfortaa',
            fontSize: 20.0,
          ),),
          leading: Transform.scale(
            child: Icon(
                item['checked']
                    ? widget.checkedIcon ?? Icons.check_box
                    : widget.uncheckedIcon ?? Icons.check_box_outline_blank,
                color: Color(0xFF6F35A5) ?? Theme.of(context).primaryColor),
            scale: 1.5,
          ),
          onTap: () {
            item['checked'] = !item['checked'];
            setState(() {});
          }));
      options.add(new Divider(height: 1.0));
    });
    return ListView(children: options);
  }

  Widget _buildSearchText() {
    return Container(
      color: widget.searchBoxColor ?? Theme.of(context).primaryColor,
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: TextField(
              controller: _controller,
              keyboardAppearance: Brightness.light,
              onChanged: searchOperation,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(6.0),
                    ),
                  ),
                  filled: true,
                  hintText: widget.searchBoxHintText ?? "Search...",
                  fillColor: widget.searchBoxFillColor ?? Colors.white,
                  suffix: SizedBox(
                      height: 25.0,
                      child: IconButton(
                        icon: widget.searchBoxIcon ?? Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          searchOperation('');
                        },
                        padding: EdgeInsets.all(0.0),
                        tooltip: widget.searchBoxToolTipText ?? 'Clear',
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  void _clearSelection() {
    _localDataSourceWithState = _localDataSourceWithState.map((item) {
      item['checked'] = false;
      return item;
    }).toList();
    setState(() {});
  }

  void searchOperation(String searchText) {
    _searchresult.clear();
    if (_isSearching != null &&
        searchText != null &&
        searchText.toString().trim() != '') {
      for (int i = 0; i < _localDataSourceWithState.length; i++) {
        String data =
            '${_localDataSourceWithState[i]['value']} ${_localDataSourceWithState[i]['text']}';
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          _searchresult.add(_localDataSourceWithState[i]);
        }
      }
    } else {
      _searchresult = List.from(_localDataSourceWithState);
    }
  }
}
