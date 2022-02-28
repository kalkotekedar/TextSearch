import 'import.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({Key? key}) : super(key: key);

  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  final _formKey = GlobalKey<FormState>();
  var params = Get.arguments;
  var searchText = "";

  Widget _buildGridItem(int x, int y) {
    var items = params[pData];
    var diff =
        searchText.isNotEmpty && searchText.toUpperCase().contains(items[x][y]);

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      color: diff ? Colors.red : Colors.white,
      child: appText(
        items[x][y],
        clr: diff ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int x, y = 0;
    x = (index / params[tColumns]).floor();
    y = (index % params[tColumns]).floor();
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        child: Center(
          child: _buildGridItem(x, y),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (val) => setState(() => searchText = val),
                        textAlign: TextAlign.center,
                        decoration:
                            const InputDecoration(hintText: 'Enter word'),
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: pagePadding,
                child: Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: params[tColumns],
                        ),
                        itemBuilder: _buildGridItems,
                        itemCount: params[tRows] * params[tColumns],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
