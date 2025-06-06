import 'package:flutter/material.dart';
import 'package:fe_hotel/FeHotel/trangChiTietPhong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: 'Phòng đã đặt',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Ưu đãi',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePageBody();
      case 1:
        return const Center(child: Text('Phòng đã đặt'));
      case 2:
        return const Center(child: Text('Ưu đãi'));
      case 3:
        return const Center(child: Text('Tài khoản'));
      default:
        return const Center(child: Text('Trang không tồn tại'));
    }
  }

  Widget _buildHomePageBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Search box
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey),
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
                    context,
                    'assets/images/double-bed.png',
                    'Qua đêm dưới 300k',
                  ),
                  _buildCategory(
                    context,
                    'assets/images/heart.png',
                    'Tình yêu',
                  ),
                  _buildCategory(
                    context,
                    'assets/images/clock.png',
                    'Tặng giờ yêu',
                  ),
                  _buildCategory(
                    context,
                    'assets/images/flash.png',
                    'Giảm tới 50k',
                  ),
                  _buildCategory(
                    context,
                    'assets/images/love-chair.png',
                    'Có ghế tình yêu',
                  ),
                  _buildCategory(
                    context,
                    'assets/images/bath.png',
                    'Bồn tắm quyến rũ',
                  ),
                  _buildCategory(
                    context,
                    'assets/images/key-chain.png',
                    '2H yêu dưới 150k',
                  ),
                  _buildCategory(
                    context,
                    'assets/images/house.png',
                    'Homestay',
                  ),
                  _buildCategory(
                    context,
                    'assets/images/camping.png',
                    'Camping',
                  ),
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
                      context,
                      'assets/images/google-maps.png',
                      'Gần bạn',
                      const Color.fromARGB(255, 134, 216, 184),
                    ),
                    _buildQuickFilter(
                      context,
                      'assets/images/dongHo.png',
                      'Theo giờ',
                      const Color.fromARGB(255, 236, 234, 189),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildQuickFilter(
                      context,
                      'assets/images/bed.png',
                      'Qua đêm',
                      const Color.fromARGB(255, 221, 163, 221),
                    ),
                    _buildQuickFilter(
                      context,
                      'assets/images/lich.png',
                      'Theo ngày',
                      const Color.fromARGB(255, 153, 183, 230),
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RoomDetailPage(room: room),
                        ),
                      );
                    },
                    child: Card(
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
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
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
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String imagePath, String label) {
    return Container(
      width: 60,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Image.asset(imagePath, width: 35, height: 35),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Đã chọn: $label')));
            },
          ),
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

  Widget _buildQuickFilter(
    BuildContext context,
    String iconPath,
    String label,
    Color bgColor,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Đã chọn filter: $label')));
        },
        borderRadius: BorderRadius.circular(10),
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
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
