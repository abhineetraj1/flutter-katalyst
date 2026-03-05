import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katalyst/database.dart';

void main() {
  runApp(const MyApp());
}

var Name = "";
var Email = "";
var Password = "";
var userID;
var events;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto', // System font, clean and modern
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B4DFF), // Modern Indigo
          primary: const Color(0xFF5B4DFF),
          secondary: const Color(0xFF1A1A1A),
          surface: const Color(0xFFF8F9FE),
          background: const Color(0xFFF8F9FE),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FE),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A1A1A),
            foregroundColor: Colors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF5B4DFF),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF5B4DFF), width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
      home: const Index(),
    );
  }
}

// --- Screens ---

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background design element
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5B4DFF).withOpacity(0.1),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5B4DFF).withOpacity(0.2),
                          blurRadius: 40,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/icon.jpg",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (c, o, s) => const Icon(
                            Icons.rocket_launch,
                            size: 60,
                            color: Color(0xFF5B4DFF)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Katalyst",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Ignite your potential with world-class workshops and events.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUp()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5B4DFF),
                      ),
                      child: const Text("Get Started"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: BorderSide(color: Colors.grey[200]!),
                      ),
                      child: const Text("I already have an account"),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

AlertBox(context, title, message) {
  showDialog(context: context, builder: (context) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text("Ok"))
    ],
  );
  });
}

SmallLoader(context) {
   showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height*0.5,
        child: Center(child: Text("Loading...", style: TextStyle(fontSize: 20),))
      ),
    );
   });
}

