import 'package:flutter/material.dart';

import '../../../../../../shared/presentation/ui/custom/widgets/custom_progress_spinner.dart';
import '../../../../../../shared/presentation/ui/custom/widgets/empty_view.dart';
import '../../../../../../stack/core/ioc/service_locator.dart';
import '../../../../../../stack/core/popup/popup_manager.dart';

class PaginatableListView<T extends Object> extends StatefulWidget {
  const PaginatableListView({
    super.key,
    required this.items,
    this.itemSpacing,
    required this.pageSize,
    this.maxItemCount,
    required this.errorMessage,
    this.emptyMessage,
    this.padding,
    required this.onPagination,
  });

  final List<PaginatableListViewItem<T>> items;
  final double? itemSpacing;
  final int pageSize;
  final int? maxItemCount;
  final String errorMessage;
  final String? emptyMessage;
  final EdgeInsets? padding;
  final Future<bool> Function(int pageNum) onPagination;

  @override
  State<PaginatableListView<T>> createState() => _PaginatableListViewState<T>();
}

class _PaginatableListViewState<T extends Object>
    extends State<PaginatableListView<T>> {
  late ScrollController _scrollController;
  late List<PaginatableListViewItem<T>> _items;
  int _currentPageNum = 1;
  bool _isFirstLoading = false;
  bool _isLoadingPage = false;

  bool _isFirstLoadFailed = false;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
    _scrollController = ScrollController()..addListener(_onScroll);
    _executeFirstLoad();
  }

  @override
  void didUpdateWidget(covariant PaginatableListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _items = widget.items;
    if (widget.items.length != oldWidget.items.length &&
        !_hasReachedMax() &&
        widget.items.length < widget.pageSize) {
      _executePagination();
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = _items.where((item) => item.isVisible);
    final itemsLength = _animateCallback(visibleItems.length);

    if (_isFirstLoadFailed) {
      return _buildErrorView();
    }
    if (_isFirstLoading && itemsLength == 0) {
      return const CustomProgressSpinner();
    } else if (visibleItems.isEmpty && widget.emptyMessage != null) {
      return _buildEmptyView(widget.emptyMessage);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: widget.padding?.top),
        Expanded(
          child: visibleItems.isEmpty && widget.emptyMessage != null
              ? _buildEmptyView(widget.emptyMessage)
              : _buildListView(
                  visibleItems.toList(),
                  itemsLength,
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Helpers
  void _executeFirstLoad() async {
    if (widget.items.length >= widget.pageSize ||
        _isLoadingPage ||
        _hasReachedMax()) {
      return;
    }
    _isFirstLoading = true;
    _isLoadingPage = true;
    final isPaginationSuccessful = await widget.onPagination(
      _currentPageNum,
    );
    if (mounted) {
      setState(() {
        if (isPaginationSuccessful) {
          _currentPageNum++;
        } else {
          _isFirstLoadFailed = true;
        }
        _isLoadingPage = false;
        _isFirstLoading = false;
      });
    }
  }

  void _onScroll() async {
    if (_isBottom && !_isLoadingPage && !_hasReachedMax()) {
      if (mounted) setState(() => _isLoadingPage = true);
      await _executePagination();
      if (mounted) setState(() => _isLoadingPage = false);
    }
  }

  Future<void> _executePagination() async {
    _isFirstLoadFailed = false;
    final isSuccessful = await widget.onPagination(_currentPageNum);
    if (isSuccessful) {
      _currentPageNum++;
    } else {
      _showError();
    }
  }

  void _showError() {
    if (mounted) {
      locator<PopupManager>().showSnackBar(
        context,
        const Text('There was an error while loading, please try again.'),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll;
  }

  int _animateCallback(int itemsLength) {
    if (_isLoadingPage && itemsLength > 0) {
      // Increase items length by 1 to show spinner.
      itemsLength++;
      // Animate to bottom when spinner becomes visible.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients) return;
        _animateScrollTo(_scrollController.position.maxScrollExtent);
      });
    }
    return itemsLength;
  }

  void _animateScrollTo(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }

  bool _hasReachedMax() {
    return widget.maxItemCount != null &&
        widget.items.length >= widget.maxItemCount!;
  }

  Widget _buildListView(
    List<PaginatableListViewItem<T>> items,
    int itemsLength,
  ) {
    return ListView.builder(
      itemCount: itemsLength,
      padding: EdgeInsets.fromLTRB(
        widget.padding?.left ?? 0,
        (widget.padding?.top ?? 0) + 6,
        widget.padding?.right ?? 0,
        widget.padding?.bottom ?? 0,
      ),
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return _isLoadingPage && index == itemsLength - 1
            ? const Padding(
                padding: EdgeInsets.only(top: 16),
                child: CustomProgressSpinner(),
              )
            : Padding(
                padding: widget.itemSpacing != null &&
                        index < itemsLength - (_isLoadingPage ? 2 : 1)
                    ? EdgeInsets.only(bottom: widget.itemSpacing!)
                    : EdgeInsets.zero,
                child: items[index].widget,
              );
      },
    );
  }

  Widget _buildEmptyView(String? text) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Center(child: EmptyView.builder(text: text)),
    );
  }

  Widget _buildErrorView() {
    return _buildEmptyView(widget.errorMessage);
  }

  // - Helpers
}

class PaginatableListViewItem<T extends Object> {
  PaginatableListViewItem({
    required this.widget,
    this.isVisible = true,
    this.searchObject,
    this.searchTexts,
  });

  final Widget widget;
  final bool isVisible;
  final T? searchObject;
  final List<String>? searchTexts;

  PaginatableListViewItem<T> copyWith({
    Widget? widget,
    T? searchObject,
    List<String>? searchTexts,
    bool? isVisible,
  }) {
    return PaginatableListViewItem<T>(
      widget: widget ?? this.widget,
      searchObject: searchObject ?? this.searchObject,
      searchTexts: searchTexts ?? this.searchTexts,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
