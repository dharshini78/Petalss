import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PetTherapyPage extends StatefulWidget {
  @override
  _PetTherapyPageState createState() => _PetTherapyPageState();
}

class _PetTherapyPageState extends State<PetTherapyPage>
    with SingleTickerProviderStateMixin {
  String? selectedPet;
  int selectedMinutes = 20;
  late AnimationController _animationController;
  bool isLoading = false;

  final Map<String, String> petImages = {
    'Dog': 'assets/images/golden.jpeg',
    'Cat': 'assets/images/cat.jpeg',
    'Bird': 'assets/images/bird.jpeg',
    'Surprise': 'assets/images/surprise.jpeg',
  };

  final List<int> timeSlots = [20, 30, 45, 60];

  double calculatePrice(int minutes) {
    return 130 + (minutes - 20) * 6.5;
  }

  double calculateGST(double basePrice) {
    return basePrice * 0.18; // 18% GST
  }

  double calculatePlatformFee(double basePrice) {
    return basePrice * 0.05; // 5% platform fee
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _bookPet() {
    if (selectedPet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a pet first')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate loading for 2 seconds then navigate
    Timer(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentDetailsPage(
            petType: selectedPet!,
            minutes: selectedMinutes,
            price: calculatePrice(selectedMinutes),
          ),
        ),
      );
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFF5F5F5), Color(0xFFF0F0F0)],
          ),
        ),
        child: SafeArea(
          child: isLoading ? _buildLoadingScreen() : _buildMainContent(),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF9575CD).withOpacity(0.6 + 0.4 * _animationController.value),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.pets, size: 50, color: Colors.white),
              );
            },
          ),
          SizedBox(height: 24),
          Text(
            'Please wait while we connect you with pet parents...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                'Pet Therapy',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your furry therapist:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                _buildPetSelection(),
                SizedBox(height: 24),
                Text(
                  'Select session duration:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                _buildTimeSelection(),
                SizedBox(height: 24),
                _buildPriceDisplay(),
                SizedBox(height: 32),
                _buildBookButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPetSelection() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: petImages.length,
      itemBuilder: (context, index) {
        String petType = petImages.keys.elementAt(index);
        String imagePath = petImages.values.elementAt(index);

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedPet = petType;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: selectedPet == petType ? Color(0xFF9575CD) : Colors.transparent,
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Text(
                        petType,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  if (selectedPet == petType)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0xFF9575CD),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 16),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeSelection() {
    return Container(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          int minutes = timeSlots[index];
          double price = calculatePrice(minutes);
          String displayText = minutes >= 60 ? '${minutes ~/ 60} hr' : '$minutes mins';

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedMinutes = minutes;
              });
            },
            child: Container(
              width: 100,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: selectedMinutes == minutes ? Color(0xFF9575CD) : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    displayText,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹${price.toStringAsFixed(0)}',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceDisplay() {
    double basePrice = calculatePrice(selectedMinutes);
    double gst = calculateGST(basePrice);
    double platformFee = calculatePlatformFee(basePrice);
    double totalPrice = basePrice + gst + platformFee;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Breakdown',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Base (20 mins)'), Text('₹130')],
          ),
          if (selectedMinutes > 20) ...[
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Extra (${selectedMinutes - 20} mins @ ₹6.5/min)'),
                Text('₹${((selectedMinutes - 20) * 6.5).toStringAsFixed(0)}'),
              ],
            ),
          ],
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Platform Fee (5%)'),
              Text('₹${platformFee.toStringAsFixed(0)}'),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('GST (18%)'), Text('₹${gst.toStringAsFixed(0)}')],
          ),
          Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '₹${totalPrice.toStringAsFixed(0)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9575CD),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookButton() {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _bookPet,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF9575CD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
        child: Text(
          'Book Pet Therapy Session',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PaymentDetailsPage extends StatefulWidget {
  final String petType;
  final int minutes;
  final double price;

  const PaymentDetailsPage({
    Key? key,
    required this.petType,
    required this.minutes,
    required this.price,
  }) : super(key: key);

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool isLoading = false;

  void _proceedToPayment() {
    setState(() {
      isLoading = true;
    });

    // Simulate payment processing for 2 seconds then navigate
    Timer(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PetMapsPage(
            petType: widget.petType,
            minutes: widget.minutes,
            price: widget.price,
          ),
        ),
      );
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
        backgroundColor: Color(0xFF9575CD),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Enter your payment details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _expiryDateController,
                    decoration: InputDecoration(
                      labelText: 'Expiry Date (MM/YY)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _cvvController,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name on Card',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _proceedToPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9575CD),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Proceed to Payment',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class PetMapsPage extends StatefulWidget {
  final String petType;
  final int minutes;
  final double price;

  const PetMapsPage({
    Key? key,
    required this.petType,
    required this.minutes,
    required this.price,
  }) : super(key: key);

  @override
  _PetMapsPageState createState() => _PetMapsPageState();
}

class _PetMapsPageState extends State<PetMapsPage> {
  final DraggableScrollableController _controller = DraggableScrollableController();
  bool _isExpanded = false;
  bool _canCancel = true;

  @override
  void initState() {
    super.initState();

    // Timer for cancellation window
    Timer(Duration(minutes: 2), () {
      setState(() {
        _canCancel = false;
      });
    });
  }

  Map<String, dynamic> getPetDetails() {
    switch (widget.petType) {
      case 'Dog':
        return {
          'name': 'Max',
          'age': '3 years',
          'rating': 4.8,
          'about': 'Max is a friendly and loving Golden Retriever who loves to cuddle and play fetch.',
          'ownerName': 'Rahul',
          'ownerPhone': '+91 9876543210',
        };
      case 'Cat':
        return {
          'name': 'Luna',
          'age': '2 years',
          'rating': 4.6,
          'about': 'Luna is a calm and curious cat who loves gentle pets and purrs loudly.',
          'ownerName': 'Priya',
          'ownerPhone': '+91 9876543211',
        };
      case 'Bird':
        return {
          'name': 'Chirpy',
          'age': '1 year',
          'rating': 4.5,
          'about': 'Chirpy is a colorful and melodious bird who will brighten your day with songs.',
          'ownerName': 'Amir',
          'ownerPhone': '+91 9876543212',
        };
      case 'Surprise':
        return {
          'name': 'Fluffy',
          'age': '4 years',
          'rating': 4.9,
          'about': 'Fluffy is our special surprise pet - you\'ll discover what adorable companion is coming your way!',
          'ownerName': 'Meera',
          'ownerPhone': '+91 9876543213',
        };
      default:
        return {
          'name': 'Buddy',
          'age': '2 years',
          'rating': 4.7,
          'about': 'Buddy is a playful and gentle pet who loves making new friends.',
          'ownerName': 'Sahil',
          'ownerPhone': '+91 9876543214',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final petDetails = getPetDetails();
    final double bottomSheetMinHeight = 0.25;
    final double bottomSheetMaxHeight = 0.8;

    return Scaffold(
      body: Stack(
        children: [
          _buildMapView(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    IconButton(
                      icon: Icon(Icons.support_agent, color: Colors.black),
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: bottomSheetMinHeight,
            minChildSize: bottomSheetMinHeight,
            maxChildSize: bottomSheetMaxHeight,
            controller: _controller,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    setState(() {
                      _isExpanded = notification.extent > bottomSheetMinHeight + 0.05;
                    });
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 12, bottom: 8),
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        _buildPetHeader(petDetails),
                        if (!_isExpanded)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Swipe up for more details',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        if (_isExpanded) ...[
                          _buildTherapyDetails(),
                          _buildContactSection(petDetails),
                          _buildPreferencesSection(),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    final LatLng userPosition = LatLng(12.9716, 77.5946);
    final LatLng petParentPosition = LatLng(12.9796, 77.5906);

    return FlutterMap(
      options: MapOptions(
        cameraConstraint: CameraConstraint.contain(
          bounds: LatLngBounds.fromPoints([userPosition, petParentPosition]),
        ),
        initialCameraFit: CameraFit.bounds(
          bounds: LatLngBounds.fromPoints([userPosition, petParentPosition]),
          padding: EdgeInsets.all(50),
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: userPosition,
              width: 80,
              height: 80,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  Text(
                    'You',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Marker(
              point: petParentPosition,
              width: 80,
              height: 80,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.pets, color: Color(0xFF9575CD), size: 30),
                  ),
                  Text(
                    'Pet Parent',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: [userPosition, petParentPosition],
              strokeWidth: 4.0,
              color: Color(0xFF9575CD).withOpacity(0.7),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPetHeader(Map<String, dynamic> petDetails) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.petType == 'Dog'
                  ? 'assets/images/golden.jpeg'
                  : widget.petType == 'Cat'
                  ? 'assets/images/cat.jpeg'
                  : widget.petType == 'Bird'
                  ? 'assets/images/bird.jpeg'
                  : 'assets/images/surprise.jpeg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      petDetails['name'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFF9575CD).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.petType,
                        style: TextStyle(
                          color: Color(0xFF9575CD),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '${petDetails['rating']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(' • ${petDetails['age']}'),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  petDetails['about'],
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                  maxLines: _isExpanded ? null : 2,
                  overflow: _isExpanded ? null : TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTherapyDetails() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Therapy Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF9575CD).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.access_time, color: Color(0xFF9575CD)),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arriving in 15 minutes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Estimated arrival time: 3:45 PM',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF9575CD).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.timer, color: Color(0xFF9575CD)),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.minutes} minutes session',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total cost: ₹${widget.price.toStringAsFixed(0)}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _canCancel
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Cancel Therapy Session'),
                          content: Text(
                            'Are you sure you want to cancel your pet therapy session?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('NO'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('YES'),
                            ),
                          ],
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _canCancel ? Colors.red.shade50 : Colors.grey.shade200,
                foregroundColor: _canCancel ? Colors.red : Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _canCancel ? 'Cancel Therapy' : 'Cancellation window closed',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (!_canCancel)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'The 2-minute cancellation window has ended',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContactSection(Map<String, dynamic> petDetails) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Pet Parent',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF9575CD).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.person, color: Color(0xFF9575CD)),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    petDetails['ownerName'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    petDetails['ownerPhone'],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildPreferenceCard(
                icon: Icons.volume_off,
                title: 'Do not ring bell',
                isSelected: true,
              ),
              _buildPreferenceCard(
                icon: Icons.pets,
                title: 'Beware of dogs',
                isSelected: false,
              ),
              _buildPreferenceCard(
                icon: Icons.sanitizer,
                title: 'Sanitize hands',
                isSelected: true,
              ),
              _buildPreferenceCard(
                icon: Icons.child_care,
                title: 'Have children',
                isSelected: false,
              ),
            ],
          ),
          SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              hintText: 'Add any special instructions...',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Preferences saved!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9575CD),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Save Preferences',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPreferenceCard({
    required IconData icon,
    required String title,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        // Toggle selection state
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF9575CD).withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFF9575CD) : Colors.transparent,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Color(0xFF9575CD) : Colors.grey,
              size: 20,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Color(0xFF9575CD) : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
