import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';
import 'package:rick_and_morty_app/features/settings/presentation/blocs/blocs.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class LocationView extends StatelessWidget {
  final Location location;

  const LocationView({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(
          location: location,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _LocationDetails(
              location: location,
            ),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

class _LocationDetails extends StatelessWidget {
  final Location location;

  const _LocationDetails({
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final type = AppLocalizations.of(context)
        .translate(LocationUtils.getType(location.type));
    final dimension = AppLocalizations.of(context)
        .translate(LocationUtils.dimensionValue(location.dimension));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemToShow(
          title: 'name',
          subtitle: location.name,
          icon: Icons.location_on_outlined,
        ),
        ItemToShow(
          title: 'type',
          subtitle: type.isEmpty ? location.type : type,
          icon: Icons.flag,
        ),
        ItemToShow(
          title: 'dimension',
          subtitle: dimension.isEmpty ? location.dimension : dimension,
          icon: Icons.map,
        ),
        ItemToShow(
          title: 'created',
          subtitle: context.select(
            (SettingsCubit settingsCubit) => HumanFormats.shortDate(
              location.created,
              settingsCubit.state.language,
            ),
          ),
          icon: Icons.today_outlined,
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElementsByEntity(
          title: 'residents',
          entity: location,
        ),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Location location;

  const _CustomSliverAppBar({
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyle = Theme.of(context).textTheme.titleLarge;

    return SliverAppBar(
      expandedHeight: size.height * 0.3,
      backgroundColor: scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsetsDirectional.only(bottom: 0.0),
        title: TitleSliverAppBar(
          title: location.name,
          textStyle: textStyle,
          gradientColor: scaffoldBackgroundColor,
        ),
        background: CustomGradient(
          stops: const [0.2, 1.0],
          colors: [
            colors.surfaceVariant,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
