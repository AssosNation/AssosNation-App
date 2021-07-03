import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/components/description_asso.dart';
import 'package:assosnation_app/components/dialog/association_informations_dialog.dart';
import 'package:assosnation_app/components/news_feed_card.dart';
import 'package:assosnation_app/services/firebase/firestore/association_service.dart';
import 'package:assosnation_app/services/firebase/firestore/gamification_service.dart';
import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:assosnation_app/services/firebase/firestore/posts_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/converters.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:assosnation_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AssociationDetails extends StatelessWidget {
  final Association assos;

  AssociationDetails(this.assos);

  _navigateToConversation(BuildContext context, String userId, userName) async {
    final result = await MessagingService()
        .initConversationIfNotFound(userId, assos.uid, userName, assos.name);
    if (result is Conversation) {
      Navigator.of(context).pushNamed("/convAsUser", arguments: result);
    } else
      Utils.displaySnackBarWithMessage(
          context, result.toString(), Colors.deepOrange);
  }

  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();

    return StreamBuilder<DocumentSnapshot>(
      stream: AssociationService().watchAssociationInfo(assos),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.active) {
            final Association _association =
                Converters.convertDocSnapshotsToAssos(snapshot.data!);
            return Scaffold(
              appBar: AppBar(
                title: Text(_association.name),
              ),
              body: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Image.network(
                            _association.banner,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.teal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  color: Colors.white,
                                  iconSize: 30,
                                  onPressed: () async {
                                    if (_user != null) {
                                      if (_association
                                          .didUserSubscribed(_user.uid)) {
                                        await AssociationService()
                                            .unsubscribeToAssociation(
                                                _association.uid, _user.uid);
                                        Utils.displaySnackBarWithMessage(
                                            context,
                                            AppLocalizations.of(context)!
                                                .unsubscribe,
                                            Colors.deepOrange);
                                        GamificationService()
                                            .decreaseSubCountByOne(
                                                _user.gamificationRef.id);
                                      } else {
                                        AssociationService()
                                            .subscribeToAssociation(
                                                _association.uid, _user.uid);
                                        Utils.displaySnackBarWithMessage(
                                            context,
                                            AppLocalizations.of(context)!
                                                .subscribe,
                                            Colors.green);
                                        GamificationService()
                                            .increaseSubCountByOne(
                                                _user.gamificationRef.id);
                                      }
                                    }
                                  },
                                  icon: Icon(
                                      _association.didUserSubscribed(_user!.uid)
                                          ? Icons.favorite_sharp
                                          : Icons.favorite_border_sharp),
                                ),
                              ],
                            ),
                            IconButton(
                                icon: Icon(Icons.message_outlined),
                                color: Colors.white,
                                iconSize: 30,
                                onPressed: () => _navigateToConversation(
                                    context,
                                    _user.uid,
                                    "${_user.firstName} ${_user.lastName}")),
                            IconButton(
                                icon: Icon(Icons.date_range),
                                color: Colors.white,
                                iconSize: 30,
                                onPressed: () => Navigator.of(context)
                                    .pushNamed("/associationCalendarPage",
                                        arguments: assos)),
                            IconButton(
                              icon: Icon(Icons.info_outline_rounded),
                              color: Colors.white,
                              iconSize: 30,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AssociationInformationsDialog(
                                        assos: _association);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                child:
                                    DescriptionAsso(_association.description)),
                            SizedBox(height: 10),
                            Divider(
                              thickness: 3,
                              indent: 15,
                              endIndent: 15,
                              color: Colors.teal,
                              height: 40,
                            ),
                            AnTitle(AppLocalizations.of(context)!
                                .user_tab_newsfeed),
                          ],
                        ),
                      ),
                      FutureBuilder(
                        future: PostService()
                            .retrieveAllPostsForAssociation(_association),
                        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
                          if (snapshot.hasData) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return CircularProgressIndicator();
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                              case ConnectionState.active:
                                break;
                              case ConnectionState.done:
                                List<Post> postList = snapshot.data!;
                                if (postList.isNotEmpty) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return NewsFeedCard(
                                          postList[index], '', _user.uid);
                                    },
                                    itemCount: postList.length,
                                  );
                                } else
                                  return Text(AppLocalizations.of(context)!
                                      .association_no_posts(_association.name));
                            }
                          }
                          if (snapshot.hasError) {
                            return Container(
                              child: Text(
                                  AppLocalizations.of(context)!.error_no_infos),
                            );
                          }
                          return Container();
                        },
                      ),
                    ]),
              ),
            );
          } else
            return CircularProgressIndicator();
        } else
          return Container();
      },
    );
  }
}