EventContainer(context, data) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ViewDetails(id: data["_id"].toString())));
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B4DFF).withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.asset(
                  "assets/event.png",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, o, s) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.image, color: Colors.grey)),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(CupertinoIcons.calendar, size: 14, color: Color(0xFF5B4DFF)),
                      const SizedBox(width: 4),
                      Text(
                        data["date"].toString().split(' - ')[0],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["name"],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: const Color(0xFF5B4DFF),
                      child: Text(
                        data["author"].toString().substring(0, 1).toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Hosted by ${data["author"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewDetails(id: data["_id"].toString())));
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF5B4DFF),
                      side: const BorderSide(color: Color(0xFF5B4DFF)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("View Details"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome back",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Enter your details to access your account.",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  hintText: "Email address",
                  prefixIcon: Icon(CupertinoIcons.mail),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(CupertinoIcons.lock),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    verify(context, email.text, password.text);
                  },
                  child: const Text("Sign In"),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: const Text("Don't have an account? Sign Up"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create account",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Start your journey with Katalyst today.",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Full Name",
                  prefixIcon: Icon(CupertinoIcons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  hintText: "Email address",
                  prefixIcon: Icon(CupertinoIcons.mail),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(CupertinoIcons.lock),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    create(context, name.text, email.text, password.text);
                  },
                  child: const Text("Sign Up"),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text("Already have an account? Sign In"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// --- Main Dashboard with Floating Nav ---

class Dashboard extends StatefulWidget {
  final int initialIndex;
  const Dashboard({super.key, this.initialIndex = 0});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extend body behind nav bar
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: const [
              HomeTab(),
              BookingsTab(),
              HostingTab(),
              ProfileTab(),
            ],
          ),
          // Floating Navigation Bar
          Positioned(
            bottom: 30,
            left: 40,
            right: 40,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavBarItem(
                    icon: CupertinoIcons.house_fill,
                    isSelected: _currentIndex == 0,
                    onTap: () => _onItemTapped(0),
                  ),
                  _NavBarItem(
                    icon: CupertinoIcons.ticket_fill,
                    isSelected: _currentIndex == 1,
                    onTap: () => _onItemTapped(1),
                  ),
                  _NavBarItem(
                    icon: CupertinoIcons.briefcase_fill,
                    isSelected: _currentIndex == 2,
                    onTap: () => _onItemTapped(2),
                  ),
                  _NavBarItem(
                    icon: CupertinoIcons.person_fill,
                    isSelected: _currentIndex == 3,
                    onTap: () => _onItemTapped(3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem(
      {required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}

// --- Tabs ---

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  TextEditingController search = TextEditingController();
  String _selectedFilter = 'All';
  List _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _filterEvents();
  }

  void _filterEvents() {
    if (events == null) return;
    setState(() {
      _filteredEvents = events.where((event) {
        // Search Filter
        bool matchesSearch = event["name"]
            .toString()
            .toLowerCase()
            .contains(search.text.toLowerCase());
        
        // Date Filter
        bool matchesDate = _checkDateFilter(event, _selectedFilter);

        return matchesSearch && matchesDate;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              LoadEvents(context);
            },
            icon: const Icon(CupertinoIcons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: search,
              onChanged: (value) => _filterEvents(),
              decoration: const InputDecoration(
                hintText: "Search for workshops...",
                prefixIcon: Icon(CupertinoIcons.search),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 10),
                  _buildFilterChip('Upcoming'),
                  const SizedBox(width: 10),
                  _buildFilterChip('Live'),
                  const SizedBox(width: 10),
                  _buildFilterChip('Past'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Events",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            if (_filteredEvents.isNotEmpty)
              for (var i in _filteredEvents) EventContainer(context, i)
            else if (events != null && _filteredEvents.isEmpty)
               const Center(
                  child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("No events match your search"),
              ))
            else
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("No events found"),
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedFilter == label,
      onSelected: (bool selected) {
        setState(() {
          _selectedFilter = label;
          _filterEvents();
        });
      },
      selectedColor: const Color(0xFF5B4DFF),
      labelStyle: TextStyle(
        color: _selectedFilter == label ? Colors.white : Colors.black,
      ),
    );
  }
}

class BookingsTab extends StatefulWidget {
  const BookingsTab({super.key});

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  bool loading = true;
  var data;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future loadHistory() async {
    data = await LoadBookedEventsDetails(context);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  List _getFilteredBookings() {
    if (data == null) return [];
    return data.where((event) {
      return _checkDateFilter(event, _selectedFilter);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All'),
                        const SizedBox(width: 10),
                        _buildFilterChip('Upcoming'),
                        const SizedBox(width: 10),
                        _buildFilterChip('Live'),
                        const SizedBox(width: 10),
                        _buildFilterChip('Past'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (data != null && _getFilteredBookings().isNotEmpty)
                    for (var i in _getFilteredBookings()) BookedEventCard(context, i)
                  else
                    const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: Text("No bookings found."),
                        )),
                ],
              ),
            ),
    );
  }

  Widget _buildFilterChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedFilter == label,
      onSelected: (bool selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      selectedColor: const Color(0xFF5B4DFF),
      labelStyle: TextStyle(
        color: _selectedFilter == label ? Colors.white : Colors.black,
      ),
    );
  }
}

class HostingTab extends StatefulWidget {
  const HostingTab({super.key});

  @override
  State<HostingTab> createState() => _HostingTabState();
}

class _HostingTabState extends State<HostingTab> {
  bool loading = true;
  var data;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    loadWorkshops();
  }

  Future loadWorkshops() async {
    data = await LoadMyWorkshops(context);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  List _getFilteredHosting() {
    if (data == null) return [];
    return data.where((event) {
      return _checkDateFilter(event, _selectedFilter);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hosting")),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddWorkshop()));
          },
          backgroundColor: const Color(0xFF5B4DFF),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All'),
                        const SizedBox(width: 10),
                        _buildFilterChip('Upcoming'),
                        const SizedBox(width: 10),
                        _buildFilterChip('Live'),
                        const SizedBox(width: 10),
                        _buildFilterChip('Past'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (data != null && _getFilteredHosting().isNotEmpty)
                    for (var i in _getFilteredHosting()) MyWorkshopContainer(context, i)
                  else
                    const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: Text("No workshops found."),
                        )),
                ],
              ),
            ),
    );
  }

  Widget _buildFilterChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedFilter == label,
      onSelected: (bool selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      selectedColor: const Color(0xFF5B4DFF),
      labelStyle: TextStyle(
        color: _selectedFilter == label ? Colors.white : Colors.black,
      ),
    );
  }
}

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  var data;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    userDetails();
  }

  Future userDetails() async {
    data = await FetchUserInfo(context, Email);
    if (mounted) {
      setState(() {
        loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Index()),
                  (route) => false);
            },
            icon: const Icon(Icons.logout, color: Colors.red),
          )
        ],
      ),
      body: loaded
          ? SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF5B4DFF),
                    child: Icon(CupertinoIcons.person_fill,
                        size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    data["name"],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data["email"],
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 40),
                  _ProfileItem(
                    label: "Name",
                    value: data["name"],
                    onEdit: () => EditPersonalInfoBox(context, "name", data),
                  ),
                  _ProfileItem(
                    label: "Email",
                    value: data["email"],
                    onEdit: () => EditPersonalInfoBox(context, "email", data),
                  ),
                  _ProfileItem(
                    label: "Password",
                    value: "••••••••",
                    onEdit: () =>
                        EditPersonalInfoBox(context, "password", data),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEdit;

  const _ProfileItem(
      {required this.label, required this.value, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500)),
            ],
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(CupertinoIcons.pencil_circle_fill,
                size: 30, color: Color(0xFF5B4DFF)),
          )
        ],
      ),
    );
  }
}

