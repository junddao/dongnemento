import 'package:base_project/global/model/etc/kakao_local_result.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/util.dart';
import 'package:flutter/material.dart';

import '../../global/repository/map_repository.dart';
import '../../global/style/du_colors.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => '가고싶은 주소를 입력하세요.';

  @override
  TextStyle get searchFieldStyle => DUTextStyle.size14.grey2;

  final addresses = ValueNotifier<List<KakaoLocalResult>>([]);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 2) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "한글자 이상 입력해주세요.",
            ),
          )
        ],
      );
    }
    return FutureBuilder(
        future: _loadData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          } else if (snapshot.data.isNullEmpty) {
            return const Column(
              children: <Widget>[
                Text(
                  "검색된 주소가 없습니다.",
                ),
              ],
            );
          } else {
            var items = snapshot.data;
            return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = items[index];
                  return ListTile(
                    onTap: () {
                      double x = double.parse(data.x);
                      double y = double.parse(data.y);

                      Navigator.pop(context, (x, y));
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.address_name, style: DUTextStyle.size14),
                        const SizedBox(height: 4),
                        Text(
                          data.address_name,
                          style: DUTextStyle.size12.copyWith(color: DUColors.gray3),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: items!.length);
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 2) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "한글자 이상 입력해주세요.",
            ),
          )
        ],
      );
    }
    return FutureBuilder(
        future: _loadData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          } else if (snapshot.data.isNullEmpty) {
            return const Column(
              children: <Widget>[
                Text(
                  "검색된 주소가 없습니다.",
                ),
              ],
            );
          } else {
            var items = snapshot.data;
            return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = items[index];
                  return ListTile(
                    onTap: () {
                      double x = double.parse(data.x);
                      double y = double.parse(data.y);

                      Navigator.pop(context, (x, y));
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.address_name, style: DUTextStyle.size14),
                        const SizedBox(height: 4),
                        Text(
                          data.address_name,
                          style: DUTextStyle.size12.copyWith(color: DUColors.gray3),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: items!.length);
          }
        });
  }

  Future<List<KakaoLocalResult>> _loadData() async {
    List<KakaoLocalResult> items = [];

    KakaoLocalResponseData results = await MapRepository.instance.getKakaoAddressByKeyword(query);

    for (KakaoLocalResult result in results.documents) {
      items.add(result);
    }

    return items;
  }
}
