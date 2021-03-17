import 'package:flutter/Material.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(14),
        color: Colors.black,
        shadowColor: Theme.of(context).accentColor,
        elevation: 12,
        child: TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              contentPadding: EdgeInsets.symmetric(horizontal: 14),
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
              filled: true,
              hintText: 'برای جست و جو نام شهر یا اونت را وارد کنید'),
        ),
      ),
    );
  }
}