// --- Detail & Edit Screens ---

class ViewDetails extends StatefulWidget {
  final String id;
  const ViewDetails({Key? key, required this.id}) : super(key: key);
  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}
class _ViewDetailsState extends State<ViewDetails> {
  var details;

  @override
  void initState() {
    super.initState();
    fetchDetails(widget.id);
  }

  Future fetchDetails(id) async {
    var info = await EventDetails(context, id);
    setState(() {
      details = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: details != null
          ? CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      "assets/event.png",
                      fit: BoxFit.cover,
                      errorBuilder: (c, o, s) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, size: 50)),
                    ),
                  ),
                  leading: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          details["name"],
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.person,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text("Hosted by ${details["author"]}",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _DetailRow(
                            icon: CupertinoIcons.calendar,
                            text: details["date"]),
                        _DetailRow(
                            icon: CupertinoIcons.time, text: details["timing"]),
                        _DetailRow(
                            icon: CupertinoIcons.location_solid,
                            text: details["address"]),
                        const SizedBox(height: 40),
                        if (details["email"] != Email)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                BookWorkshop(context, userID, details["_id"]);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5B4DFF),
                              ),
                              child: const Text("Book Workshop"),
                            ),
                          )
                        else
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditWorkshop(id: details["_id"])));
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF5B4DFF),
                                side: const BorderSide(
                                    color: Color(0xFF5B4DFF)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text("Edit Workshop"),
                            ),
                          )
                      ],
                    ),
                  ),
                )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xFF5B4DFF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: const Color(0xFF5B4DFF), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class PersonalDetails extends StatefulWidget {
  final String email;
  const PersonalDetails({super.key, required String this.email});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  var data;
  bool a = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetails(widget.email);
  }

  Future userDetails(email) async{
    data = await FetchUserInfo(context, email);
    setState(() {
      a=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Row(
          children: [
            IconButton(onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Dashboard()), (route) => false);
            }, icon: Icon(Icons.arrow_back)),
            SizedBox(width: 10,),
            a? Text(data == null ? "" : data["name"]) : Text("Loading"),
          ],
        )),
        body: a ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft,child: Text("Name", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              Row(
                children: [
                  Text(data["name"], style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: () {
                    EditPersonalInfoBox(context, "name", data);
                  }, icon: Icon(Icons.edit)),
                ],
              ),
              SizedBox(height: 20,),
              Align(alignment: Alignment.centerLeft,child: Text("Email", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              Row(
                children: [
                  Text(data["email"], style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: () {
                    EditPersonalInfoBox(context, "email", data);
                  }, icon: Icon(Icons.edit)),
                ],
              ),
              SizedBox(height: 20,),
              Align(alignment: Alignment.centerLeft,child: Text("Password", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              Row(
                children: [
                  Text("*****", style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: () {
                    EditPersonalInfoBox(context, "password", data);
                  }, icon: Icon(Icons.edit)),
                ],
              ),
            ],
          ),
        ) : Container(height: MediaQuery.sizeOf(context).height,width: MediaQuery.sizeOf(context).width,child: Center(child: Text("Loading", style: TextStyle(fontSize: 30),))),
      ),
    );
  }
}

EditPersonalInfoBox(context, type, data) {
  var editText= new TextEditingController();
  editText.text = data[type];
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Change "+type, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          TextField(
            controller: editText,
            decoration: InputDecoration(
              hintText: "Enter new value",
            ),
          )
        ],
      ),
    actions: [
      TextButton(onPressed: () {
        if (editText.text.length > 1) ChangePersonalInfo(context, Email, type, editText.text);
      }, child: Text("Change")),
      TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text("Cancel"))
    ],
  );
  }
);}

class AddWorkshop extends StatelessWidget {
  const AddWorkshop({super.key});

