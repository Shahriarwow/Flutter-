import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/UI/home/home.dart';


const int homeindex = 0;
const int cartindex = 1;
const int profileindex = 2;



class RootScreen extends StatefulWidget{
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {


  int selectedScreenindex = homeindex;
  List<int> _history = [];

  final GlobalKey<NavigatorState> _homekey = GlobalKey();
  final GlobalKey<NavigatorState> _cartkey = GlobalKey();
  final GlobalKey<NavigatorState> _profilekey = GlobalKey();


  late final map = {
    homeindex: _homekey,
    cartindex: _cartkey,
    profileindex: _profilekey,
 
  };

  Future<bool> _onWillPop() async {
    final NavigatorState curentSelectedTabNavigatorState =
        map[selectedScreenindex]!.currentState!;
    if (curentSelectedTabNavigatorState.canPop()) {
      curentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenindex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
       
       // ignore: sort_child_properties_last
       return WillPopScope(child: Scaffold(
        
        body:
               IndexedStack(
                index: selectedScreenindex,
                children: [
                  _navigator(_homekey, homeindex,  HomeScreen()),
                  _navigator(_cartkey, cartindex, const Center(child: Text('Cart'),)),
                  _navigator(_profilekey, profileindex, const Center(child: Text('profile'),)),
               
                ],
              ),
        
        
         
        bottomNavigationBar: BottomNavigationBar(
         
          items: const [ 
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'خانه'),
         BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart),label: 'سبد خرید'),
             BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),label: 'پروفایل')

          ],
          currentIndex: selectedScreenindex,
          onTap: (selectedindex){
          setState(() {
            
                    _history.remove(selectedScreenindex);
                    _history.add(selectedScreenindex);
            selectedScreenindex=selectedindex;
          });

        },),
       
       
       ), onWillPop: _onWillPop);
       

  }
   Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenindex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenindex != index, child: child)),
          );
  }
}