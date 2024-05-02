import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/global.dart';
import 'package:quran/ui/tabs/hijb_tabs.dart';
import 'package:quran/ui/tabs/page_tabs.dart';
import 'package:quran/ui/tabs/para_tabs.dart';
import 'package:quran/ui/tabs/surah_tabs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        bottomNavigationBar: _bottomNavigationBar(),
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) => [
                          SliverToBoxAdapter(
                            child: _salam(),
                          ),
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            elevation: 0,
                            pinned: true,
                            shape: Border(
                              bottom: BorderSide(
                                width: 2,
                                color: primary.withOpacity(.1),
                              ),
                            ),
                            bottom: PreferredSize(
                              preferredSize: const Size.fromHeight(0),
                              child: _tab(),
                            ),
                          )
                        ],
                body: const TabBarView(
                  children: [
                    SurahTabs(),
                    ParaTabs(),
                    PageTabs(),
                    HijbTabs(),
                  ],
                )),
          ),
        ));
  }

  TabBar _tab() {
    return TabBar(
      tabs: [
        _tabItem(label: 'Surah'),
        _tabItem(label: 'Para'),
        _tabItem(label: 'Page'),
        _tabItem(label: 'Hijb'),
      ],
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 3, color: primary),
          insets: const EdgeInsets.symmetric(horizontal: 80)),
    );
  }

  Tab _tabItem({required String label}) {
    return Tab(
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Column _salam() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assalamualaikum',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: secondary,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Soobean',
          textAlign: TextAlign.right,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 24,
          width: 20,
        ),
        _lastRead()
      ],
    );
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
          height: 131,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFDF98FA),
                    Color(0xFF9055FF),
                  ])),
        ),
        Positioned(
            bottom: -35,
            right: 0,
            child: SvgPicture.asset('/svg/quran_banner.svg')),
        Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                SvgPicture.asset('/svg/book.svg'),
                const SizedBox(
                  width: 8,
                  height: 20,
                ),
                Text(
                  'Last Read',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Al-Fatihah',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Verse No.1',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            )
          ]),
        )
      ],
    );
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        items: [
          _bottomNavigationBarItem(icon: '/svg/quran_icon.svg', label: 'Quram'),
          _bottomNavigationBarItem(icon: '/svg/doa_icon.svg', label: 'Doa'),
          _bottomNavigationBarItem(
              icon: '/svg/bookmark_icon.svg', label: 'Boolmark'),
        ],
      );

  BottomNavigationBarItem _bottomNavigationBarItem(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            icon,
            color: secondary,
          ),
          activeIcon: SvgPicture.asset(
            icon,
            color: primary,
          ),
          label: label);

  AppBar _appBar() => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: (() => {}),
                icon: SvgPicture.asset('/svg/menu_icon.svg')),
            const SizedBox(
              width: 24,
            ),
            Text(
              'Quran App',
              style: GoogleFonts.poppins(
                  color: primary, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
                onPressed: (() => {}),
                icon: SvgPicture.asset('/svg/search_icon.svg')),
          ],
        ),
      );
}