  @override
  Widget build(BuildContext context) {
    var name = new TextEditingController();
    var date = new TextEditingController();
    var timing = new TextEditingController();
    var address = new TextEditingController();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 10,),
              Text("Add workshop")
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(style: BorderStyle.solid)
                    ),
                    hintText: "Enter your workshop name"
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: date,
                  readOnly: true,
                  onTap: () async {
                    DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.fromSeed(
                              seedColor: const Color(0xFF5B4DFF),
                              primary: const Color(0xFF5B4DFF),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      date.text = "${picked.start.day}/${picked.start.month}/${picked.start.year} - ${picked.end.day}/${picked.end.month}/${picked.end.year}";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(style: BorderStyle.solid)
                    ),
                    hintText: "Select workshop date range",
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: timing,
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? start = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      helpText: "Select Start Time",
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.fromSeed(
                              seedColor: const Color(0xFF5B4DFF),
                              primary: const Color(0xFF5B4DFF),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (start != null && context.mounted) {
                      TimeOfDay? end = await showTimePicker(
                        context: context,
                        initialTime: start,
                        helpText: "Select End Time",
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.fromSeed(
                                seedColor: const Color(0xFF5B4DFF),
                                primary: const Color(0xFF5B4DFF),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (end != null && context.mounted) {
                        timing.text = "${start.format(context)} - ${end.format(context)}";
                      }
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(style: BorderStyle.solid)
                    ),
                    hintText: "Select workshop timings",
                    prefixIcon: const Icon(Icons.access_time),
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(style: BorderStyle.solid)
                    ),
                    hintText: "Enter workshop address"
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: () {
                  AddWorkshopInDatabase(context, name.text, date.text, timing.text, address.text);
                }, child: Text("Add workshop"), style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyWorkshop extends StatefulWidget {
  MyWorkshop({super.key});

  @override
  State<MyWorkshop> createState() => _MyWorkshopState();
}

class _MyWorkshopState extends State<MyWorkshop> {
  bool Loading = true;
  var data = null;

  Future LoadWorkshops() async{
    data = await LoadMyWorkshops(context);
    setState(() {
      Loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    LoadWorkshops();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 10,),
              Text("My Workshops")
            ],
          ),
        ),
        body: Loading ? Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Center(
            child: Text("Loading Details", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          ),
        ) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                for (var i in data) MyWorkshopContainer(context, i)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget MyWorkshopContainer(BuildContext context, dynamic data) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF5B4DFF).withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.asset(
                "assets/event.png",
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (c, o, s) => Container(
                  height: 160,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.image, color: Colors.grey)),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(CupertinoIcons.calendar, size: 14, color: Color(0xFF5B4DFF)),
                    const SizedBox(width: 4),
                    Text(
                      data["date"].toString().split(' - ')[0],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["name"],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(CupertinoIcons.time, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    data["timing"],
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(CupertinoIcons.location_solid, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      data["address"],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewAttendees(eventID: data["_id"])));
                      },
                      icon: const Icon(CupertinoIcons.person_2, size: 18),
                      label: const Text("Attendees"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditWorkshop(id: data["_id"])));
                      },
                      icon: const Icon(CupertinoIcons.pencil, size: 18),
                      label: const Text("Edit"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF5B4DFF),
                        side: const BorderSide(color: Color(0xFF5B4DFF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        DeleteWorkshop(context, data["name"]);
                      },
                      icon: const Icon(CupertinoIcons.trash, size: 18),
                      label: const Text("Delete"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class ViewAttendees extends StatefulWidget {
  final dynamic eventID;
  const ViewAttendees({super.key, required this.eventID});

  @override
  State<ViewAttendees> createState() => _ViewAttendeesState();
}

class _ViewAttendeesState extends State<ViewAttendees> {
  bool loading = true;
  List attendees = [];

  @override
  void initState() {
    super.initState();
    _loadAttendees();
  }

  Future _loadAttendees() async {
    var list = await GetAttendees(context, widget.eventID);
    if (mounted) {
      setState(() {
        attendees = list;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendees"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : attendees.isEmpty
              ? const Center(child: Text("No attendees yet."))
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: attendees.length,
                  itemBuilder: (context, index) {
                    var user = attendees[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      elevation: 0,
                      color: Colors.white,
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(user['name'] ?? 'Unknown'),
                        subtitle: Text(user['email'] ?? 'No Email'),
                      ),
                    );
                  },
                ),
    );
  }
}

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  var Loading= true;
  var data;

  Future LoadHistory() async{
    data = await LoadBookingHistory(context);
    setState(() {
      Loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Dashboard();}));
              }, icon: Icon(Icons.arrow_back)),
              SizedBox(width: 10,),
              Text("Booking History")
            ],
          ),
        ),
        body: Loading ? Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Center(
            child: Text("Loading", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          ),
        ) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                for(var i in data) DisplayEventDetailsById(id: i["eventID"])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayEventDetailsById extends StatefulWidget {
  final String id;
  const DisplayEventDetailsById({super.key, required this.id});

  @override
  State<DisplayEventDetailsById> createState() => _DisplayEventDetailsByIdState();
}

