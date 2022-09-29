void fcmSelectNotification({required String roomId}) async {
  // //xx 테스트 : 로그인을 했는지 살펴봅니다.
  // bool errorOccurred = false;
  // final authBloc = GetIt.I<AuthBloc>();
  // final postBloc = GetIt.I<PostBloc>();

  // //xx 테스트 : 로그인시는 빼주어야겠습니다. - 이 때는 myInfo가 로그인을 해주었는지 파악해보아야겠습니다.
  // if (authBloc.state.status == AuthStatus.userAuthenticated) {
  //   try {
  //     // searchListRooms을 호출합니다.
  //     DataOrFailure<ListRoomsResultEntity> result = await SingleAPIRequestUC.create(api.postRepo.listRooms).execute();
  //     if (result.isSuccess && result.data != null) {
  //       // roomId를 찾습니다.
  //       GetRoomResultEntity? room = result.data!.list.reversed.firstWhereOrNull((e) => e.id == roomId);
  //       if (room != null) {
  //         // 여기서 myInfo, otherInfo를 구합니다.
  //         //xx 이것을 꼭 여기서 구해주어야 할까요? 조금 생각해볼 문제입니다.
  //         //xx 위에서 구한 room 정보만으로 충분하지 않을까요?
  //         late JoinUserResult myUserInfo;
  //         late JoinUserResult othersUserInfo;

  //         room.joinUsers.forEach((element) {
  //           if (postBloc.isMe(element.phone)) {
  //             myUserInfo = element;
  //           } else {
  //             othersUserInfo = element;
  //           }
  //         });

  //         if (room.joinUsers[0].userId == room.joinUsers[1].userId) {
  //           myUserInfo = room.joinUsers[0];
  //           othersUserInfo = room.joinUsers[1];
  //         }

  //         late MessageUserInfo myInfo;
  //         late MessageUserInfo otherInfo;
  //         Contact otherUser;

  //         otherUser = postBloc.getMatchContact(phoneNumber: othersUserInfo.phone);
  //         myInfo = MessageUserInfo(
  //           name: PostBloc.currentUserEntity?.name ?? '알 수 없음',
  //           phone: PostBloc.currentUserEntity!.phone,
  //           id: myUserInfo.userId,
  //         );

  //         if (otherUser.phones?[0] == null) {
  //           otherInfo = MessageUserInfo(
  //             name: othersUserInfo.name,
  //             phone: othersUserInfo.phone,
  //             id: myUserInfo.userId,
  //           );
  //         } else {
  //           otherInfo = MessageUserInfo(
  //             name: otherUser.displayName ?? "알 수 없음",
  //             phone: otherUser.phones![0].value!,
  //             avatar: otherUser.avatar,
  //             initial: otherUser.initials(),
  //             id: myUserInfo.userId,
  //           );
  //         }

  //         //xx 전체 테스트를 해봅니다.

  //         //xx 테스트 : 현재 그 방에 들어가있는 상태이면 종료해야겠습니다.
  //         //xx 테스트 : PostDingdongDetailScreen.roomIds 는 너무나도 불필요해보입니다. 없앨 방법은 없을까요? ㅠ
  //         if (PostDingdongDetailScreen.roomIds.isEmpty) {
  //           DUNavigator.push(
  //               child: PostDingdongDetailScreen(
  //             roomId: roomId,
  //             myInfo: myInfo,
  //             otherInfo: otherInfo,
  //           ));
  //         } else if (PostDingdongDetailScreen.roomIds.last != roomId) {
  //           DUNavigator.pushReplacement(
  //               child: PostDingdongDetailScreen(
  //             roomId: roomId,
  //             myInfo: myInfo,
  //             otherInfo: otherInfo,
  //           ));
  //         }
  //       } else {
  //         errorOccurred = true;
  //       }
  //     } else {
  //       errorOccurred = true;
  //     }
  //   } catch (e) {
  //     errorOccurred = true;
  //   }
  // } else {
  //   flutterLocalAppLaunchDetailsPayload = roomId;
  // }

  // if (errorOccurred) {
  //   duShowSnackBar(content: '알림 페이지를 발견할 수 없습니다.');
  // }
}
