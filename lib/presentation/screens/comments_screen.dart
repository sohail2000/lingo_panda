import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_panda/data/models/comment_model.dart';
import 'package:lingo_panda/presentation/provider/comment_provider.dart';
import 'package:lingo_panda/presentation/ui/comments_ui.dart';
import 'package:lingo_panda/routing/routes.dart';
import 'package:lingo_panda/styling/custom_colors.dart';
import 'package:lingo_panda/styling/custom_text_styles.dart';
import 'package:lingo_panda/utlis/remote_config.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final ScrollController _scrollController = ScrollController();
  static const int totalComments = 500;
  bool shouldMaskEmail = true;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(Routes.login);
        });
      }else{
        shouldMaskEmail = await getEmailMaskingSetting();
        print('shouldMaskEmail ${shouldMaskEmail}');
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final commentProvider =
          Provider.of<CommentProvider>(context, listen: false);
      commentProvider.fetchComments();
    });

    _scrollController.addListener(() {
      final commentProvider =
          Provider.of<CommentProvider>(context, listen: false);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (commentProvider.hasMoreComments(totalComments)) {
          commentProvider.fetchComments();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LogoutConfirmationDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
          style: CustomTextStyle.whiteBold24,
        ),
        backgroundColor: CustomColors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white,),
            onPressed: _showLogoutDialog,
          ),
        ],
      ),
      backgroundColor: CustomColors.grey,
      body: Consumer<CommentProvider>(
        builder: (context, commentProvider, child) {
          if (commentProvider.isLoading && commentProvider.comments.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: commentProvider.comments.length + 1,
            itemBuilder: (context, index) {
              if (index == commentProvider.comments.length) {
                if (commentProvider.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }

              final CommentModel comment = commentProvider.comments[index];
              return CommentItem(comment: comment, shouldMaskEmail: shouldMaskEmail,);
            },
          );
        },
      ),
    );
  }
}