class _DisplayEventDetailsByIdState extends State<DisplayEventDetailsById> {
  bool loading = true;
  var data;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future fetchDetails() async {
    data = await EventDetails(context, widget.id);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return BookedEventCard(context, data);
  }
}

Widget BookedEventCard(BuildContext context, dynamic data) {
  if (data == null) return const SizedBox();

  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF5B4DFF).withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.asset(
                "assets/event.png",
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (c, o, s) => Container(
                  height: 160,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.image, color: Colors.grey)),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(CupertinoIcons.calendar, size: 14, color: Color(0xFF5B4DFF)),
                    const SizedBox(width: 4),
                    Text(
                      data["date"].toString().split(' - ')[0],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["name"],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(CupertinoIcons.time, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    data["timing"],
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(CupertinoIcons.location_solid, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      data["address"],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    CancelWorkshopBooking(context, userID, data["_id"]);
                  },
                  icon: const Icon(CupertinoIcons.clear_circled, size: 18),
                  label: const Text("Cancel Booking"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

bool _checkDateFilter(Map event, String filter) {
  if (filter == 'All') return true;
  try {
    var dates = event['date'].toString().split(' - ');
    var startParts = dates[0].split('/');
    var endParts = dates[1].split('/');
    
    var start = DateTime(int.parse(startParts[2]), int.parse(startParts[1]), int.parse(startParts[0]));
    var end = DateTime(int.parse(endParts[2]), int.parse(endParts[1]), int.parse(endParts[0]), 23, 59, 59);
    var now = DateTime.now();

    if (filter == 'Upcoming') {
      return start.isAfter(now);
    } else if (filter == 'Past') {
      return end.isBefore(now);
    } else if (filter == 'Live') {
      return now.isAfter(start) && now.isBefore(end);
    }
  } catch (e) {
    return false;
  }
  return true;
}

class EditWorkshop extends StatefulWidget {
  final id;
  const EditWorkshop({super.key, required this.id});

  @override
  State<EditWorkshop> createState() => _EditWorkshopState();
}

class _EditWorkshopState extends State<EditWorkshop> {
  bool loading = true;
  var data;

  Future getDetails() async {
    data = await GetEventDetailsById(context, widget.id);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Workshop"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("assets/event.png",
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (c, o, s) => Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image))),
                  ),
                  const SizedBox(height: 20),
                  _EditRow(
                      label: "Name",
                      value: data["name"],
                      onEdit: () => EditWorkshopBox(context, data, "name")),
                  _EditRow(
                      label: "Date",
                      value: data["date"],
                      onEdit: () => EditWorkshopBox(context, data, "date")),
                  _EditRow(
                      label: "Timing",
                      value: data["timing"],
                      onEdit: () => EditWorkshopBox(context, data, "timing")),
                  _EditRow(
                      label: "Address",
                      value: data["address"],
                      onEdit: () => EditWorkshopBox(context, data, "address")),
                ],
              ),
            ),
    );
  }
}

class _EditRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEdit;
  const _EditRow(
      {required this.label, required this.value, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 4),
                Text(value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          IconButton(
              onPressed: onEdit,
              icon: const Icon(CupertinoIcons.pencil, color: Color(0xFF5B4DFF)))
        ],
      ),
    );
  }
}

EditWorkshopBox(context, data, type) {
  var editText = new TextEditingController();
  editText.text = data[type];
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Change "+type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          TextField(
            controller: editText,
            decoration: InputDecoration(
              hintText: "Enter new value",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () {
          if (editText.text.length > 1) ChangeWorkshopInfo(context, data["_id"], type, editText.text);
          else Navigator.of(context).pop();
        }, child: Text("Update")),
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: Text("Cancel")),
      ],
    );
  });
}