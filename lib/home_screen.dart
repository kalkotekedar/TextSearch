import 'import.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  int r = 0;
  int c = 0;
  String txt = '';

  goToPuzzleScreen() {
    if (_formKey.currentState!.validate()) {
      //Created a 2D array
      var data = List.generate(
        r,
        (i) => List.generate(c, (j) => 'a', growable: false),
        growable: false,
      );
      int k = 0;
      //Replace the array with the actual string
      txt = txt.toUpperCase();
      for (int i = 0; i < r; i++) {
        for (int j = 0; j < c; j++) {
          data[i][j] = txt[k];
          k++;
        }
      }
      Get.to(
        const GridScreen(),
        arguments: {
          tRows: r,
          tColumns: c,
          pData: data,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: Container(
          width: Get.size.width,
          padding: pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appText(tRows, size: 32, isBold: true),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(() => r > 0 ? r-- : r),
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      size: 32,
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: appText('$r',
                        size: 48, isBold: true, clr: Colors.green),
                  ),
                  IconButton(
                    onPressed: () => setState(() => r < 25 ? r++ : r),
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 32,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              appText(tColumns, size: 32, isBold: true),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      c > 0 ? c-- : c;
                    }),
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                      size: 32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: appText('$c',
                        size: 48, isBold: true, clr: Colors.green),
                  ),
                  IconButton(
                    onPressed: () => setState(() => c < 25 ? c++ : c),
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.green,
                      size: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: TextFormField(
                  onChanged: (val) {
                    txt = val;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    var size = value.toString().replaceAll(' ', '').length;
                    if (r * c == 0) {
                      return ('Row and Column should be greater than 0');
                    } else if (size == (c * r)) {
                      return null;
                    } else {
                      return 'Characters should be ${c * r}';
                    }
                  },
                  maxLength: r * c > 0 ? r * c : -1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a text',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              appButton(
                tLoad,
                goToPuzzleScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
