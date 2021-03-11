import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main () {
  // entry
  runApp(new MyApp());
}
// main
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // app name
      title: 'Counter Demo',
      initialRoute:"/", //名为"/"的路由作为应用的home(首页)
      // app theme
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      // 注册路由表
      routes: {
        'new_page': (context) => EchoRoute(),
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
      },
      // app 首页路由
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}): super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title)
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              '你已经点击了这个按钮这么多次了：'
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RandomWordsWidget(),
            FlatButton(
              child: Text('open new route'),
              textColor: Colors.blue,
              onPressed: (){
                Navigator.of(context).pushNamed("new_page", arguments: "hi");
                // Navigator.pushNamed(context, "new_page");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context){
                //       return RouterTestRoute();
                //     }
                //   )
                // );
              },
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child:  new Icon(Icons.add),
      ),
    );
  }
  
}

// 新路由页面
// WidgetBuilder builder
// RouteSettings settings
// bool maintainState = true
// bool fullscreenDialog = false
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('新路由'),
      ),
      body: Center(
        child: Text('This is new route!'),
      ),
    );
  }
}

// tips 页面
class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text,
}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示")
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: ()=>Navigator.pop(context, "我是返回值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// 打开新路由代码
class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('qwesfdafbdbgf')
      ),
      body: new Center(
        child: RaisedButton(
          onPressed: () async {
            // 打开`TipRoute`，并等待返回结果
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return TipRoute(
                    // 路由参数
                    text: "我是提示xxxx",
                  );
                },
              ),
            );
            //输出`TipRoute`路由返回结果
            print("路由返回值: $result");
          },
          child: Text("打开提示页"),
        ),
      ) ,
    );
  }
}

// EchoRoute
class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return testWidget();
  }
}

//随机
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

// 状态访问 不便 ,非耦合组件相互调用
// 继承StatefulWidget 不便

class testWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('外层的title'),
      ),
      body: Center(
        child: Builder(builder: (context){
          return RaisedButton(
            onPressed: () {
              ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
              _state.showSnackBar(
                 SnackBar(
                 content: Text("我是SnackBar"),
                 ),
              );
            },
            child: Text("button"),
          );
        }),
      ),
    );
  }
}