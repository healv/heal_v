import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/common/widget/meditation_breathing_categories_widget.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<StatefulWidget> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.search(
        title: tr('meditation'),
        isBackEnable: false,
        onSearchTextChanged: (value) {},
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        _categories(context),
      ],
    );
  }

  Widget _categories(BuildContext context) {
    return BlocBuilder<MeditationPageBloc, MeditationPageState>(
      builder: (BuildContext context, MeditationPageState state) {
        final categories = state.categories;
        return SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: state.categoriesLoading == true
                ? const MeditationBreathingCategoriesWidget.loading()
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        context.read<MeditationPageBloc>().add(MeditationPageEvent.updateCategory(category: categories![index]));
                      },
                      child: MeditationBreathingCategoriesWidget(
                        name: categories?[index].name ?? emptyString,
                        id: categories?[index].id ?? emptyString,
                        selected: state.selectedCategory == categories?[index],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(width: 8.0),
                    itemCount: categories?.length ?? 0,
                  ),
          ),
        );
      },
    );
  }
}
