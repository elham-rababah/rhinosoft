import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class BottomNavigationItem  extends StatelessWidget{
  final IconData icon;
  final IconData activeIcon;
  final ValueChanged<int> changeIndex;
  final int index;
  String title='test';
  final int currentIndex;

  BottomNavigationItem({this.icon,this.title, this.activeIcon, this.changeIndex, this.index, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 80.0,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => changeIndex(currentIndex),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(child: Icon(currentIndex==index ? activeIcon : icon, color: currentIndex==index ?Color(0xFFCF8A50) : Colors.orange, size: 27.0))
                ,SizedBox(height: 8,)
                ,Text(title,style: TextStyle(fontSize: 12,color: currentIndex==index ?Color(0xFFCF8A50) : Colors.grey),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final Function changeIndex;
  Color color;

  BottomNavBar({Key key, this.changeIndex,this.color}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with SingleTickerProviderStateMixin {

  int _index = 0;

  _changeIndex(int index) {
    widget.changeIndex(index);
    setState(() {
      _index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 4.0,
        notchMargin: 10.0,
        shape: CircularNotchedRectangle(),
        color: widget.color!=null ?widget.color:Theme.of(context).bottomAppBarColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            BottomNavigationItem(
              icon: FontAwesomeIcons.home ,
              activeIcon:  FontAwesomeIcons.home,
              changeIndex: _changeIndex,
              index: _index, currentIndex: 0,
              title: 'Add Product',
            ),
            BottomNavigationItem(
              icon: FontAwesomeIcons.search,
              activeIcon: FontAwesomeIcons.search,
              changeIndex: _changeIndex,
              index: _index,
              currentIndex: 1,
              title: 'Add Product',

            ),
            BottomNavigationItem(
              icon: FontAwesomeIcons.search,
              activeIcon: FontAwesomeIcons.search,
              changeIndex: _changeIndex,
              index: _index,
              currentIndex: 2,
              title: 'Admin',

            ),
          ],
        )
    );
  }
}
