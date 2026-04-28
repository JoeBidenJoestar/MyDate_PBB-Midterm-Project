import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/firestore_service.dart';
import '../../models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class _AutoRotatingImages extends StatefulWidget {
  final List<String> imageUrls;
  const _AutoRotatingImages({required this.imageUrls});

  @override
  State<_AutoRotatingImages> createState() => _AutoRotatingImagesState();
}

class _AutoRotatingImagesState extends State<_AutoRotatingImages> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.imageUrls.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
        if (mounted) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % widget.imageUrls.length;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return Container(color: Colors.grey[300], child: const Icon(Icons.person, size: 100, color: Colors.white));
    }
    final currentImage = widget.imageUrls[_currentIndex];
    Widget imageWidget;
    if (currentImage.startsWith('http')) {
      imageWidget = CachedNetworkImage(
        key: ValueKey<String>(currentImage),
        imageUrl: currentImage,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Container(color: Colors.grey[300], child: const Icon(Icons.person, size: 100, color: Colors.white)),
      );
    } else {
      try {
        imageWidget = Image.memory(
          base64Decode(currentImage),
          key: ValueKey<String>(currentImage),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300], child: const Icon(Icons.person, size: 100, color: Colors.white)),
        );
      } catch (e) {
        imageWidget = Container(key: ValueKey<String>(currentImage), color: Colors.grey[300], child: const Icon(Icons.error, size: 100, color: Colors.white));
      }
    }
    
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: imageWidget,
    );
  }
}


class SwipePage extends ConsumerStatefulWidget {
  const SwipePage({super.key});

  @override
  ConsumerState<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends ConsumerState<SwipePage> {
  final CardSwiperController controller = CardSwiperController();
  List<UserModel> _baddies = [];
  UserModel? _currentUser;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final authService = ref.read(authServiceProvider);
      final userStream = authService.authStateChanges;
      final fbUser = authService.currentUser;
      
      if (fbUser != null) {
        final firestoreService = ref.read(firestoreServiceProvider);
        _currentUser = await firestoreService.getUser(fbUser.uid);
        
        if (_currentUser != null) {
          if (_currentUser!.dateOfBirth == null || _currentUser!.dateOfBirth!.isEmpty) {
            setState(() {
              _errorMessage = 'You must fill in your age first (update your profile).';
            });
            return;
          }

          if (_currentUser!.photoUrls.isEmpty) {
            setState(() {
              _errorMessage = 'You must upload at least 1 picture in your profile to view others.';
            });
            return;
          }

          final oppositeGender = _currentUser!.gender == 'Male' ? 'Female' : 'Male';
          _baddies = await firestoreService.searchBaddies(
            _currentUser!.domicile, 
            oppositeGender, 
            _currentUser!.id
          );
        }
      }
    } catch (e) {
      print('Error loading baddies: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (direction == CardSwiperDirection.right) {
      final baddie = _baddies[previousIndex];
      ref.read(firestoreServiceProvider).sendLike(
        _currentUser!.id, 
        baddie.id, 
        _currentUser!.firstName
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You liked ${baddie.firstName}!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
    return true;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baddies Near You'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : _baddies.isEmpty
            ? const Center(child: Text('No more baddies in your area!'))
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: CardSwiper(
                      controller: controller,
                      cardsCount: _baddies.length,
                      onSwipe: _onSwipe,
                      isLoop: false,
                      allowedSwipeDirection: const AllowedSwipeDirection.none(), // Disable finger swiping
                      numberOfCardsDisplayed: _baddies.length > 2 ? 3 : _baddies.length,
                      padding: const EdgeInsets.all(24.0),
                      cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage) {
                        final baddie = _baddies[index];
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 8,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              _AutoRotatingImages(imageUrls: baddie.photoUrls),
                              
                              // Gradient for text visibility
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                height: 200,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                                    ),
                                  ),
                                ),
                              ),

                              // Info
                              Positioned(
                                bottom: 20,
                                left: 20,
                                right: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${baddie.firstName} ${baddie.lastName}, ${baddie.age ?? '?'}',
                                            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, color: Colors.white, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          baddie.domicile,
                                          style: const TextStyle(color: Colors.white, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      baddie.bio,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          heroTag: 'dislike',
                          onPressed: () => controller.swipe(CardSwiperDirection.left),
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.close, color: Colors.red, size: 32),
                        ),
                        FloatingActionButton(
                          heroTag: 'like',
                          onPressed: () => controller.swipe(CardSwiperDirection.right),
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.favorite, color: Colors.green, size: 32),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
