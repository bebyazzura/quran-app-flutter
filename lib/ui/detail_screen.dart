import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/global.dart';
import 'package:quran/model/ayat.dart';
import 'package:quran/model/surah.dart';
import 'package:quran/ui/tabs/surah_tabs.dart';

class DetailScreen extends StatelessWidget {
  final int surahNumber;

  const DetailScreen({super.key, required this.surahNumber});

  Future<Surah> _surahDetail() async {
    var response = await Dio().get('https://equran.id/api/surat/$surahNumber');

    return Surah.fromJson(json.decode(response.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Surah>(
          future: _surahDetail(),
          initialData: null,
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            Surah surah = snapshot.data!;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: _appBar(context: context, surah: surah),
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: _detail(surah: surah),
                  )
                ],
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.separated(
                      itemBuilder: (context, index) => Container(),
                      separatorBuilder: (context, index) => Container(),
                      itemCount: surah.jumlahAyat + (surahNumber == 1 ? 1 : 0)),
                ),
              ),
            );
          })),
    );
  }

  Widget _ayatItem({required Ayat ayat}) => Container();

  Widget _detail({required Surah surah}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            Container(
              height: 265,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFDF98FA), Color(0xFF9055FF)]),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Opacity(
                opacity: 0.2,
                child: SvgPicture.asset(
                  '/svg/quran_banner.svg',
                  width: 324 - 58,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(28),
              child: Column(
                children: [
                  Text(
                    surah.namaLatin,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 26),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    surah.arti,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.35),
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        surah.tempatTurun.name,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset('/svg/ellipse.svg'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${surah.jumlahAyat} Ayat',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SvgPicture.asset('/svg/bismillah.svg')
                ],
              ),
            )
          ],
        ),
      );

  AppBar _appBar({required BuildContext context, required Surah surah}) =>
      AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                onPressed: (() => Navigator.of(context).pop()),
                icon: SvgPicture.asset('/svg/back_icon.svg')),
            SizedBox(width: 24),
            Text(
              surah.namaLatin,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold, color: primary),
            ),
            const Spacer(),
            IconButton(
                onPressed: (() => {}),
                icon: SvgPicture.asset('/svg/search_icon.svg'))
          ],
        ),
      );
}
