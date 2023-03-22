import 'package:base_project/global/bloc/auth/block_user/block_user_cubit.dart';
import 'package:base_project/global/bloc/auth/get_user/cubit/get_user_cubit.dart';
import 'package:base_project/global/bloc/map/get_pin/get_pin_cubit.dart';
import 'package:base_project/global/bloc/reply/create_pin_reply/create_pin_reply_cubit.dart';
import 'package:base_project/global/bloc/reply/get_pin_replies/get_pin_replies_cubit.dart';
import 'package:base_project/global/bloc/report/cubit/create_report_cubit.dart';
import 'package:base_project/global/component/du_photo_view.dart';
import 'package:base_project/global/model/hate/model_request_set_pin_hate.dart';
import 'package:base_project/global/model/like/model_request_set_pin_like.dart';
import 'package:base_project/global/model/pin/model_request_create_pin_reply.dart';
import 'package:base_project/global/model/pin/model_response_get_pin.dart';
import 'package:base_project/global/model/reply/model_response_pin_replies.dart';
import 'package:base_project/global/model/report/model_request_report.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_button.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:base_project/pages/common/error_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../global/component/du_profile.dart';
import '../../global/model/user/model_request_block.dart';
import '../../routes.dart';

class PagePostDetail extends StatefulWidget {
  const PagePostDetail({
    super.key,
    required this.id,
  });

  final String id;
  @override
  State<PagePostDetail> createState() => _PagePostDetailState();
}

class _PagePostDetailState extends State<PagePostDetail> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetPinCubit()..getPin(widget.id),
        ),
        BlocProvider(
          create: (context) => CreatePinReplyCubit(),
        ),
        BlocProvider(
          create: (context) => GetPinRepliesCubit()..getPinReplies(widget.id),
        ),
        BlocProvider(
          create: (context) => CreateReportCubit(),
        ),
        BlocProvider(
          create: (context) => BlockUserCubit(),
        ),
        BlocProvider(
          create: (context) => GetUserCubit(),
        )
      ],
      child: PagePostDetailView(id: widget.id),
    );
  }
}

class PagePostDetailView extends StatefulWidget {
  const PagePostDetailView({super.key, required this.id});
  final String id;
  @override
  State<PagePostDetailView> createState() => _PagePostDetailViewState();
}

