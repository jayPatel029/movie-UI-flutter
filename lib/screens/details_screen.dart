import 'package:flutter/material.dart';

import '../api/api_model.dart';

class DetailsScreen extends StatefulWidget {
  final Show show;
  final double? score;

  const DetailsScreen({super.key, required this.show, this.score});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_backspace_rounded,
            color: Colors.redAccent,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Movie Details",
          style: TextStyle(color: Colors.redAccent),
        ),
        backgroundColor: Colors.black,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return _buildWebLayout(context);
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster Image
          Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
              image: DecorationImage(
                image: NetworkImage(widget.show.image?.original ?? ""),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title and Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildDetailsSection(context),
          ),
          const SizedBox(height: 20),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildActionButtons(),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image
            Expanded(
              flex: 2,
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  image: DecorationImage(
                    image: NetworkImage(widget.show.image?.original ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),

            // Details Section
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailsSection(context),
                  const SizedBox(height: 20),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          widget.show.name ?? "No Title",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width > 800 ? 36 : 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),

        // Genres
        Text(
          widget.show.genres?.join(", ") ?? "No Genres Available",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),

        // Score & Rating
        Row(
          children: [
            const Icon(Icons.star, color: Colors.yellow),
            const SizedBox(width: 4),
            Text(
              widget.show.rating?.average?.toString() ?? 'No Rating',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '(${widget.score?.toStringAsFixed(2) ?? "N/A"})',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Summary
        Text(
          widget.show.summary != null
              ? isExpanded
                  ? widget.show.summary!.replaceAll(RegExp(r'<[^>]*>'), '')
                  : '${widget.show.summary!.replaceAll(RegExp(r'<[^>]*>'), '').substring(0, 150)}...'
              : "No Summary Available",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? "Show Less" : "Show More",
            style: const TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Additional Info
        _buildInfoRow(
            Icons.language, "Language: ${widget.show.language ?? 'N/A'}"),
        const SizedBox(height: 10),
        _buildInfoRow(Icons.network_wifi,
            "Network: ${widget.show.network?.name ?? 'N/A'}"),
        const SizedBox(height: 10),
        _buildInfoRow(
            Icons.schedule, "Schedule: ${widget.show.schedule?.time ?? 'N/A'}"),
        const SizedBox(height: 10),
        _buildInfoRow(
            Icons.link, "Official Site: ${widget.show.officialSite ?? 'N/A'}"),
        const SizedBox(height: 10),
        _buildInfoRow(Icons.access_time,
            "Runtime: ${widget.show.runtime ?? 'N/A'} minutes"),
        const SizedBox(height: 10),
        _buildInfoRow(Icons.calendar_today,
            "Premiered: ${widget.show.premiered ?? 'N/A'}"),
        const SizedBox(height: 10),
        _buildInfoRow(Icons.info, "Status: ${widget.show.status ?? 'N/A'}"),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Handle Watch Now action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              "Watch Now",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Handle Add to Watchlist action
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.red),
            ),
            child: const Text(
              "Add to Watchlist",
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build info rows with an icon and text
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
