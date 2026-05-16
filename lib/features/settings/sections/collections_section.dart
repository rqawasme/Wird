import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/collection.dart';
import '../../../data/models/collection_selection.dart';
import '../../../data/providers/content_providers.dart';
import '../../../data/providers/user_state_providers.dart';
import '../../../theme/mihrab_theme_extension.dart';
import '../../preview/preview_modal.dart';

class CollectionsSection extends ConsumerWidget {
  const CollectionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final collectionsAsync = ref.watch(collectionsRepositoryProvider);
    final selections = ref.watch(collectionSelectionsControllerProvider);
    final selectionsCtl =
        ref.read(collectionSelectionsControllerProvider.notifier);

    final enabled = selections.where((s) => s.enabled).toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Header('COLLECTIONS'),
        const SizedBox(height: 10),
        collectionsAsync.when(
          loading: () => const SizedBox(
              height: 56, child: Center(child: CircularProgressIndicator()),),
          error: (e, _) => Text('Could not load: $e',
              style: theme.textTheme.bodySmall,),
          data: (collections) {
            final byId = {for (final c in collections) c.id: c};
            return Column(
              children: [
                for (final c in collections) ...[
                  _ToggleTile(
                    collection: c,
                    isSelected: selections
                        .any((s) => s.collectionId == c.id && s.enabled),
                    onToggle: () async {
                      final existing =
                          selections.firstWhere(
                        (s) => s.collectionId == c.id,
                        orElse: () => CollectionSelection(collectionId: c.id),
                      );
                      await selectionsCtl.setEnabled(
                        c.id,
                        enabled: !existing.enabled,
                      );
                    },
                    onPreview: () =>
                        PreviewModal.show(context, wird: null, collection: c),
                  ),
                  const SizedBox(height: 8),
                ],
                if (enabled.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const _Header('ORDER ON HOME'),
                  const SizedBox(height: 6),
                  _ReorderableList(
                    selections: enabled,
                    byId: byId,
                    onReorder: (ids) async => selectionsCtl.reorder(ids),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.collection,
    required this.isSelected,
    required this.onToggle,
    required this.onPreview,
  });

  final Collection collection;
  final bool isSelected;
  final VoidCallback onToggle;
  final VoidCallback onPreview;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? theme.colorScheme.primary : m.borderSubtle,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color:
                    isSelected ? theme.colorScheme.primary : m.mutedForeground,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collection.name,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      collection.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: m.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Preview',
                onPressed: onPreview,
                icon: const Icon(Icons.visibility_outlined),
                color: m.mutedForeground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReorderableList extends StatelessWidget {
  const _ReorderableList({
    required this.selections,
    required this.byId,
    required this.onReorder,
  });

  final List<CollectionSelection> selections;
  final Map<String, Collection> byId;
  final ValueChanged<List<String>> onReorder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final m = context.mihrab;
    return ReorderableListView.builder(
      shrinkWrap: true,
      buildDefaultDragHandles: true,
      physics: const NeverScrollableScrollPhysics(),
      onReorder: (oldIndex, newIndex) {
        final ids = selections.map((s) => s.collectionId).toList();
        var to = newIndex;
        if (to > oldIndex) to -= 1;
        final id = ids.removeAt(oldIndex);
        ids.insert(to, id);
        onReorder(ids);
      },
      itemCount: selections.length,
      itemBuilder: (context, i) {
        final sel = selections[i];
        final c = byId[sel.collectionId];
        return Padding(
          key: ValueKey(sel.collectionId),
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: m.borderSubtle),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.drag_indicator, color: m.mutedForeground),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    c?.name ?? sel.collectionId,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.labelSmall?.copyWith(
        color: context.mihrab.mutedForeground,
        letterSpacing: 1.4,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
