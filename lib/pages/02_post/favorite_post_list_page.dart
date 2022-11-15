import 'package:base_project/global/component/du_app_bar.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/pages/02_post/components/cell_post_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoritePostListPage extends StatefulWidget {
  const FavoritePostListPage({super.key});

  @override
  State<FavoritePostListPage> createState() => _FavoritePostListPageState();
}

class _FavoritePostListPageState extends State<FavoritePostListPage> {
  @override
  Widget build(BuildContext context) {
    return const ProductPageView();
  }
}

class ProductPageView extends StatefulWidget {
  const ProductPageView({super.key});

  @override
  State<ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<ProductPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  DUAppBar _appBar() {
    return DUAppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: const Text('상품'),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CellPostItem(
                  id: index,
                  title: '텐퍼센트',
                  description: 'good description',
                  press: () {
                    onProduct(index);
                  },
                );
              },
              separatorBuilder: ((context, index) => const Divider(
                    color: DUColors.grey1,
                  )),
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }

  void onProduct(int id) {
    print(id);
    context.go(
      '/product/details/$id',
    );
  }
}
