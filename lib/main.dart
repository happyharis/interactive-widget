import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(236, 240, 246, 1),
        body: SafeArea(
          child: InstagramBody(),
        ),
      ),
    );
  }
}

class InstagramBody extends StatelessWidget {
  const InstagramBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        width: width * 0.9,
        height: height * 0.9,
        child: Column(
          children: [
            SizedBox(height: 10),
            TopHeader(),
            ScrollableStoriesRow(),
            ImageCard(),
          ],
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Column(
        children: [
          HeaderCard(),
          SizedBox(height: 10),
          UserImage(),
          FooterCard()
        ],
      ),
    );
  }
}

class FooterCard extends StatelessWidget {
  const FooterCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 10,
      ),
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.heart),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('15,128'),
          ),
          SizedBox(width: 20),
          FaIcon(FontAwesomeIcons.commentAlt),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('350'),
          ),
          Spacer(),
          FaIcon(FontAwesomeIcons.bookmark),
        ],
      ),
    );
  }
}

class UserImage extends StatefulWidget {
  const UserImage({
    Key key,
  }) : super(key: key);

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  @override
  Widget build(BuildContext context) {
    final transformationController = TransformationController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InteractiveViewer(
        transformationController: transformationController,
        onInteractionEnd: (details) {
          setState(() {
            transformationController.toScene(Offset.zero);
          });
        },
        boundaryMargin: EdgeInsets.all(20.0),
        minScale: 0.1,
        maxScale: 1.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.0),
          child: Image.asset('images/user_picture.png'),
        ),
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/user_profile.png'),
            radius: 27,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sam Martin',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3),
            Text(
              '5 minutes ago',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
          ],
        ),
        Spacer(),
        FaIcon(FontAwesomeIcons.ellipsisH, size: 14),
        SizedBox(width: 10),
      ],
    );
  }
}

class ScrollableStoriesRow extends StatelessWidget {
  const ScrollableStoriesRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 1; i < 6; i++)
            Padding(
              padding: const EdgeInsets.only(
                right: 25.0,
                top: 20,
                bottom: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [],
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/$i.png'),
                  radius: 27,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TopHeader extends StatelessWidget {
  const TopHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'images/instagram_word.png',
          width: 100,
        ),
        Spacer(),
        Image.asset(
          'images/igtv.png',
          width: 25,
        ),
        SizedBox(width: 18),
        Image.asset(
          'images/message.webp',
          width: 25,
          color: Colors.black,
        ),
      ],
    );
  }
}
