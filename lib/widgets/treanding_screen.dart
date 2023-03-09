import 'package:flutter/material.dart';
import 'package:peliculas/models/treanding_response.dart';

class TreandingScreen extends StatelessWidget {
  final List<Treanding> treanfin;

  const TreandingScreen({super.key, required this.treanfin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Treanding 🔥',
              style: TextStyle(fontSize: 20, fontFamily: 'poppins'),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: treanfin.length,
            itemBuilder: (_, index) => TreandingPoster(
              treanding: treanfin[index],
            ),
          ))
        ],
      ),
    );
  }
}

class TreandingPoster extends StatelessWidget {
  final Treanding treanding;

  const TreandingPoster({super.key, required this.treanding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  height: 185,
                  width: 130,
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(treanding.fullposterTreandingImg)),
            ),
          ),
          Text(
            treanding.title,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
