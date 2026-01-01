import 'package:flutter/material.dart';
import '/models/contact_model.dart';

class ContactWidget extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onCall;

  const ContactWidget({
    super.key,
    required this.contact,
    required this.onTap,
    required this.onDelete,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF818CF8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              contact.name[0].toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF1F2937),
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.phone, size: 14, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              contact.phoneNumber,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Tooltip(
                message: 'Call',
                child: IconButton(
                  icon: const Icon(Icons.phone, color: Colors.green),
                  iconSize: 20,
                  onPressed: onCall,
                  splashRadius: 20,
                ),
              ),
              Tooltip(
                message: 'Delete',
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  iconSize: 20,
                  onPressed: onDelete,
                  splashRadius: 20,
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
