import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  static const routeName = '/support';
  
  const SupportScreen({super.key});

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@agrireach.com',
      query: 'subject=Support Request',
    );
    
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '+18005551234',
    );
    
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        backgroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Our support team is here to help you with any questions or issues you may have.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            _buildSupportOption(
              context,
              icon: Icons.email,
              title: 'Email Us',
              subtitle: 'Get in touch via email and we\'ll respond within 24 hours.',
              onTap: _launchEmail,
            ),
            const SizedBox(height: 16),
            _buildSupportOption(
              context,
              icon: Icons.phone,
              title: 'Call Us',
              subtitle: 'Speak directly with our support team.',
              onTap: _launchPhone,
            ),
            const SizedBox(height: 16),
            _buildSupportOption(
              context,
              icon: Icons.chat_bubble,
              title: 'Live Chat',
              subtitle: 'Chat with a support agent in real-time.',
              onTap: () {
                // Implement live chat functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Live chat will be available soon!')),
                );
              },
            ),
            const SizedBox(height: 32),
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFAQItem(
              context,
              'How do I track my order?',
              'You can track your order in the Orders section of the app. Once your order is shipped, you\'ll receive a tracking number.',
            ),
            _buildFAQItem(
              context,
              'What is your return policy?',
              'We accept returns within 30 days of purchase. Please contact our support team to initiate a return.',
            ),
            _buildFAQItem(
              context,
              'How can I update my payment method?',
              'You can update your payment method in the Account section of the app.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green[50],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.green[800]),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
