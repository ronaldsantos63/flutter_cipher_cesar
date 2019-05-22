
class CriptoCesar{
  final _letters = 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z'.split(" ");
  int _key = 3;
  String _text = '';

  String encrypt({String text, int key = 3}){
    _text = text.toUpperCase() ?? _text.toUpperCase();
    _key = key ?? _key;

    String cipher_text = '';
    for (int pos = 0; pos < _text.length; pos++){
      if (_letters.contains(_text[pos])){
        int pos_chipher = _letters.indexOf(_text[pos]) + _key;
        if (pos_chipher >= 26) pos_chipher =  pos_chipher - 26;
        cipher_text += _letters[pos_chipher];
      } else {
        cipher_text += _text[pos];
      }
    }
    return cipher_text;
  }

  String decrypt({String text, int key = 3}){
    _text = text.toUpperCase() ?? _text.toUpperCase();
    _key = key ?? _key;

    String plain_text = '';
    for (int pos = 0; pos < _text.length; pos++){
      if (_letters.contains(_text[pos])){
        int pos_chipher = _letters.indexOf(_text[pos]) - _key;
//        if (pos_chipher >= 26) pos_chipher =  pos_chipher - 26;
        plain_text += _letters[pos_chipher];
      } else {
        plain_text += _text[pos];
      }
    }
    return plain_text;
  }
}