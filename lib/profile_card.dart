import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final dynamic user;

  ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Avatar, Name, and Username
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 16), // Space below the header
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      user['name'][0],
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user['name'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("Username: ${user['username']}",
                            style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Information sections
            _buildInfoRow("Email", user['email'], Colors.blue),
            _buildInfoRow("Address",
                "${user['address']['street']}, ${user['address']['suite']}, ${user['address']['city']} - ${user['address']['zipcode']}"),
            _buildInfoRow("Phone", user['phone']),
            _buildInfoRow("Website", user['website']),
            _buildInfoRow("Company", user['company']['name']),
            Padding(
              padding: const EdgeInsets.only(
                  top: 4), // Space above the catchPhrase text
              child: Text(
                user['company']['catchPhrase'],
                style: const TextStyle(
                    color: Colors.black54, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8), // Space between each info row
      child: RichText(
        text: TextSpan(
          text: "$label: ",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black87),
          children: [
            TextSpan(
                text: value,
                style: TextStyle(color: valueColor ?? Colors.black87)),
          ],
        ),
      ),
    );
  }
}
