import 'package:flutter/material.dart';
import 'package:flutter_application_project_main/core/widgets/client/widget_appbar.dart';
import 'package:flutter_application_project_main/core/widgets/client/widget_drawer.dart';
import 'package:flutter_application_project_main/core/widgets/client/widget_footer.dart';
import 'package:flutter_application_project_main/core/widgets/client/widget_jobcard.dart';
import 'package:flutter_application_project_main/app.dart';
import 'package:flutter_application_project_main/core/widgets/client/widget_search.dart';
import 'package:flutter_application_project_main/core/widgets/client/widgte_jobbanner.dart';
import 'package:flutter_application_project_main/core/themes/primary_text.dart';
import 'package:flutter_application_project_main/core/themes/primary_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    final inheritedTheme = AppInheritedTheme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        themeMode: inheritedTheme!.themeMode,
        toggleTheme: inheritedTheme.toggleTheme,
      ),
      drawer: CustomDrawer(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            setState(() {
              _scrollOffset = scrollNotification.metrics.pixels;
            });
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 100,
                  child: WidgetSearch(),
                ),
              ),
              SizedBox(
                height: 200,
                child: BannerCarousel(),
              ),
              _buildHeader(),
              const SizedBox(
                height: 180,
                child: JobCard(),
              ),
              SizedBox(
                height: 30,
              ),
              _buildAboutUsHeader(),
              ..._buildFadeItems(),
              _buildDreamJobSection(),
              _buildBlogRecent(),
              SizedBox(
                height: 330,
                child: CustomFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogRecent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Text(
            'Blog gần đây',
            style: PrimaryText.primaryTextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            'assets/images/nen.png',
            width: double.infinity, 
            height: 300,
            fit: BoxFit.cover, 
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Môi trường công việc',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: const [
              Text(
                '10 Tháng 11, 2020 *',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(
                'By Josh Holmes',
                style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsaad iure porro mollitia architecto hic consequuntur. Distinctio nisi perferendis dolore, ipsa consectetur.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Việc làm tốt nhất',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, size: 16),
            label: const Text('Lọc theo'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              foregroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutUsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/nen.png',
            width: 150,
            height: 150,
            fit: BoxFit.cover, 
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Về chúng tôi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 1.0),
              _buildAboutUsDecoration(),
              const SizedBox(
                width: 180,
                child: Text(
                  '“Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ea nisi Lorem ipsum dolor sit amet, consectetur.”',
                  style: TextStyle(fontSize: 13, height: 1.5),
                ),
              ),
              _buildDeveloperInfo(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutUsDecoration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          width: 50,
          height: 2,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Color(0xFFFFA726)),
          ),
        ),
        SizedBox(height: 3.0),
        SizedBox(
          width: 80,
          height: 2,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Color(0xFFFFA726)),
          ),
        ),
      ],
    );
  }

  Widget _buildDeveloperInfo() {
    return Row(
      children: const [
        SizedBox(
          width: 20,
          height: 2,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Color(0xFFFFA726)),
          ),
        ),
        SizedBox(width: 8),
        Text(
          'Yuki',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        Text(
          ', Developer',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFadeItems() {
    return [
      FadeItem(
        title: '01\nTìm công ty, vị trí',
        scrollOffset: _scrollOffset,
        threshold: 100,
      ),
      FadeItem(
        title: '02\nTạo CV',
        scrollOffset: _scrollOffset,
        threshold: 300,
      ),
      FadeItem(
        title: '03\nỨng tuyển vị trí',
        scrollOffset: _scrollOffset,
        threshold: 500,
      ),
    ];
  }

    Widget _buildDreamJobSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/hinh1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.4), 
          height: 250,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Công việc mơ ước của bạn',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Đang chờ bạn',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Tìm việc làm',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: PrimaryTheme.buttonPrimary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Ứng tuyển',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 32,
            ),
          ),
          child: const Text(
            'Tìm việc làm',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: PrimaryTheme.buttonPrimary,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 32,
              ),
              child: const Text(
                'Ứng tuyển',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class FadeItem extends StatelessWidget {
  final String title;
  final double scrollOffset;
  final double threshold;

  const FadeItem({
    required this.title,
    required this.scrollOffset,
    required this.threshold,
  });

  @override
  Widget build(BuildContext context) {
    double opacity = 0.0;

    if (scrollOffset > threshold) {
      opacity = ((scrollOffset - threshold) / 200).clamp(0.0, 1.0);
    }

    return Opacity(
      opacity: opacity,
      child: SizedBox(
        height: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: PrimaryText.primaryTextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (title == '01\nTìm công ty, vị trí' || title == '02\nTạo CV')
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: SizedBox(
                  width: 3,
                  height: 103,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFA726),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
