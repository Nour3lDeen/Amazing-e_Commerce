import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/sections_model/sections_model.dart';
import 'package:ecommerce/view/screens/categories/components/bottom_buttons_component/bottom_buttons_component.dart';
import 'package:ecommerce/view/screens/categories/components/choose_color_component/choose_color_component.dart';
import 'package:ecommerce/view/screens/categories/components/favorite_component/favorite_component.dart';
import 'package:ecommerce/view/screens/categories/components/share_component/share_component.dart';
import 'package:ecommerce/view/screens/categories/components/size_drop_down/size_drop_down.dart';
import 'package:ecommerce/view/screens/categories/product_details/components/images_preview_comopnent/images_preview_component.dart';
import 'package:ecommerce/view_model/cubits/products/products_cubit.dart';
import 'package:ecommerce/view_model/utils/Texts/Texts.dart';
import 'package:ecommerce/view_model/utils/app_assets/app_assets.dart';
import 'package:ecommerce/view_model/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../home/bottom_nav_bar/components/offers_component/product_card.dart';
import '../components/counter_component/counter_component.dart';
import 'components/video_preview_component/video_preview_component.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productId,
    required this.title,
    required this.product,
  });

  final Products product;
  final int productId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final cubit = ProductsCubit.get(context);

        bool hasDiscount = product.sizes
                ?.firstWhere(
                  (element) => element.sizeCode == cubit.selectedSize,
                  orElse: () => Sizes(sizeCode: '', discountPrice: '0'),
                )
                .discountPrice !=
            '0';

        return Scaffold(
          backgroundColor: AppColors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height / 2,
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 38.h, bottom: 70.h),
                          decoration: BoxDecoration(
                            color: AppColors.grey.withValues(alpha: 0.2),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                cubit.peekStack() ?? cubit.imageUrl,
                              ),
                            ),
                          ),
                          child: Stack(children: [
                            Column(
                              children: [
                                // Top Icons (Back, Favorite, Share)
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);

                                        cubit.popFromStack();

                                        cubit.changeColorCheck(
                                            product.colors![0].id!);
                                        cubit.changeFilterSelected(
                                            product.categoryId!);
                                        cubit.getCategoryProduct(
                                            product.categoryId!);
                                      },
                                      child: SvgPicture.asset(
                                        AppAssets.backIcon1,
                                        height: 24.h,
                                        width: 24.w,
                                      ),
                                    ),
                                    const Spacer(),
                                    FavoriteComponent(productId: productId),
                                    SizedBox(width: 10.w),
                                    const ShareComponent(),
                                  ],
                                ),
                                const Spacer(),
                                ImagesPreviewComponent(
                                  product: product,
                                )
                              ],
                            ),
                            FutureBuilder(
                              future: precacheImage(
                                CachedNetworkImageProvider(
                                    cubit.peekStack() ?? cubit.imageUrl),
                                context,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: LoadingAnimationWidget.inkDrop(
                                      color: AppColors.primaryColor,
                                      size: 30.sp,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Icon(Icons.error),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ]),
                        );
                      },
                    ),
                    Transform.translate(
                      offset: Offset(0, -52.h),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.r),
                          topRight: Radius.circular(32.r),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                left: 16.w, right: 16.w, top: 12.h),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.r),
                                topRight: Radius.circular(32.r),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: Image.asset(
                                  AppAssets.customBack,
                                  height: double.infinity,
                                  width: double.infinity,
                                ).image,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Name and Rating
                                Row(
                                  children: [
                                    TextTitle(
                                      product.name!,
                                      color: AppColors.primaryColor,
                                      fontSize: 18.sp,
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: List.generate(3, (index) {
                                        return Padding(
                                          padding: EdgeInsets.only(left: 4.w),
                                          child:
                                              SvgPicture.asset(AppAssets.star),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      spacing: 4.h,
                                      children: [
                                        Visibility(
                                          visible: hasDiscount,
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 2.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      HexColor('#FD6C6C'),
                                                      HexColor('#B84141'),
                                                    ],
                                                  )),
                                              child: TextBody14(
                                                'خصم ${product.sizes!.firstWhere(
                                                      (element) =>
                                                          element.sizeCode ==
                                                          ProductsCubit.get(
                                                                  context)
                                                              .selectedSize,
                                                      orElse: () => Sizes(
                                                          basicPrice: '0'),
                                                    ).discountRate} %',
                                                color: AppColors.white,
                                              )),
                                        ),
                                        Row(
                                          children: [
                                            Visibility(
                                              visible: hasDiscount,
                                              child: Align(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                child: Text(
                                                    '${cubit.sizes.firstWhere((element) => element.sizeCode == cubit.selectedSize, orElse: () => Sizes(basicPrice: '0')).basicPrice} ر.س',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Lamar',
                                                      fontSize: 10.sp,
                                                      color: Colors.red
                                                          .withValues(
                                                              alpha: 0.7),
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          Colors.red.withValues(
                                                              alpha: 0.8),
                                                      decorationThickness: 1.5,
                                                    )),
                                              ),
                                            ),
                                            Visibility(
                                                visible: hasDiscount,
                                                child: SizedBox(width: 8.w)),
                                            TextBody14(
                                              '${product.sizes!.firstWhere(
                                                    (element) =>
                                                        element.sizeCode ==
                                                        ProductsCubit.get(
                                                                context)
                                                            .selectedSize,
                                                    orElse: () =>
                                                        Sizes(basicPrice: '0'),
                                                  ).basicPrice} ر.س',
                                              color: AppColors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    SizeDropdown(
                                      sizes: product.sizes!,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                ChooseColorComponent(
                                  product: product,
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  spacing: 6.w,
                                  children: [
                                    TextBody14(
                                      'القطع المتوفرة',
                                      color: AppColors.black,
                                    ),
                                    TextBody14(product.stock!),
                                    const Spacer(),
                                    CounterComponent(
                                      productId: productId,
                                      cart: false,
                                      productCount: 1,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 6.w,
                                  children: [
                                    const TextBody14('العلامة التجارية:'),
                                    GestureDetector(
                                      onTap: () {
                                        debugPrint(product.brandName!);
                                      },
                                      child: TextBody14(
                                        product.brandName!,
                                        color: HexColor('#0082C8'),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),

                                Visibility(
                                  visible: hasDiscount,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: TextTitle(
                                          'تفاصيل العرض',
                                          color: HexColor('#FD6868'),
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Center(
                                        child: TextBody14(
                                          'اشتري 5 قطع من تيشرت ميلتون رجالي بسعر 3 قطع فقط وايضا خصم علي شحن المنتج 40%. ',
                                          color: AppColors.black,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                    ],
                                  ),
                                ),

                                TextTitle(
                                  'وصف المنتج',
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(height: 6.h),

                                Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: TextBody14(
                                    product.description!
                                        .replaceAll(RegExp(r'<br\s*/?>'), '\n')
                                        .replaceAll(RegExp(r'&nbsp;'), '')
                                        .replaceAll(RegExp(r'<[^>]*>'), '')
                                        .trim(),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Center(
                                  child: TextTitle(
                                    'فيديو توضيحي للمنتج',
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: VideoPreviewComponent(
                                    videoUrl: product.video!,
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextTitle(
                                      'منتجات أخرى',
                                      color: AppColors.primaryColor,
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        TextBody14(
                                          'المزيد',
                                          color: AppColors.grey,
                                        ),
                                        SizedBox(width: 6.w),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 14,
                                          color: AppColors.grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  clipBehavior: Clip.none,
                                  child: Row(
                                    spacing: 12.w,
                                    children: List.generate(
                                        cubit.products.length-1 , (index) {
                                      final product = cubit.products
                                          .where((product) =>
                                              product.id != productId)
                                          .first;
                                      return ProductCard(
                                        title: product.name!,
                                        image: product
                                            .colors!.first.images!.first.url!,
                                        fromHome: false,
                                        productId: product.id!,
                                        hasDiscount: false,
                                      );
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  height: 60.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BottomButtonsComponent(
                product: product,
              )
            ],
          ),
        );
      },
    );
  }
}
