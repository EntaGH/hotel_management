import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, String>> rooms = [
    {
      'name': 'Phòng Tình Yêu',
      'desc': 'Phòng đẹp, sạch sẽ, có ghế tình yêu',
      'price': '200.000 VNĐ/2 giờ',
      'image': 'assets/images/room1.jpg',
    },
    {
      'name': 'Phòng VIP',
      'desc': 'Phòng sang trọng, đầy đủ tiện nghi',
      'price': '500.000 VNĐ/đêm',
      'image': 'assets/images/room2.jpg',
    },
    {
      'name': 'Phòng Tiêu Chuẩn',
      'desc': 'Phòng thoải mái, giá cả phải chăng',
      'price': '300.000 VNĐ/đêm',
      'image': 'assets/images/room3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Love'),
        backgroundColor: Colors.deepOrange[100],
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 187, 99, 146),
        ),
      ),
      backgroundColor: Colors.deepOrange[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search box
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),

            // Horizontal List
            ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(scrollbars: false),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    _buildCategory(
                      'assets/images/double-bed.png',
                      'Qua đêm dưới 300k',
                    ),
                    _buildCategory('assets/images/heart.png', 'Tình yêu'),
                    _buildCategory('assets/images/clock.png', 'Tặng giờ yêu'),
                    _buildCategory('assets/images/flash.png', 'Giảm tới 50k'),
                    _buildCategory(
                      'assets/images/love-chair.png',
                      'Có ghế tình yêu',
                    ),
                    _buildCategory(
                      'assets/images/bath.png',
                      'Bồn tắm quyến rũ',
                    ),
                    _buildCategory(
                      'assets/images/key-chain.png',
                      '2H yêu dưới 150k',
                    ),
                    _buildCategory('assets/images/house.png', 'Homestay'),
                    _buildCategory('assets/images/camping.png', 'Camping'),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),

            // Button grid
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildQuickFilter(
                        'assets/images/google-maps.png',
                        'Gần bạn',
                        Color.fromARGB(255, 134, 216, 184),
                      ),
                      _buildQuickFilter(
                        'assets/images/dongHo.png',
                        'Theo giờ',
                        Color.fromARGB(255, 236, 234, 189),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildQuickFilter(
                        'assets/images/bed.png',
                        'Qua đêm',
                        Color.fromARGB(255, 221, 163, 221),
                      ),
                      _buildQuickFilter(
                        'assets/images/lich.png',
                        'Theo ngày',
                        Color.fromARGB(255, 153, 183, 230),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Room list
            Column(
              children:
                  rooms.map((room) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      elevation: 4,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              child: Image.asset(
                                room['image'] ?? '',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 8.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    room['name'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    room['desc'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    room['price'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String imagePath, String label) {
    return Container(
      width: 60,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 35, height: 35),
          const SizedBox(height: 7),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String iconPath, String label, Color bgColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 35, height: 35),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
