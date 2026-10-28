import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Destination {
  final String name;
  final String capital;
  final String region;
  final int population;
  final String flagUrl;

  Destination(this.name, this.capital, this.region, this.population, this.flagUrl);

  factory Destination.fromJson(Map<String, dynamic> json) {
    final cap = json['capital']?.toString().trim();
    final code = (json['alpha2Code'] ?? '').toString().toLowerCase();

    return Destination(
      json['name'] ?? '',
      (cap != null && cap.isNotEmpty) ? cap : 'N/A',
      json['region'] ?? '',
      json['population'] ?? 0,
      'https://flagcdn.com/w80/$code.png',
    );
  }
}

class FlagImage extends StatelessWidget {
  final String url;
  final double width;

  const FlagImage({
    super.key,
    required this.url,
    this.width = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: width,
          height: width * 0.75,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.flag_outlined,
          size: width,
        );
      },
    );
  }
}

class DestinationsScreen extends StatefulWidget {
  const DestinationsScreen({super.key});

  @override
  State<DestinationsScreen> createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen> {
  List<Destination> destinations = [];
  bool isLoading = true;
  String? errorMessage;

  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchDestinations();
  }

  Future<void> fetchDestinations() async {
    try {
      final response = await _dio.get(
        'https://countries.dev/countries?fields=name,capital,region,population,alpha2Code',
      );
      if (response.data is List) {
        final List<dynamic> data = response.data;
        setState(() {
          destinations =
              data.map((json) => Destination.fromJson(json)).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load destinations: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _launchWikipedia(String destinationName) async {
    final uri = Uri.parse(
      'https://en.wikipedia.org/wiki/${Uri.encodeComponent(destinationName)}',
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open Wikipedia for $destinationName'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        title: const Text('Tafaqad AL weghat'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: colors.onPrimary),
            )
          : errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: colors.onPrimary, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : destinations.isEmpty
                  ? Center(
                      child: Text(
                        'No destinations available',
                        style: TextStyle(color: colors.onPrimary, fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: destinations.length,
                      itemBuilder: (context, index) {
                        final destination = destinations[index];
                        return Card(
                          color: colors.onPrimary,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ListTile(
                            onTap: () => _launchWikipedia(destination.name),
                            leading: FlagImage(url: destination.flagUrl),
                            title: Text(
                              destination.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colors.primary,
                              ),
                            ),
                            subtitle: Text(
                              '${destination.capital} • ${destination.region}\nPopulation: ${destination.population}',
                              style: TextStyle(
                                color: colors.primary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
