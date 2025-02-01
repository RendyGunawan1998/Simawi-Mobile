import '../../core.dart';

tfOutlineBorder(String title, TextEditingController cont) {
  return TextField(
    controller: cont,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(),
    ),
  );
}

tfOutlineBorderNumber(String title, TextEditingController cont) {
  return TextField(
    keyboardType: TextInputType.number,
    controller: cont,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(),
    ),
  );
}

tfOutlineBorderNik(String title, TextEditingController cont) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "$title can't be null";
      }
      if (value.length < 16) {
        return '$title cannot less than 16 number';
      }
      return null;
    },
    keyboardType: TextInputType.number,
    controller: cont,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(),
    ),
  );
}

tfOutlineBorderPhone(String title, TextEditingController cont) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "$title can't be null";
      }
      if (value.length < 10) {
        return '$title cannot less than 10 number';
      }
      return null;
    },
    keyboardType: TextInputType.number,
    controller: cont,
    decoration: InputDecoration(
      labelText: title,
      border: OutlineInputBorder(),
    ),
  );
}

tffSuffix(TextEditingController cont, String label, IconData icon,
    Function() funcSuff) {
  return TextField(
    controller: cont,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      suffixIcon: InkWell(onTap: funcSuff, child: Icon(icon)),
    ),
  );
}

tffSearch(TextEditingController cont, String label, IconData icon,
    Function() funcSuff) {
  return Container(
    height: 35,
    padding: EdgeInsets.fromLTRB(14, 8, 5, 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1)),
    child: TextField(
      controller: cont,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: label,
        suffixIcon: InkWell(onTap: funcSuff, child: Icon(icon)),
      ),
    ),
  );
}

tffType(TextEditingController cont, String label, TextInputType type) {
  return TextField(
    controller: cont,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
    keyboardType: type,
  );
}

tff(TextEditingController cont, String label) {
  return TextField(
    controller: cont,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
  );
}

tff3Line(TextEditingController cont, String label) {
  return TextField(
    expands: false,
    maxLines: 3,
    controller: cont,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
  );
}

tffOnlyRead(TextEditingController cont, String label) {
  return TextField(
    expands: false,
    controller: cont,
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
  );
}

tfPass(String hint, TextEditingController cont, bool stat, Function() func) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black54, width: 0.5)),
    child: Padding(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: TextFormField(
        controller: cont,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password can't be null";
          }
          return null;
        },
        decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: func,
              child: Icon(stat ? Icons.visibility : Icons.visibility_off),
            ),
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock_outline_rounded),
            contentPadding: EdgeInsets.only(top: 12, bottom: 10),
            border: InputBorder.none),
        obscureText: stat,
      ),
    ),
  );
}

tfEmail(String hint, TextEditingController cont) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black54, width: 0.5)),
    child: Padding(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Email can't be null";
            }
            return null;
          },
          controller: cont,
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.only(top: 12, bottom: 10),
              border: InputBorder.none)),
    ),
  );
}

tfName(String hint, TextEditingController cont) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black54, width: 0.5)),
    child: Padding(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Name can't be null";
            }
            return null;
          },
          controller: cont,
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(Icons.person),
              contentPadding: EdgeInsets.only(top: 12, bottom: 10),
              border: InputBorder.none)),
    ),
  );
}
