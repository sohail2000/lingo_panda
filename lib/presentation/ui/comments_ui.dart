import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_panda/data/models/comment_model.dart';
import 'package:lingo_panda/styling/custom_colors.dart';
import 'package:lingo_panda/styling/custom_text_styles.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
    required this.shouldMaskEmail,
  });

  final CommentModel comment;
  final bool shouldMaskEmail;

  String maskEmail(String email) {
  if (shouldMaskEmail && email.contains('@')) {
    String username = email.split('@')[0];
    if (username.length > 3) {
      return '${username.substring(0, 3)}****@${email.split('@')[1]}';
    }
  }
  return email;
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: CustomColors.lightGrey,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[400],
                child: Text(
                  comment.name[0].toUpperCase(),
                  style: CustomTextStyle.blackBold18
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: CustomTextStyle.blackRegular14,
                        children: [
                          const TextSpan(
                            text: 'Name: ',
                            style: CustomTextStyle.lightGreyRegular14,
                          ),
                          TextSpan(
                            text: comment.name,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        style: CustomTextStyle.blackRegular14,
                        children: [
                          const TextSpan(
                            text: 'Email: ',
                            style: CustomTextStyle.lightGreyRegular14,
                          ),
                          TextSpan(
                            text: maskEmail(comment.email),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      comment.body,
                      // style: const TextStyle(
                      //   fontSize: 14,
                      //   color: Colors.black87,
                      // ),
                      style: CustomTextStyle.blackRegular14,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({
    super.key,
  });

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CustomColors.lightGrey,
      surfaceTintColor: CustomColors.lightGrey,
      title: const Text('Logout'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await _logout();
            context.pop();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