class _PagePostDetailViewState extends State<PagePostDetailView> {
  final TextEditingController _tecMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      extendBodyBehindAppBar: true,
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () {
          context.pop();
        },
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _body() {
    return BlocBuilder<GetPinCubit, GetPinState>(
      builder: (context, state) {
        if (state is GetPinLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetPinError) {
          return ErrorPage(exception: state.errorMessage);
        }
        if (state is GetPinLoaded) {
          final value = context.watch<CreatePinReplyCubit>();
          if (value.state is CreatePinReplyLoaded) {
            context.read<GetPinRepliesCubit>().getPinReplies(widget.id);
          }
          ResponsePin pin = state.result.data!.first;

          context.read<GetUserCubit>().getUser(pin.userId!);

          return BlocBuilder<GetUserCubit, GetUserState>(
            builder: (context, state) {
              if (state is GetUserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetUserError) {
                return ErrorPage(exception: state.errorMessage);
              }
              if (state is GetUserLoaded) {
                if (state.user.isBlocked == true) {
                  return Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Center(child: const Text('차단된 사용자 입니다.\n\n모든 사용자의 글은 차단됩니다.'))),
                        Row(
                          children: [
                            Expanded(
                              child: DUButton(
                                  width: double.infinity,
                                  // type: ButtonType.dark,
                                  text: '나가기',
                                  press: () {
                                    context.pop();
                                  }),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DUButton(
                                  width: double.infinity,
                                  text: '차단해제',
                                  press: () {
                                    ModelRequestBlock modelRequestBlock =
                                        ModelRequestBlock(userId: pin.userId!, isBlocked: false);
                                    context.read<BlockUserCubit>().blockUser(modelRequestBlock);
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return BlocConsumer<CreateReportCubit, CreateReportState>(
                    listener: (context, state) {
                      if (state is CreateReportLoaded) {
                        context.push(Routes.confirm, extra: {
                          'title': '신고하기',
                          'contents1': '신고가 정상적으로 접수되었습니다.',
                          'contents2': '다수의 사용자가 해당글을 신고할 경우\n해당 글은 삭제처리 됩니다.'
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is CreateReportLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CreateReportError) {
                        return ErrorPage(exception: state.errorMessage);
                      }

                      return BlocConsumer<BlockUserCubit, BlockUserState>(
                        listener: (context, state) {
                          if (state is BlockUserLoaded) {
                            context.push(Routes.confirm, extra: {
                              'title': '차단하기',
                              'contents1': '해당 유저가 정상적으로 차단되었습니다.',
                              'contents2': '해당 유저의 글들은 blind 처리 됩니다.'
                            });
                          }
                        },
                        builder: (context, state) {
                          if (state is BlockUserLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is BlockUserError) {
                            return ErrorPage(exception: state.errorMessage);
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      DUPhotoView(
                                        imageUrls: [...pin.images ?? []],
                                        screenHeight: (SizeConfig.screenHeight * 0.4),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _buildUserProfile(pin),
                                            const Divider(height: 8),
                                            Text(pin.title!, style: DUTextStyle.size18B),
                                            const SizedBox(height: 20),
                                            Text(pin.body ?? '글이 없어요.'),
                                            const SizedBox(height: 16),
                                            Row(
                                              children: [
                                                pin.isLiked == false
                                                    ? InkWell(
                                                        child: const Icon(
                                                          Icons.thumb_up_outlined,
                                                          size: 18,
                                                        ),
                                                        onTap: () {
                                                          ModelRequestSetPinLike modelRequestSetPinLike =
                                                              ModelRequestSetPinLike(pinId: pin.id ?? '');
                                                          context
                                                              .read<GetPinCubit>()
                                                              .setPinLike(modelRequestSetPinLike, true);
                                                        },
                                                      )
                                                    : InkWell(
                                                        child: const Icon(
                                                          Icons.thumb_up,
                                                          color: DUColors.tomato,
                                                          size: 18,
                                                        ),
                                                        onTap: () {
                                                          ModelRequestSetPinLike modelRequestSetPinLike =
                                                              ModelRequestSetPinLike(pinId: pin.id ?? '');
                                                          context
                                                              .read<GetPinCubit>()
                                                              .setPinLike(modelRequestSetPinLike, false);
                                                        },
                                                      ),
                                                const SizedBox(width: 6),
                                                Text('${pin.likeCount ?? 0}', style: DUTextStyle.size10.grey1),
                                                const SizedBox(width: 12),
                                                pin.isHated == false
                                                    ? InkWell(
                                                        child: const Icon(
                                                          Icons.thumb_down_outlined,
                                                          size: 18,
                                                        ),
                                                        onTap: () {
                                                          ModelRequestSetPinHate modelRequestSetPinHate =
                                                              ModelRequestSetPinHate(pinId: pin.id ?? '');
                                                          context
                                                              .read<GetPinCubit>()
                                                              .setPinHate(modelRequestSetPinHate, true);
                                                        },
                                                      )
                                                    : InkWell(
                                                        child: const Icon(
                                                          Icons.thumb_down,
                                                          color: DUColors.facebook_blue,
                                                          size: 18,
                                                        ),
                                                        onTap: () {
                                                          ModelRequestSetPinHate modelRequestSetPinHate =
                                                              ModelRequestSetPinHate(pinId: pin.id ?? '');
                                                          context
                                                              .read<GetPinCubit>()
                                                              .setPinHate(modelRequestSetPinHate, false);
                                                        },
                                                      ),
                                                const SizedBox(width: 6),
                                                Text('${pin.hateCount ?? 0}', style: DUTextStyle.size10.grey1),
                                                const Spacer(),
                                                TextButton(
                                                  onPressed: () async {
                                                    await showCupertinoModalPopup<int>(
                                                      context: context,
                                                      builder: (BuildContext context) => CupertinoActionSheet(
                                                          title: const Text('신고 / 차단'),
                                                          message: const Text('신고, 차단한 사용자의 글은\n 지도상에 표시되지 않습니다.'),
                                                          actions: <CupertinoActionSheetAction>[
                                                            CupertinoActionSheetAction(
                                                              child: const Text('신고하기'),
                                                              onPressed: () async {
                                                                Navigator.of(context).pop(0);
                                                              },
                                                            ),
                                                            CupertinoActionSheetAction(
                                                              child: const Text('차단하기'),
                                                              onPressed: () async {
                                                                Navigator.of(context).pop(1);
                                                              },
                                                            ),
                                                          ],
                                                          cancelButton: CupertinoActionSheetAction(
                                                            child: const Text('취소'),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          )),
                                                    ).then((value) {
                                                      if (value == 0) {
                                                        ModelRequestReport modelRequestReport =
                                                            ModelRequestReport(pinId: pin.id!);
                                                        context
                                                            .read<CreateReportCubit>()
                                                            .createReport(modelRequestReport);
                                                      }
                                                      if (value == 1) {
                                                        ModelRequestBlock modelRequestBlock =
                                                            ModelRequestBlock(userId: pin.userId!, isBlocked: true);
                                                        context.read<BlockUserCubit>().blockUser(modelRequestBlock);
                                                      }
                                                    });
                                                  },
                                                  child: Text('신고하기', style: DUTextStyle.size12B.tomato),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            const Divider(
                                              thickness: 1,
                                            ),
                                            BlocBuilder<GetPinRepliesCubit, GetPinRepliesState>(
                                              builder: (context, state) {
                                                List<PinReplies>? replies;
                                                if (state is GetPinRepliesLoading) {
                                                  return const Center(
                                                    child: CircularProgressIndicator(),
                                                  );
                                                }
                                                if (state is GetPinRepliesError) {
                                                  return const Center(
                                                    child: Text('댓글을 가져오지 못했습니다.'),
                                                  );
                                                }
                                                if (state is GetPinRepliesLoaded) {
                                                  replies = state.result.data?.reversed.toList() ?? [];
                                                }
                                                return _buildReviewList(replies ?? []);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              _buildMessageComposer(pin),
                            ],
                          );
                        },
                      );
                    },
                  );
                }
              }
              return Container();
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _buildUserProfile(ResponsePin pin) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: DUProfile(
        size: 40,
        profileUrl: pin.userProfileImage ?? '',
        // height: 30,
        // width: 30,
      ),
      title: Text(pin.userName ?? 'No name'),
      subtitle: Text(pin.updatedAt.toDateWithSeconds(), style: DUTextStyle.size10.grey2),
    );
  }

  Widget _buildReviewList(List<PinReplies> replies) {
    return replies.isEmpty
        ? emptyReview()
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: replies.length,
            itemBuilder: (context, index) {
              PinReplies reply = replies[index];
              // var data = provider.responseGetPinReplyData![index];
              return InkWell(
                onTap: () {
                  // _tecMessage.text = '@${data.name} ';
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(reply.userName, style: DUTextStyle.size12B),
                        const SizedBox(width: 16),
                        Text(reply.createdAt.toDateWithSeconds(), style: DUTextStyle.size10.grey2),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reply.reply,
                      style: DUTextStyle.size12,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(thickness: 1),
          );
  }

  Widget emptyReview() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('첫 리뷰를 남겨보세요. 😃'),
        ],
      ),
    );
  }

  Widget _buildMessageComposer(ResponsePin pin) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.add_a_photo),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFEFEFEF)),
                      borderRadius: BorderRadius.circular(21),
                      color: const Color(0xFFF8F8F8),
                    ),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _tecMessage,
                            onChanged: (value) {},
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration.collapsed(
                              hintText: '메세지를 입력하세요',
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.send),
                          ),
                          onTap: () {
                            // 리플 생성
                            ModelRequestCreatePinReply requestCreatePinReply = ModelRequestCreatePinReply(
                              pinId: pin.id,
                              reply: _tecMessage.text,
                            );
                            context.read<CreatePinReplyCubit>().createPinReply(requestCreatePinReply);
                            _tecMessage.clear();
                            FocusScope.of(context).unfocus();
                            // createReply();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
