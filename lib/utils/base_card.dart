import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBar(),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff3E65F2),
        child: ListView(
          children: <Widget>[
            ListTile(
              title:
                  const Text('Inicio', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Servicios',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!_isActive)
          Text("Pamphlet", style: Theme.of(context).appBarTheme.titleTextStyle),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 250),
              child: _isActive
                  ? Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isActive = false;
                                  });
                                },
                                icon: const Icon(Icons.close))),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          _isActive = true;
                        });
                      },
                      icon: const Icon(Icons.search)),
            ),
          ),
        ),
      ],
    );
  }
}
