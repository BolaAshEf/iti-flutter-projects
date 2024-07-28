import 'package:dummy_projects/notes_app/app_bar_button.dart';
import 'package:dummy_projects/notes_app/db_manager.dart';
import 'package:flutter/material.dart';
import 'note_card_model.dart';
import 'notes_home_screen.dart';
import 'search_screen.dart';

enum NoteManagerMode{
  preview,
  edit,
  add,
}

class NoteManager extends StatefulWidget {
  final NoteManagerMode mode;
  final NoteModel? note;
  const NoteManager.preview({
    super.key,
    required NoteModel this.note,
  }) : mode = NoteManagerMode.preview;

  const NoteManager.edit({
    super.key,
    required NoteModel this.note,
  }) : mode = NoteManagerMode.edit;

  const NoteManager.add({
    super.key,
  }) : mode = NoteManagerMode.add, note = null;

  @override
  State<NoteManager> createState() => _NoteManagerState();
}

class _NoteManagerState extends State<NoteManager> {
  late NoteManagerMode _currentMode;
  NoteModel? _currentNote;

  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _currentMode = widget.mode;
    _currentNote = widget.note;

    _setNoteDate();
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();

    super.dispose();
  }

  void _setNoteDate(){
    if(_currentNote != null){
      _titleController.text = _currentNote!.title;
      _textController.text = _currentNote!.text;
    }
  }


  void _savePressed() async {
    switch(_currentMode){
      case NoteManagerMode.preview:
        break;
      case NoteManagerMode.edit:
        if(_titleController.text.trim().isEmpty 
            || _textController.text.trim().isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error: Enter a valid note data!'),
            ),
          );
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Updated!'),
          ),
        );
        _currentNote = await DBManager.update(NoteModel(
          id: _currentNote!.id, 
          title: _titleController.text.trim(), 
          text: _textController.text.trim(), 
          color: _currentNote!.color,
        ));
        _currentMode = NoteManagerMode.preview;
        _setNoteDate();
        setState(() {});
        homeScreenGK.currentState?.setState(() {});
        searchScreenGK.currentState?.setState(() {});
        break;
      case NoteManagerMode.add:
        if(_titleController.text.trim().isEmpty 
            || _textController.text.trim().isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error: Enter a valid note data!'),
            ),
          );
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added!'),
          ),
        );
        _currentNote = await DBManager.add(NoteModel(
          id: -1, 
          title: _titleController.text.trim(), 
          text: _textController.text.trim(), 
          color: Colors.transparent,
        ));
        _currentMode = NoteManagerMode.preview;
        _setNoteDate();
        setState(() {});
        homeScreenGK.currentState?.setState(() {});
        searchScreenGK.currentState?.setState(() {});
        break;
    }
  }

  void _editPressed () => 
    setState(() => _currentMode = NoteManagerMode.edit,);

  Future<bool> _onBack(BuildContext context) async {         
    switch(_currentMode){
      case NoteManagerMode.preview:
        return true;
      case NoteManagerMode.add:
      case NoteManagerMode.edit:
        if(_titleController.text.trim().isNotEmpty 
            && _textController.text.trim().isNotEmpty
            && (
              _titleController.text.trim() != _currentNote?.title
              || _textController.text.trim() != _currentNote?.text
              )){
          final res = await showAlertDialog(
            context: context,
            msg: "Save changes ?",
            ok: "Save",
            cancel: "Discard",
          );
          if(res == true){
            _savePressed();
            return true;
          }else if(res == false && context.mounted){
            final res2 = await showAlertDialog(
              context: context,
              msg: "Are your sure you want discard your changes ?",
              ok: "Keep",
              cancel: "Discard",
            );
            return !(res2 ?? false);
          }else{
            return false;
          }
        }
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if(!didPop){
          if(await _onBack(context) && context.mounted){
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          leadingWidth: 100,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: AppBarButton(
                icon: Icons.arrow_left,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
          actions: [
            if(_currentMode == NoteManagerMode.add || 
                _currentMode == NoteManagerMode.edit) Padding(
              padding: const EdgeInsets.all(20),
              child: AppBarButton(
                icon: Icons.save,
                onPressed: _savePressed,
              ),
            ),
            if(_currentMode == NoteManagerMode.preview) Padding(
              padding: const EdgeInsets.all(20),
              child: AppBarButton(
                icon: Icons.edit,
                onPressed: _editPressed,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  readOnly: _currentMode == NoteManagerMode.preview,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 48,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 25,),
                TextField(
                  controller: _textController,
                  readOnly: _currentMode == NoteManagerMode.preview,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 23,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Type somthing...",
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool?> showAlertDialog({
  required BuildContext context, 
  required String msg,
  required String ok,
  required String cancel, 
}) async => showDialog<bool?>(
  context: context,
  builder: (context) => AlertDialog(
    backgroundColor: const Color(0xff252525),
    title: const Icon(Icons.info, color: Color(0xff606060), size: 36,),
    content: Text(
      msg,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 23,
      ),
    ),
    actions: [
      Container(
        width: 110,
        height: 40,
        margin: const EdgeInsets.all(15),
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.red,
          child: InkWell(
            onTap: () => Navigator.of(context).pop(false),
            customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            borderRadius: const BorderRadius.all(Radius.circular(8)),    
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(cancel),
            ),
          ),
        ),
      ),
      Container(
        width: 110,
        height: 40,
        margin: const EdgeInsets.all(15),
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.green,
          child: InkWell(
            onTap: () => Navigator.of(context).pop(true), 
            customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            borderRadius: const BorderRadius.all(Radius.circular(8)),    
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(ok),
            ),
          ),
        ),
      ),
    ],
  ),
);
