// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class SearchTile extends StatelessWidget {
//   const SearchTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.grey.shade900,
//         child: _foundedUsers.length > 0 ? ListView.builder(
//           itemCount: _foundedUsers.length,
//           itemBuilder: (context, index) {
//             return Slidable(
//               actionPane: SlidableDrawerActionPane(),
//               actionExtentRatio: 0.25,
//               child: userComponent(user: _foundedUsers[index]),
//               actions: <Widget>[
//                 new IconSlideAction(
//                   caption: 'Archive',
//                   color: Colors.transparent,
//                   icon: Icons.archive,

//                   onTap: () => print("archive"),
//                 ),
//                 new IconSlideAction(
//                   caption: 'Share',
//                   color: Colors.transparent,
//                   icon: Icons.share,
//                   onTap: () => print('Share'),
//                 ),
//               ],
//               secondaryActions: <Widget>[
//                 new IconSlideAction(
//                   caption: 'More',
//                   color: Colors.transparent,
//                   icon: Icons.more_horiz,
//                   onTap: () => print('More'),
//                 ),
//                 new IconSlideAction(
//                   caption: 'Delete',
//                   color: Colors.transparent,
//                   icon: Icons.delete,
//                   onTap: () => print('Delete'),
//                 ),
//               ],
//             );
//           }) : Center(child: Text("No users found", style: TextStyle(color: Colors.white),)),
//       );
//   }

//   userComponent({required User user}) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 20),
//       padding: EdgeInsets.only(top: 10, bottom: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 60,
//                 height: 60,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: Image.network(user.image),
//                 )
//               ),
//               SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(user.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
//                   SizedBox(height: 5,),
//                   Text(user.username, style: TextStyle(color: Colors.grey[500])),
//                 ]
//               )
//             ]
//           ),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 user.isFollowedByMe = !user.isFollowedByMe;
//               });
//             },
//             child: AnimatedContainer(
//               height: 35,
//               width: 110,
//               duration: Duration(milliseconds: 300),
//               decoration: BoxDecoration(
//                 color: user.isFollowedByMe ? Colors.blue[700] : Color(0xffffff),
//                 borderRadius: BorderRadius.circular(5),
//                 border: Border.all(color: user.isFollowedByMe ? Colors.transparent : Colors.grey.shade700,)
//               ),
//               child: Center(
//                 child: Text(user.isFollowedByMe ? 'Unfollow' : 'Follow', style: TextStyle(color: user.isFollowedByMe ? Colors.white : Colors.white))
//               )
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
