import 'package:flutter/material.dart';
import 'package:test/models/country.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CountryInfo extends StatelessWidget {
  final Country country;

  CountryInfo({required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey,
                      Colors.blueGrey,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: country.images!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CachedNetworkImage(
                          imageUrl: country.images![index],
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Positioned(
                      bottom: 30,
                      left: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            country.name!,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            country.capital!,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      country.description!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: country.images!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: country.images![index],
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
